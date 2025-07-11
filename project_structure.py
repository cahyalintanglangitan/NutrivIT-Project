import os

# File yang dianggap penting
important_extensions = ['.php', '.css', '.js', '.py', '.md', '.sql', '.txt']

# Folder yang akan dilewati
ignored_folders = ['.git', 'node_modules', '__pycache__', 'venv', '.idea', '.vscode']

def generate_tree(dir_path, prefix=''):
    entries = sorted(os.listdir(dir_path))
    entries_count = len(entries)

    for index, entry in enumerate(entries):
        path = os.path.join(dir_path, entry)
        connector = '└── ' if index == entries_count - 1 else '├── '

        if os.path.isdir(path):
            if entry in ignored_folders:
                continue  # Skip folder yang diabaikan
            print(f"{prefix}{connector}{entry}/")
            generate_tree(path, prefix + ('    ' if index == entries_count - 1 else '│   '))
        else:
            ext = os.path.splitext(entry)[1]
            if ext in important_extensions:
                print(f"{prefix}{connector}{entry}")

def write_tree_to_file(dir_path, output_file):
    with open(output_file, 'w', encoding='utf-8') as f:
        original_stdout = os.sys.stdout
        os.sys.stdout = f

        print(f"{os.path.basename(dir_path)}/")
        generate_tree(dir_path)

        os.sys.stdout = original_stdout

if __name__ == '__main__':
    project_root = os.getcwd()
    output_file = os.path.join(project_root, 'structure.txt')

    write_tree_to_file(project_root, output_file)
    print(f"✅ Struktur proyek disimpan ke: {output_file}")
