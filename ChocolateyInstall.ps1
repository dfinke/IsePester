try { 
  $tools = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
  $pesterDir = (dir $tools\..\..\Pester*)
    if($pesterDir.length -gt 0) {$pesterDir = $pesterDir[-1]}
  $iseProfile=$profile.Replace("PowerShell_profile","PowerShellISE_profile")
  $profFragment = @"
#####ISEPESTER#####
Import-Module $tools\IsePester.psm1
Import-Module $pesterDir\tools\Pester.psm1
"@
  $newProfile = @()
  $profileWritten=$false
  $toggle=$false
  if(Test-Path $iseProfile) {
      $oldProfile = [string[]](Get-Content $iseProfile)
      foreach($line in $oldProfile) {
          if($line -eq "#####ISEPESTER#####"){
              $toggle=!$toggle
              if($toggle) {
                  $newProfile += $profFragment
                  $profileWritten=$True
              }
          }
          if(!$toggle){$newProfile += $line}
      }
  }
  if(!$profileWritten){
      $newProfile += $profFragment
      $newProfile += "#####ISEPESTER#####"        
  }
  New-Item -Force $iseProfile -type File -value ($newProfile -join "`r`n")

  Write-ChocolateySuccess 'IsePester'
} catch {
  Write-ChocolateyFailure 'IsePester' "$($_.Exception.Message)"
  throw 
}