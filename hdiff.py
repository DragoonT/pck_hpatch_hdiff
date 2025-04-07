import os
import subprocess

old_path = r"C:\path\to\old"
hdiff_path = r"C:\path\to\hdiff"
output_path = r"C:\path\to\output"
hdiffz_exe = r"C:\path\to\hdiffz.exe"

os.makedirs(output_path, exist_ok=True)

for file in os.listdir(hdiff_path):
    if file.endswith(".hdiff"):
        base_name = file[:-6]
        old_file = os.path.join(old_path, base_name)
        new_file = os.path.join(hdiff_path, file)
        patch_file = os.path.join(output_path, base_name)

        if os.path.exists(old_file):
            print(f"Patching: {base_name}")

            os.makedirs(os.path.dirname(new_file), exist_ok=True)

            result = subprocess.run(
                [hdiffz_exe, "-f", old_file, new_file, patch_file],
                capture_output=True,
                text=True
            )

            if result.returncode != 0:
                print(f"ERROR patching {base_name}:\n{result.stderr}")
        else:
            print(f"Skipping {file}: {base_name} not found in old path.")
