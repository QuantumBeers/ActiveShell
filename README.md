# ActiveShell 🚀

**ActiveShell** is a dynamic PowerShell module for creating, managing, and querying relational graphs. Designed for versatility, scalability, and real-world application, ActiveShell brings **relational intelligence** to the forefront of data management. Whether you're modeling complex networks or exploring novel data relationships, ActiveShell is your playground for innovation.

---

## 🔥 **Features**

- **Dynamic Graph Management**:
  - Add, update, and delete nodes and edges effortlessly.
- **Rich Metadata Support**:
  - Attach custom attributes to nodes and edges for advanced querying.
- **Powerful Querying**:
  - Leverage PowerShell's pipeline to filter and analyze relational data.
- **Persistence**:
  - Export and import graphs seamlessly for continuity and sharing.
- **Flexible Use Cases**:
  - From healthcare networks to supply chains, ActiveShell adapts to your needs.

---

## 🚀 **Getting Started**

### **1. Import the Module**

```powershell
Import-Module ./ActiveShell.psm1 -Force
```

### **2. Create a New Graph**

```powershell
Create-ActiveGraph -GraphName "MyGraph" -Type "JSON" -Metadata @{ Creator = "Callum"; Date = (Get-Date) }
```

### **3. Add Nodes**

```powershell
Add-Node -NodeName "PharmacyA" -Type "Pharmacy" -Domain "Healthcare" -Metadata @{ Rating = 4.8; Address = "123 Meds St" }
Add-Node -NodeName "PharmacyB" -Type "Pharmacy" -Domain "Healthcare" -Metadata @{ Rating = 4.9; Address = "789 Meds Lane" }
```

### **4. Create Relationships (Edges)**

```powershell
Create-Edge -Source "PharmacyA" -Target "PharmacyB" -Relationship "PartnersWith"
```

### **5. Query the Graph**

#### Retrieve all nodes:

```powershell
Get-All-Nodes
```

#### Retrieve pharmacies with a rating > 4.5:

```powershell
Get-Node -NodeType "Pharmacy" | Where-Object { $_.Metadata['Rating'] -gt 4.5 }
```

---

## 🛠 **Core Functions**

### **Graph Management**

- `Create-ActiveGraph`: Initializes a new graph.
- `Export-Graph`: Saves the graph to a file.
- `Import-Graph`: Loads a graph from a file.

### **Node Management**

- `Add-Node`: Adds a node with metadata and relationships.
- `Get-Node`: Retrieves nodes based on filters.
- `Set-Node`: Updates node attributes, type, domain, or metadata.
- `Delete-Node`: Deletes a node and its associated edges.

### **Edge Management**

- `Create-Edge`: Creates a relationship between two nodes.
- `Get-Edge`: Retrieves edges with optional filters.
- `Set-Edge`: Updates edge attributes or relationships.
- `Delete-Edge`: Removes a specific edge.

---

## 🌐 **Use Cases**

### **1. Healthcare Networks**

Map relationships between patients, pharmacies, and PBMs:

```powershell
Create-Edge -Source "PatientA" -Target "PharmacyA" -Relationship "GetsMedsFrom"
Create-Edge -Source "PharmacyA" -Target "PBMA" -Relationship "WorksWith"
```

### **2. Supply Chains**

Track dependencies between manufacturers, distributors, and retailers:

```powershell
Create-Edge -Source "ManufacturerA" -Target "DistributorA" -Relationship "Supplies"
Create-Edge -Source "DistributorA" -Target "RetailerA" -Relationship "DeliversTo"
```

### **3. Social Networks**

Analyze connections between individuals, organizations, and communities:

```powershell
Create-Edge -Source "UserA" -Target "UserB" -Relationship "FriendsWith"
Create-Edge -Source "UserB" -Target "OrganizationA" -Relationship "MemberOf"
```

---

## 🤔 **Why ActiveShell?**

- **Dynamic and Scalable**:
  - Built to handle complex relational data.
- **Native PowerShell**:
  - Seamlessly integrates with your existing workflows.
- **Endlessly Flexible**:
  - From analytics to visualization, the possibilities are limitless.
- **Proven Frameworks**:
  - Powered by relational intelligence and groundbreaking concepts like Cube4D and Active Graph Networks.

---

## ✨ **Future Enhancements**

- **Graph Visualization**: Integration with tools like `matplotlib` or `D3.js`.
- **API Support**: Connect to external systems for automated data ingestion.
- **Advanced Querying**: Add fuzzy matching, regex, and semantic search.

---

## 💬 **Get Involved**

Have questions, feedback, or ideas? Reach out to:

- **Callum Maystone**
  Founder, Innovator, and Builder
  
  [LinkedIn](https://www.linkedin.com/in/callum-maystone-57b00932/)

  [Medium](https://medium.com/the-first-digit/slappai-active-graphs-the-foundation-of-intelligence-89ec758005bc)

  [Kaggle](https://www.kaggle.com/callummaystone)

  [GitHub](https://github.com/QuantumBeers/ActiveShell)

  [Twitter](https://x.com/PeoplesGoose)

(In the middle of moving back to 🚚 )  Brisbane, Australia

---

## 📝 **License**

ActiveShell is released under CC-BY-NC-SA 4.0. See the `LICENSE` file for details.

---

### **ActiveShell: Where Data Becomes Dynamic Intelligence** 🌟
