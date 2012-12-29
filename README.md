#Getting Started

You also need Pester installed https://github.com/pester/Pester

Copy .\IsePester.psm1 $env:USERPROFILE\Documents\WindowsPowerShell\Modules\IsePester

Launch ISE

Run or add this to your ISE $Profile
Import-Module Pester, IsePester

#Using IsePester
Once the module is loaded, you can run Pester against a new test script by pressing Ctrl+F5 or navigate to Add-ons|Pester.

You can use IsePester to run a saved script file loaded into ISE. It muset be named to Pester conventions.

e.g. Mytest.Tests.ps1

#Sample Test

```powershell
Describe 'Try Pester' {
    It 'test a fail' { 1/0 }
    It 'test a pass' { $true.should.be($true) }
}
```