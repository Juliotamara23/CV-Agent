# sync-github.ps1
# Synchronizes GitHub repository data into Fuentes/perfil_github.md

$targetFile = "Fuentes/perfil_github.md"
$maxFileSize = 1MB

# 1. Fetch repositories
Write-Host "Fetching repositories..."
$repos = gh repo list --limit 100 --json nameWithOwner,url,description,stargazerCount,forkCount,primaryLanguage,updatedAt | ConvertFrom-Json

$repoData = ""

foreach ($repo in $repos) {
    Write-Host "Processing $($repo.nameWithOwner)..."
    
    # 2. Fetch README
    $readme = ""
    try {
        $readme = gh repo view $repo.nameWithOwner --json readme --jq '.readme' 2>$null
    } catch {
        Write-Host "  No README found for $($repo.nameWithOwner)"
    }

    $achievements = @()
    
    # 3. Extract achievements from README if available
    if ($readme -and $readme.Length -gt 200) {
        # Simple heuristic: find lines with percentages, numbers, or key action verbs
        $lines = $readme -split "`n"
        foreach ($line in $lines) {
            if ($line -match "(\d+%|increased|reduced|improved|saved|optimized|developed|implemented|created)") {
                $cleanLine = $line.Trim(" -*#").Trim()
                if ($cleanLine.Length -gt 10 -and $cleanLine.Length -lt 200) {
                    $achievements += $cleanLine
                }
            }
            if ($achievements.Count -ge 3) { break }
        }
    }

    # 4. Fallback to commits if README is short/empty
    if ($achievements.Count -eq 0) {
        Write-Host "  Falling back to commit history..."
        $commits = gh api repos/$($repo.nameWithOwner)/commits?per_page=15 2>$null | ConvertFrom-Json
        if ($commits) {
            foreach ($commit in $commits) {
                $msg = $commit.commit.message
                if ($msg -match "(fixed|implemented|added|improved|optimized|created)") {
                    $cleanMsg = $msg.Split("`n")[0].Trim()
                    if ($cleanMsg.Length -gt 10) {
                        $achievements += $cleanMsg
                    }
                }
                if ($achievements.Count -ge 3) { break }
            }
        }
    }

    # 5. Format repository entry
    $repoData += "### $($repo.nameWithOwner.Split('/')[1])`n"
    $repoData += "- **Descripción**: $($repo.description)`n"
    $repoData += "- **URL**: $($repo.url)`n"
    $tech = if ($repo.primaryLanguage) { $repo.primaryLanguage.name } else { "N/A" }
    $repoData += "- **Tecnologías**: $tech`n"
    $repoData += "- **Estrellas**: $($repo.stargazerCount) | **Forks**: $($repo.forkCount)`n"
    if ($achievements.Count -gt 0) {
        $repoData += "- **Logros**:`n"
        foreach ($ach in $achievements) {
            $repoData += "  - $ach`n"
        }
    }
    $repoData += "`n"

    # Size Guard check during loop to avoid exceeding 1MB
    if (($repoData.Length + (Get-Item $targetFile).Length) -gt ($maxFileSize - 10KB)) {
        Write-Host "Size limit approaching, stopping repo processing."
        break
    }
}

# 6. Inject into file
Write-Host "Injecting data into $targetFile..."
$content = Get-Content $targetFile -Raw
$pattern = "(?s)<!-- GITHUB_SYNC_START -->.*?<!-- GITHUB_SYNC_END -->"
$replacement = "<!-- GITHUB_SYNC_START -->`n## Repositorios (Sincronizados)`n`n$repoData<!-- GITHUB_SYNC_END -->"

$newContent = [regex]::Replace($content, $pattern, $replacement)

if ($newContent.Length -gt $maxFileSize) {
    Write-Host "Error: Final file would exceed 1MB. Truncating data."
    # Basic truncation if needed
    $newContent = $newContent.Substring(0, [math]::Min($newContent.Length, $maxFileSize - 1))
}

$newContent | Set-Content $targetFile
Write-Host "Sync complete!"
