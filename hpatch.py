import os
import shutil
import subprocess

old_path = r"C:\path\to\old"
hdiff_path = r"C:\path\to\hdiff"
output_path = r"C:\path\to\output"
hpatchz_exe = r"C:\path\to\hpatchz.exe"

os.makedirs(output_path, exist_ok=True)

patch_files = {
    os.path.splitext(file)[0]
    for file in os.listdir(hdiff_path)
    if file.endswith(".hdiff")
}

for file in os.listdir(old_path):
    old_file = os.path.join(old_path, file)
    output_file = os.path.join(output_path, file)

    if file in patch_files:
        patch_path = os.path.join(hdiff_path, file + ".hdiff")
        print(f"Patching: {file}")
        result = subprocess.run(
            [hpatchz_exe, old_file, patch_path, output_file],
            capture_output=True,
            text=True
        )
        if result.returncode != 0:
            print(f"ERROR patching {file}:\n{result.stderr}")
    else:
        print(f"Copying (unchanged): {file}")
        shutil.copy2(old_file, output_file)
