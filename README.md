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

##Sample Test

```powershell
Describe 'Try Pester' {
    It 'tests a fail' { 1/0 }
    It 'tests a pass' { $true.should.be($true) }
}
```

![alt-text](https://raw.github.com/dfinke/IsePester/master/RunningPesterInISE.png "ISE and Pester" )

Feature
===
[Ian Davis](https://github.com/dfinke/IsePester/issues/2) suggested, when working on foo.ps1 with tests in foo.tests.ps1 in the same directory, triggering the Pester shortcut while in foo.ps1, the tool should look for foo.tests.ps1 and run it if it exists; otherwise, run the current file.

[This is now implemented.](https://github.com/dfinke/IsePester/blob/e351376aa59f95f7d3ababa21859a49d57a42e2a/IsePester.psm1)