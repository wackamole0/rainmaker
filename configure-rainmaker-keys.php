#!/usr/bin/env php
<?php

$scriptBasePath = dirname($argv[0]);
$sshConfigDirFullPath = trim(`cd ~/.ssh && pwd`);

if (!is_dir($sshConfigDirFullPath)) {
    mkdir($sshConfigDirFullPath, 0700);
}

copy($scriptBasePath . '/rainmaker-keys/rainmaker_id_rsa', $sshConfigDirFullPath . '/rainmaker_id_rsa');
chmod($sshConfigDirFullPath . '/rainmaker_id_rsa', 0600);
copy($scriptBasePath . '/rainmaker-keys/rainmaker_id_rsa.pub', $sshConfigDirFullPath . '/rainmaker_id_rsa.pub');
chmod($sshConfigDirFullPath . '/rainmaker_id_rsa.pub', 0644);

$sshConfig = '';
if (file_exists($sshConfigDirFullPath . '/config')) {
    $sshConfig = file_get_contents($sshConfigDirFullPath . '/config');
}

$startMarker = '# Rainmaker - Start #';
$endMarker = '# Rainmaker - End #';
$count = 0;
$keyConfigs = <<<EOT
$startMarker
Host *.localdev
  User rainmaker
  IdentityFile ~/.ssh/rainmaker_id_rsa
$endMarker
EOT;

$sshConfig = preg_replace("/$startMarker(?:.+)$endMarker/s", $keyConfigs, $sshConfig, -1, $count);
if ($count < 1) {
    $sshConfig .= "\n$keyConfigs\n";
}

file_put_contents($sshConfigDirFullPath . '/config', $sshConfig);
chmod($sshConfigDirFullPath . '/config', 0600);
