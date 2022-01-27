# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License.
using module .\..\Common\Common.psm1
using module .\..\Rule\Rule.psm1

<#
    .SYNOPSIS
        A SharePoint WebAppGeneralSettings Rule object
    .DESCRIPTION
        The SharePointRule class is used to manage SharePoint STIG rule settings.
    .PARAMETER PropertyName
        The PropertyName content
#>
class SharePointSPLogLevelRule : Rule
{
    [array]$SPLogLevelItems

    <#
        .SYNOPSIS
            Default constructor to support the AsRule cast method
    #>
    SharePointSPLogLevelRule ()
    {
    }

    <#
        .SYNOPSIS
            Used to load PowerSTIG data from the processed data directory
        .PARAMETER Rule
            The STIG rule to load
    #>
    SharePointSPLogLevelRule ([xml.xmlelement] $Rule) : base ($Rule)
    {
    }

    <#
        .SYNOPSIS
            The Convert child class constructor
        .PARAMETER Rule
            The STIG rule to convert
        .PARAMETER Convert
            A simple bool flag to create a unique constructor signature
    #>
    SharePointSPLogLevelRule ([xml.xmlelement] $Rule, [switch] $Convert) : base ($Rule, $Convert)
    {
    }

    <#
        .SYNOPSIS
            Creates class specific help content
    #>
    [PSObject] GetExceptionHelp()
    {
        return @{
            Value = "15"
            Notes = $null
        }
    }
}
