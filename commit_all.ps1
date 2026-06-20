$files = git status -s -uall | ForEach-Object { $_.Trim() }

foreach ($line in $files) {
    if ([string]::IsNullOrWhiteSpace($line)) { continue }
    # format of git status -s is "XY filename"
    # XY can be " M", "M ", "??", " D", etc.
    if ($line -match "^(.{1,2})\s+(.*)$") {
        $status = $matches[1]
        $file = $matches[2]
        
        # remove quotes from file name if any
        $file = $file -replace '^"|"$', ''
        
        if ($file -match "test/widget_test.dart") {
            $msg = "chore: hapus file test bawaan"
            git rm $file
        } elseif ($file -match "pubspec") {
            $msg = "chore: penyesuaian dependensi pubspec"
            git add $file
        } elseif ($file -match "app_colors|app_theme|app_text_styles") {
            $msg = "feat: penambahan tema aplikasi"
            git add $file
        } elseif ($file -match "dashboard") {
            $msg = "feat: pembuatan modul dashboard"
            git add $file
        } elseif ($file -match "medical_record") {
            $msg = "feat: pembuatan modul rekam medis"
            git add $file
        } elseif ($file -match "prescription") {
            $msg = "feat: pembuatan modul resep online"
            git add $file
        } elseif ($file -match "schedule_profile") {
            $msg = "feat: pembuatan modul jadwal dan profil"
            git add $file
        } elseif ($file -match "main_nav") {
            $msg = "feat: pembuatan navigasi utama"
            git add $file
        } elseif ($file -match "models") {
            $msg = "feat: penambahan model data"
            git add $file
        } elseif ($file -match "repositories") {
            $msg = "feat: penambahan repositori data"
            git add $file
        } elseif ($file -match "mock") {
            $msg = "chore: penambahan data mock"
            git add $file
        } elseif ($file -match "teleconsult_repository.dart") {
            $msg = "chore: hapus file tidak terpakai"
            git add $file
        } else {
            $msg = "chore: penyesuaian sistem file"
            git add $file
        }
        
        $basename = Split-Path $file -Leaf
        $finalMsg = "$msg ($basename)"
        
        git commit -m "$finalMsg"
    }
}
git push
