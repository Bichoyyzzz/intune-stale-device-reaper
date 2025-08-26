function Invoke-WithGraphRetry {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][scriptblock]$ScriptBlock,
        [int]$MaxRetries = 6
    )
    $i = 0
    while ($true) {
        try { return & $ScriptBlock }
        catch {
            $resp = $_.Exception.Response
            if ($resp -and $resp.StatusCode.value__ -eq 429) {
                $retryAfter = $resp.Headers["Retry-After"]
                if (-not $retryAfter) { $retryAfter = [math]::Pow(2, [math]::Min($i, 6)) }
                Start-Sleep -Seconds ([int]$retryAfter)
                if (++$i -ge $MaxRetries) { throw }
            } else { throw }
        }
    }
}
