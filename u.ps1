powershell -Command "
if(-not([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(544)){Write-Host 'Run as admin!' -f Red;exit}
$u='https://raw.githubusercontent.com/DRSDavidSoft/additional-hosts/refs/heads/master/domains/blacklist/activation.txt'
$u='https://raw.githubusercontent.com/ethanaicode/Adobe-Block-Hosts-List/refs/heads/main/host'
$p='$env:SystemRoot\System32\drivers\etc\hosts' -f $env:SystemRoot
$b=$p+'.backup'
$t='$env:TEMP\h.tmp' -f $env:TEMP
$l='$env:TEMP\hosts_update_'+(Get-Date -f yyyyMMdd_HHmmss)+'.log'
iwr $u -OutFile $t -UseBasicParsing
if(!(Test-Path $t)){Write-Host 'Download failed.' -f Red;exit}
cp $p $b -Force
$o=gc $p|?{$_ -notmatch '^\s*(#|$)'}
$n=gc $t|?{$_ -notmatch '^\s*(#|$)'}
$m=($o+$n|sort -u)
$m|sc $p
'['+(Get-Date)+'] Hosts updated. Entries: '+$m.Count+'`nBackup: '+$b+'`nSource: '+$u+'`n'+($m -join \"`n\")|sc $l
Write-Host 'Done. Hosts updated, backup created, log saved:' $l -f Green
$r=Read-Host 'Create daily task to auto-update hosts file? (y/n)'
if($r -eq 'y'){
  $a='powershell.exe'
  $x='-windowstyle hidden -Command `"irm '+$u+'|iex`"'
  schtasks /Create /F /RL HIGHEST /SC DAILY /TN UpdateHostsDaily /TR \"$a $x\" /ST 13:00
  Write-Host 'Scheduled task created.' -f Cyan
}"
