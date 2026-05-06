import argparse
import os
import json
import collections

def compute_fingerprint(text, n=3):
    """Computes a simple fingerprint based on character n-grams."""
    text = text.lower().replace(" ", "").replace("\n", "")
    ngrams = [text[i:i+n] for i in range(len(text)-n+1)]
    return collections.Counter(ngrams)

def deduplicate_entries(entries):
    """Identifies duplicate entries based on fingerprint similarity."""
    duplicates = []
    seen_fingerprints = {}
    
    for entry in entries:
        fp = compute_fingerprint(entry['content'])
        
        # Simple similarity check (could be refined to Jaccard index)
        is_duplicate = False
        for seen_fp, original_entry in seen_fingerprints.items():
            # Check overlap
            total_elements = sum(fp.values())
            if total_elements == 0: continue
            
            intersection = fp & seen_fp
            overlap = sum(intersection.values()) / total_elements
            
            if overlap > 0.8: # Threshold for similarity
                is_duplicate = True
                duplicates.append({'entry': entry['path'], 'duplicate_of': original_entry['path']})
                break
        
        if not is_duplicate:
            seen_fingerprints[frozenset(fp.items())] = entry
            
    return duplicates

def main():
    parser = argparse.ArgumentParser(description="Check for duplicates in source files.")
    parser.add_argument("--input-dir", required=True, help="Input directory")
    parser.add_argument("--output", required=True, help="Output report file")
    parser.add_argument("--fail-on-duplicates", action="store_true", help="Fail if duplicates found")
    args = parser.parse_args()
    
    entries = []
    for filename in os.listdir(args.input_dir):
        if filename.endswith(".md"):
            with open(os.path.join(args.input_dir, filename), "r", encoding="utf-8") as f:
                entries.append({'path': filename, 'content': f.read()})
                
    duplicates = deduplicate_entries(entries)
    
    with open(args.output, "w", encoding="utf-8") as f:
        json.dump(duplicates, f, indent=4)
        
    if args.fail_on_duplicates and duplicates:
        print(f"Duplicates found: {len(duplicates)}")
        exit(1)
        
    print("No duplicates found or check passed.")

if __name__ == "__main__":
    main()
