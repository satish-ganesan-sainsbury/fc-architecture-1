# Product MDM - Data Migration Guidelines

## Context

* Product MDM (STIBO) is the new master data platform for Product information
* Transitioning to MDM platform from RMS is **_not a bing-bang move_**
* Transition is an ongoing process which happens at the rate of one category/sub-category at a time.
* MDM platform will act as Master for categories that have transitioned. For categories that have not transitioned, RMS will continue to act as the Master
* MDM platform can implement additional attributes that do not exist in the RMS. Also, MDM platform can drop some existing attributes available in RMS.
* Data mastered within the MDM platform will be fed back into RMS. This will ensure that the downstream systems connected to RMS continue to work. RMS will act as a 100% slave for the back-fed data and would not allow any edits for data that has migrated from within RMS

## State of Product Data in the Enterprise

* Data quality is definitely an issue when RMS is looked in isolation.
* But enterprise as a whole easily passes the smell test; the systems are not turning turtle. Taken as a whole across the enterprise, this is not a problem at all
* When flowing across the enterprise multiple downstream systems fix the data issues originating from RMS

## Iterative Cycle for Data Migration

Given the above state of Product data in the enterprise, data migration can be completed using the following iterative cycle: 

### Phase-1 Maintain Data Status-Quo

 * **Objective**: On-board MDM data platform
 * Data sourced solely from RMS
 * Any new attributes that are created in MDM and that do not exist in RMS remain in design phase within the MDM. Those attributes are not operationalized
 * Publish data into Kafka
 * Tasks related to data issues kept to minimal as described in the Data Considerations section. Data Issues nearly at the same level as in RMS
 * Low risk as data is back-fed into RMS. Downstream systems will receive data only from RMS. Downstream systems are already handling these issues
 * Target period 0 - 3 months

### Phase-2 Upgrade MDM platform to best data sources

 * **Objective**: Consolidate MDM as single source of truth
 * MDM platform to source data from the best data sources in the enterprise (for data already migrated). Example:
  * Case volumetrics (Food) - Virtual Depot
  * Case volumetrics (Non-Food) - EBX
  * Specification (Branded) - Brandbank
  * Specification (Non-Branded) - Evolve
 * Continue to back-feed data into RMS
 * Additionally attributes that are operationalized in MDM and not available in RMS need to be fed back to the relevant data systems
 * Implement data profiling to understand and fix on-going data issues
 * Target period 3+ months
 * Open question:
  * Since, downstream systems are still correcting data, we have two places where data potentially will be mastered. How do we handle this situation?

### Phase-3 Downstream systems are fed directly from MDM

 * **Objective**: Retiring RMS
 * Once all categories are migrated to MDM platform and Data standards are to the agreed expectation, RMS is ready to be retired.
 * Retirement is dependent on whether all downstream systems have switched to reading data from Kafka
 * **Risk**:
  * Need to demonstrate downstream systems can continue working based on data available in Kafka Streams

## Data Migration Considerations

In all of the three phases of iterations Data Migration Considerations need to be understood and addressed. It is also important to put in place Data Profiling tasks that produce reports displaying effectiveness of these considerations

### Data Definition Alignment

* Aligning legacy data platform data to MDM data definition as data is migrated. 
* Example: _IsOwnbrand_ fields can be null in legacy system but may have to have a compulsory boolean value
* Expected implementation: From _Phase 1_

### Consistency

* Consistency is degree to which data representation is uniform within the system or across the systems.
* Example: Record 1 Case weight : 20 Kg, Record 2 Case weight : 20 gms
* Expected implementation: From _Phase 1_

### Completeness

* Completeness is defined along two axis. At every iteration, each of these axis are defined freshly and that definition is used as reference for measuring effectiveness
  * _Number of SKUs_: After each migration the number of SKUs targeted should have transitioned over to the new MDM platform
    * Expected implementation: From _Phase 1_
  * _Correctness of Attributes_: For each SKU, The set of attributes targeted or a particular phase should contain appropriate data. _Appropriateness could also be defined as holding the same data as in RMS even if that data has issues_
    * Expected implementation: RMS attributes in _Phase 1_. Other data sources in _Phase 2_

### Accuracy

* Accuracy is degree to which data correctly describes the real world object or event
* Example: It is common for case dimensions to be defined incorrectly but corrected by Virtual Depot for Food and EBX for non-food
* Expected implementation: _Phase 2_

### Integrity

* Integrity is defined as correctness around uniqueness of data and referential integrity
* This typically will not be an issue in RMS as it is a RDBMS system and safeguards would be in place.
* Can start to become an issue if external data sources deemed as best data sources are maintained for example in Excel spreadsheets
* Expected implementation: _Phase 2_


## Data Migration Principles

Based on above discussion, the architecture team recommends the following principles to be adapted during Data Migration

* **Focus on completeness**: On Day-0, focus on getting the completeness correct
* **Avoid correcting source to fix Data Alignment**: Correcting source to fix data alignment problems is an expensive operation. Fix these issues using the next principle
* **Fixing Data Alignment needs to be transparent and rules based**: A transformation pipeline needs to be in place that can fix data alignment issues. This pipeline needs to be transparent and rules based
* **Data Alignment is bi-directional**: As data is back fed into RMS, data alignment needs to be implemented as a bi-directional exercise using the ACL layer
* **Complete accuracy in phased manner**: Accuracy can be achieved in phases and need not be Day-0 priority. The enterprise has in-built corrective mechanisms
* **Rely on existing systems to achieve accuracy**: Accuracy can be achieved by migrating data from systems that have already fixed these issues. _Do not attempt to fix accuracy on a standalone basis from within MDM_
* **Accuracy need not be replicated**: Ensure accuracy in MDM. Other systems potentially will improve their accuracy as a result of back-feed process. _But making all systems 100% accurate is not the goal of Data Migration_
* **Fix integrity outside MDM**: MDM system is a RDBMS system with strict integrity rules in places. Rather than suspending these rules during Data Migration, fix the integrity issues outside of MDM and then complete the data migration
* **Maintain master-slave relationship**: Whenever MDM becomes the master of Data, ensure back feed happens and the previous master becomes a slave








 