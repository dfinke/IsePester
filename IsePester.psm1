function Add-PesterMenu {

    $sb = {
    
        if(!$psISE.CurrentFile.IsUntitled) {
            $fileName = $psISE.CurrentFile.FullPath
            $psISE.CurrentFile.Save()
        } else {
            
            $fileName = [io.path]::GetTempFileName().Replace(".tmp", ".tests.ps1")
            $psISE.CurrentFile.Editor.Text | Set-Content -Path $fileName 
        }

        Import-Module Pester

        Write-Debug $fileName

        cls
        Invoke-Pester -relative_path $fileName

        if(!$psISE.CurrentFile.IsSaved) { Remove-Item $fileName -Force -ErrorAction SilentlyContinue }
    }
    
    Remove-PesterMenu
    [void]$psISE.CurrentPowerShellTab.AddOnsMenu.Submenus.Add("_Pester", $sb, "CTRL+F5") 
}

function Get-PesterMenu {

    $psISE.CurrentPowerShellTab.AddOnsMenu.Submenus | 
        Where DisplayName -Match "pester"
}

function Remove-PesterMenu {

    $menu = Get-PesterMenu
    if($menu) {
        [void]$psISE.CurrentPowerShellTab.AddOnsMenu.Submenus.Remove($menu)
    }
}

Add-PesterMenu