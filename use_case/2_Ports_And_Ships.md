# Schema Design for Ports, Ships, and Time: A Dynamic Framework for Supply Chain Management

## **Introduction**

In modern supply chain management, understanding the intricate relationships between ports, ships, and time is crucial for optimizing logistics, minimizing disruptions, and forecasting potential bottlenecks. This document outlines a robust schema for representing these entities, ensuring scalability and adaptability for real-world applications. The schema integrates real-time data feeds, historical records, and contextual metadata to provide actionable insights.

---

## **Schema Design**

### **1. Ports Schema**

Ports are critical nodes in the global supply chain. The following attributes define their operational characteristics and contextual information:

#### **Attributes**:

* **ID** (String): Unique identifier for the port.
* **Name** (String): The official name of the port.
* **Location** (Geospatial): Latitude and longitude coordinates.
* **Country** (String): The country where the port is located.
* **Capacity** (Integer): The maximum number of ships the port can accommodate at any given time.
* **Current Weather** (Object): Real-time weather conditions, including:
  * **Temperature** (Float): Measured in degrees Celsius.
  * **Wind Speed** (Float): Measured in knots.
  * **Wind Direction** (Integer): Degrees from north (0° - 360°).
  * **Gust Speed** (Float): Maximum wind gust in knots.
* **Historical Weather** (Array[Object]): Historical weather records for analytical purposes.
* **Traffic Data** (Object): Details of ship traffic, including:
  * **Ships Docked** (Array[Ship IDs]): List of ship IDs currently moored.
  * **Scheduled Arrivals/Departures** (Array[Event]): Expected ship movements.
* **Depth** (Float): Maximum draft depth in meters.
* **Facilities** (Object): Key port facilities (e.g., cranes, fuel depots).
* **Attributes** (Key-Value Pair): Additional metadata such as port classification (e.g., international hub, regional).

---

### **2. Ships Schema**

Ships are dynamic entities moving through the supply chain. The schema captures their unique properties and operational data:

#### **Attributes**:

* **ID** (String): Unique identifier (e.g., IMO number, MMSI number).
* **Name** (String): The ship's registered name.
* **Type** (String): Type of ship (e.g., cargo, tanker, container).
* **Dimensions** (Object):
  * **Length** (Float): Length in meters.
  * **Breadth** (Float): Width in meters.
  * **Draft** (Float): Draft depth in meters.
* **Current Location** (Geospatial): Latitude and longitude of the ship's current position.
* **Destination** (String): The port the ship is heading toward.
* **ETA** (Datetime): Estimated time of arrival at the destination port.
* **Navigational Status** (Enum):
  * Options: Moored, Underway, Anchored, etc.
* **Speed** (Float): Current speed in knots.
* **True Heading** (Integer): Current heading in degrees (0° - 360°).
* **Historical Routes** (Array[Object]):
  * **Port ID** (String): Ports visited.
  * **Timestamps** (Datetime): Arrival and departure times.
* **Weather Conditions** (Object):
  * Real-time weather at the ship's location (mirroring port schema).
* **Attributes** (Key-Value Pair): Additional metadata, such as cargo type, owner, or operator.

---

### **3. Time Schema**

Time acts as the connective tissue between events, providing context for analysis and forecasting.

#### **Attributes**:

* **Timestamp** (Datetime): Exact date and time of the recorded event.
* **Event Type** (Enum):
  * Options: Arrival, Departure, Mooring, Loading, Unloading.
* **Weather Conditions** (Object):
  * Snapshot of weather data during the event.
* **Port ID** (String): The port associated with the event.
* **Ship ID** (String): The ship involved in the event.
* **Delay Reason** (String): Description of any delay (e.g., weather, mechanical issues).

---

## **Data Relationships**

The schema's entities are interconnected, forming a dynamic graph:

* **Port - Ship Relationship**:
  * Represents mooring, arrivals, and departures.
  * Captures cargo transfers, operational dependencies, and delays.
* **Ship - Time Relationship**:
  * Tracks ship movements, speed, and historical routes over time.
* **Port - Time Relationship**:
  * Links traffic data, weather conditions, and events occurring at the port.

---

## **Integration with Real-World Data**

This schema leverages data from sources like **MarineTraffic** and **VesselFinder** to dynamically populate the graph. Historical and real-time data from these platforms enhance the system's ability to:

1. **Build Historical Context**: Analyze past delays, weather impacts, and port utilization.
2. **Enable Real-Time Monitoring**: Provide up-to-the-minute tracking of ships and port operations.
3. **Forecast Future Scenarios**: Use weather predictions and historical patterns to anticipate disruptions and optimize scheduling.

---

## **Use Case Example: OOCL Miami in Brisbane**

1. **Port Details**:
   * **Name**: Brisbane Port.
   * **Capacity**: 45 ships.
   * **Weather**: 26°C, wind speed 5.4 knots, direction 91°.
2. **Ship Details**:
   * **Name**: OOCL Miami.
   * **Navigational Status**: Moored.
   * **ETA**: Jan 13, 18:30 (UTC+10).
3. **Time Context**:
   * **Event**: Arrival.
   * **Timestamp**: Jan 13, 18:30 (UTC+10).
   * **Conditions**: Clear weather.

---

## **Conclusion**

The proposed schema provides a comprehensive and scalable foundation for modeling ports, ships, and their interdependencies over time. By integrating real-world data, this system can drive actionable insights, streamline operations, and enhance predictive capabilities for global supply chain management.
