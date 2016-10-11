function Add-PesterMenu {
    Remove-PesterMenu
    [void]$psISE.CurrentPowerShellTab.AddOnsMenu.Submenus.Add("_Pester", {IsePester\Invoke-IsePester}, "CTRL+F5")
}

function Get-PesterMenu {

    $psISE.CurrentPowerShellTab.AddOnsMenu.Submenus | 
        Where {$_.DisplayName -Match "pester"}
}

function Remove-PesterMenu {

    $menu = Get-PesterMenu
    if($menu) {
        [void]$psISE.CurrentPowerShellTab.AddOnsMenu.Submenus.Remove($menu)
    }
}

function Invoke-IsePester
{
    if(!$psISE.CurrentFile.IsUntitled) {
        $psISE.CurrentFile.Save()

        $fileName = $psISE.CurrentFile.FullPath

        if($filename -notmatch '\.tests\.') {

            $parts = $filename -split '\.'
            $testFilename = "{0}.tests.ps1" -f ($parts[0..($parts.Count-2)] -join '.')

            Write-debug $testFilename

            if(Test-Path $testFilename) {
                $filename = $testFilename
            }else{
                # Look for tests in a tests subfolder
                $folder = join-path -path (split-path $fileName -Parent) -ChildPath Tests
                
                $parts = (split-path $fileName -Leaf) -split '\.'
                $testfile = "$($parts[0]).tests.$($parts[1])"
                
                $testFileName = Join-Path -path $folder -ChildPath $testFile
                # Check file exists
                if(Test-Path $testFileName) {
                    $filename = $testFileName
                }
            
            }

            Write-debug $filename
        }

    } else {
        $fileName = [io.path]::GetTempFileName().Replace(".tmp", ".tests.ps1")
        $psISE.CurrentFile.Editor.Text | Set-Content -Path $fileName
    }

    Import-Module Pester

    Write-Debug $fileName
    Invoke-Pester -relative_path $fileName

    if(!$psISE.CurrentFile.IsSaved) { Remove-Item $fileName -Force -ErrorAction SilentlyContinue }
}

Add-PesterMenu
