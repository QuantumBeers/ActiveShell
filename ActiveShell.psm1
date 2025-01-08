# ActiveShell.psm1


# Core Framework Functions

# Function: Get-NounVerbTruth
# Purpose: A core logic function to extract entities, relationships, and dynamics

# Graph Management
#	1.	Create-ActiveGraph
#	•	Initializes a new ActiveGraph.
#	•	Metadata includes name, type (e.g., JSON), and other optional fields.
function Create-ActiveGraph {
    param (
        [Parameter(Mandatory)][string]$GraphName,
        [Parameter(Mandatory)][string]$Type = "JSON",
        [Parameter()][hashtable]$Metadata
    )

    $Global:ActiveGraph = [PSCustomObject]@{
        Name     = $GraphName
        Type     = $Type
        Metadata = $Metadata
        Nodes    = @()  # Initialize as an empty array
        Edges    = @()  # Initialize as an empty array
    }

    Write-Output "ActiveGraph '$GraphName' created successfully."
}



# Node Management
#	2.	Add-Node
#	•	Adds a node with metadata, parent-child relationships, and domain specifications.
function Add-Node {
    param (
        [Parameter(Mandatory)][string]$NodeName,
        [Parameter()][string]$Type,
        [Parameter()][string]$Domain,
        [Parameter()][string]$Parent,
        [Parameter()][string]$Child,
        [Parameter()][hashtable]$Metadata
    )

    $ExistingNode = $ActiveGraph.Nodes | Where-Object { $_.Name -eq $NodeName }

    if ($ExistingNode) {
        Write-Output "Node '$NodeName' already exists."
    } else {
        $NewNode = [PSCustomObject]@{
            Name     = $NodeName
            Type     = $Type
            Domain   = $Domain
            Parent   = $Parent
            Child    = $Child
            Metadata = $Metadata ?? @{}  # Default to an empty hashtable
        }

        $Global:ActiveGraph.Nodes += $NewNode
        Write-Output "Node '$NodeName' added successfully."
    }
}
#
# 3.	Get-Node
# •	Returns node data for a specific name or filters by metadata.
function Get-Node {
    param (
        [Parameter()][string]$NodeType,  # Optional type filter (e.g., "Pharmacy")
        [Parameter()][string]$NodeName, # Optional name filter
        [Parameter()][scriptblock]$Filter # Dynamic filter block
    )

    # Filter nodes based on parameters
    $FilteredNodes = $ActiveGraph.Nodes

    if ($NodeType) {
        $FilteredNodes = $FilteredNodes | Where-Object { $_.Type -eq $NodeType }
    }

    if ($NodeName) {
        $FilteredNodes = $FilteredNodes | Where-Object { $_.Name -eq $NodeName }
    }

    if ($Filter) {
        $FilteredNodes = $FilteredNodes | Where-Object $Filter
    }

    # Return filtered results
    if ($FilteredNodes.Count -eq 0) {
        Write-Output "No nodes found matching the criteria."
    } else {
        return $FilteredNodes
    }
}



#	4.	Set-Node
#	•	Modifies an existing node’s metadata or relationships.
function Set-Node {
    param (
        [Parameter(Mandatory)][string]$NodeName,
        [Parameter()][string]$Type,
        [Parameter()][string]$Domain,
        [Parameter()][hashtable]$Metadata
    )

    # Find the node
    $Node = $ActiveGraph.Nodes | Where-Object { $_.Name -eq $NodeName }

    if ($Node) {
        # Update core properties
        if ($Type) { $Node.Type = $Type }
        if ($Domain) { $Node.Domain = $Domain }

        # Ensure Metadata exists and is a hashtable
        if (-not $Node.PSObject.Properties.Match('Metadata').Count -or -not ($Node.Metadata -is [hashtable])) {
            $Node | Add-Member -MemberType NoteProperty -Name Metadata -Value @{} -Force
        }

        # Update Metadata properties
        if ($Metadata) {
            foreach ($Key in $Metadata.Keys) {
                $Node.Metadata[$Key] = $Metadata[$Key]
            }
        }

        Write-Output "Node '$NodeName' updated successfully."
    } else {
        Write-Output "Node '$NodeName' not found."
    }
}

#5.	Delete-Node
#•	Removes a node and associated edges.
function Delete-Node {
    param (
        [Parameter(Mandatory)][string]$NodeName
    )

    $Global:ActiveGraph.Nodes = $ActiveGraph.Nodes | Where-Object { $_.Name -ne $NodeName }
    $Global:ActiveGraph.Edges = $ActiveGraph.Edges | Where-Object { $_.Source -ne $NodeName -and $_.Target -ne $NodeName }

    Write-Output "Node '$NodeName' and its relationships deleted successfully."
}


