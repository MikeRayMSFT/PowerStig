#region Header
. $PSScriptRoot\.tests.header.ps1
#endregion

try
{
    $testCases = @(
        @{
            SPAlternateUrlItem = $null 
            DscResource     = 'SPAlternateUrl'
            SSLSettingsValue = 'Ssl,SslRequireCert'
            CheckContent    = "Review the SharePoint server configuration to ensure the confidentiality of information during aggregation, packaging, and transformation in preparation for transmission is maintained.

            In SharePoint Central Administration, click Application Management.
            
            On the Application Management page, in the Web Applications list, click Manage web applications.
            
            On the Web Applications Management page, verify that each Web Application URL begins with https.
            
            If the URL does not begin with https, this is a finding.
            
            If SharePoint communications between all components and clients are protected by alternative physical measures that have been approved by the AO, this is not a finding."
            ConversionStatus = 'pass'
        },
        @{
            SPAlternateUrlItem = $null 
            DscResource     = 'SPAlternateUrl'
            SSLSettingsValue = 'Ssl,SslRequireCert'
            CheckContent    = "Review the SharePoint server to ensure cryptographic mechanisms preventing the unauthorized disclosure of information during transmission are employed, unless the transmitted data is otherwise protected by alternative physical measures.

            In SharePoint Central Administration, click Application Management.
            
            On the Application Management page, in the Web Applications list, click Manage web applications.
            
            On the Web Applications Management page, verify that each Web Application URL begins with https.
            
            If the URL does not begin with https, this is a finding.
            
            If SharePoint communications between all components and clients are protected by alternative physical measures that have been approved by the AO, this is not a finding."
            ConversionStatus = 'pass'
        },
        @{
            SPAlternateUrlItem = $null 
            DscResource     = 'SPAlternateUrl'
            SSLSettingsValue = 'Ssl,SslRequireCert'
            CheckContent    = 'Review the SharePoint server configuration to ensure approved cryptography is being utilized to protect the confidentiality of remote access sessions.

            Navigate to Central Administration.
            
            Under “System Settings”, click “Configure Alternate Access mappings”.
            
            Review the “Public URL for zone” column values. If any URL does not begin with “https”, this is a finding.'
            ConversionStatus = 'pass'
        },
        @{
            SPAlternateUrlItem = $null 
            DscResource     = 'SPAlternateUrl'
            SSLSettingsValue = 'Ssl,SslRequireCert'
            CheckContent    = 'Review the SharePoint server configuration to ensure SSL Mutual authentication of both client and server during the entire session.

            Navigate to Central Administration.
            
            Under “System Settings”, click “Configure Alternate Access mappings”.
            
            Review the “Public URL for zone” column values. If any URL does not begin with “https”, this is a finding.'
            ConversionStatus = 'pass'
        },
        @{
            SPAlternateUrlItem = $null 
            DscResource     = 'SPAlternateUrl'
            SSLSettingsValue = 'Ssl,SslRequireCert'
            CheckContent    = 'Review the SharePoint server configuration to ensure cryptography is being used to protect the integrity of the remote access session.

            Navigate to Central Administration.
            
            Under “System Settings”, click “Configure Alternate Access mappings”.
            
            Review the “Public URL for zone” column values. If any URL does not begin with “https”, this is a finding.'
            ConversionStatus = 'pass'
        }
    )

    Describe 'SPAlternateUrl with Multiple Service Rule Conversion' {
        foreach ($testCase in $testCases)
        {
            [xml] $stigRule = Get-TestStigRule -CheckContent $testCase.checkContent -XccdfTitle 'MS SharePoint 2013 Security Technical Implementation Guide'
            $TestFile = Join-Path -Path $TestDrive -ChildPath 'TextData.xml'
            $stigRule.Save( $TestFile )
            $rule = ConvertFrom-StigXccdf -Path $TestFile

            It 'Should return Multiple ServiceRule Objects' {
                $rule.Count | Should Be 2
            }
    
            Context 'First Split Rule' {
    
                $rule = $rule[0]
    
                It 'Should return an ServiceRule Object' {
                    $rule.GetType() | Should Be 'SPAlternateUrlRule'
                }
                It "Should return SPAlternate Url Item:'$($testCase.SPAlternateUrlItem)'" {
                    $rule.SPAlternateUrlItem | Should Be $testCase.SPAlternateUrlItem
                }
                It "Should set the correct DscResource" {
                    $rule.DscResource | Should Be 'SPAlternateUrl'
                }
                It 'Should set the status to pass' {
                    $rule.conversionstatus | Should be 'pass'
                }
            }
    
            Context 'Second Split Rule' {
    
                $rule = $rule[1]
    
                It 'Should return an SSLSettingsRule Object' {
                    $rule.GetType() | Should Be 'SSLSettingsRule'
                }
                It "Should return Value:'$($testCase.SSLSettingsValue)'" {
                    $rule.Value | Should Be $testCase.SSLSettingsValue
                }
                It "Should set the correct DscResource" {
                    $rule.DscResource | Should Be 'xSSLSettings'
                }
                It 'Should set the status to pass' {
                    $rule.conversionstatus | Should be 'pass'
                }
            }
        }
    }
}
finally
{
    . $PSScriptRoot\.tests.footer.ps1
}