#Edge Management
#	6.	Create-Edge
#	•	Defines relationships between nodes with timestamps.
function Create-Edge {
    param (
        [Parameter(Mandatory)][string]$Source,
        [Parameter(Mandatory)][string]$Target,
        [Parameter(Mandatory)][string]$Relationship,
        [Parameter()][DateTime]$Timestamp = (Get-Date)
    )

    if (-not $ActiveGraph.Edges) {
        $Global:ActiveGraph.Edges = @()  # Ensure edges array is initialized
    }

    $NewEdge = [PSCustomObject]@{
        Source       = $Source
        Target       = $Target
        Relationship = $Relationship
        Timestamp    = $Timestamp
    }

    $Global:ActiveGraph.Edges += $NewEdge  # Append new edge
    Write-Output "Edge from '$Source' to '$Target' added successfully."
}


#7.	Get-Edge
#•	Retrieves edges with optional filters by source, target, or relationship.
function Get-Edge {
    param (
        [Parameter()][string]$Source,         # Filter by source node
        [Parameter()][string]$Target,         # Filter by target node
        [Parameter()][string]$Relationship,  # Filter by relationship type
        [Parameter()][scriptblock]$Filter    # Custom filter logic
    )

    # Start with all edges
    $Edges = $ActiveGraph.Edges

    # Apply standard filters
    if ($Source) {
        $Edges = $Edges | Where-Object { $_.Source -eq $Source }
    }
    if ($Target) {
        $Edges = $Edges | Where-Object { $_.Target -eq $Target }
    }
    if ($Relationship) {
        $Edges = $Edges | Where-Object { $_.Relationship -eq $Relationship }
    }

    # Apply custom filter if provided
    if ($Filter) {
        $Edges = $Edges | Where-Object $Filter
    }

    # Handle cases with no matches
    if ($Edges.Count -eq 0) {
        Write-Output "No edges found matching the criteria."
    } else {
        return $Edges
    }
}


#8.	Set-Edge
#•	Modifies edge attributes or relationships.
function Set-Edge {
    param (
        [Parameter(Mandatory)][string]$Source,
        [Parameter(Mandatory)][string]$Target,
        [Parameter()][string]$NewRelationship,
        [Parameter()][DateTime]$NewTimestamp = (Get-Date)
    )

    $Edge = $ActiveGraph.Edges | Where-Object { $_.Source -eq $Source -and $_.Target -eq $Target }

    if ($Edge) {
        # Find and update the specific edge
        foreach ($Item in $ActiveGraph.Edges) {
            if ($Item.Source -eq $Source -and $Item.Target -eq $Target) {
                if ($NewRelationship) { $Item.Relationship = $NewRelationship }
                $Item.Timestamp = $NewTimestamp
            }
        }
        Write-Output "Edge updated successfully."
    } else {
        Write-Output "Edge not found."
    }

    # Remove duplicates, if any
    $ActiveGraph.Edges = $ActiveGraph.Edges | Sort-Object Source, Target -Unique
}

function Get-All-Nodes {
    param ()

    # Collect unique nodes from the ActiveGraph data
    $UniqueNodes = @()

    foreach ($Edge in $ActiveGraph.Edges) {
        if (-not $UniqueNodes.Contains($Edge.Source)) {
            $UniqueNodes += $Edge.Source
        }
        if (-not $UniqueNodes.Contains($Edge.Target)) {
            $UniqueNodes += $Edge.Target
        }
    }

    if ($UniqueNodes.Count -eq 0) {
        Write-Output "No nodes found in the graph."
    } else {
        return $UniqueNodes
    }
}

function Get-All-Edges {
    param ()

    # Check if there are any edges in the graph
    if ($ActiveGraph.Edges.Count -eq 0) {
        Write-Output "No edges found in the graph."
    } else {
        return $ActiveGraph.Edges
    }
}

function Export-Graph {
    param (
        [Parameter(Mandatory)][string]$FilePath
    )
    $ActiveGraph | ConvertTo-Json -Depth 10 | Set-Content -Path $FilePath
    Write-Output "Graph exported to $FilePath"
}

function Import-Graph {
    param (
        [Parameter(Mandatory)][string]$FilePath
    )
    $Global:ActiveGraph = Get-Content -Path $FilePath | ConvertFrom-Json
    Write-Output "Graph imported from $FilePath"
}

Export-ModuleMember -Function Create-ActiveGraph, Add-Node, Get-Node, Set-Node, Delete-Node, Create-Edge, Get-Edge, Set-Edge, Get-All-Nodes, Get-All-Edges