# Data-services Platform - Integration Principles

1. ***Align responsibilities by upstream and downstream pipelines***: Data Services Platforms would be segregated to two pipelines.
   * **Raw data pipeline(upstream) -> Data and Events team**: Raw data sourced to be maintained in their original format in the raw pipeline. The *Data & Events team* is responsible for landing the data into the Kafka topic from the data source
   * **Consumable data pipeline (downstream) -> Work-streams**: Each *work-stream team* to be responsible for transforming the raw data into consumable data

2. ***Universality***: Data Services Platform to provide a common interface for all customers. The platform should not provide any consumer specific transformation. It is the responsibility of the consumers to transform the data to their specific requirements.

3. ***Strictly One-way Dependency***: Data Services Platform is to be 100% slave of Data Management Platform or the raw data sources. Data Services Platform can be completely discarded and rebuilt from data sources
   * Should not generate data
   * Should not amend any data
   * Should not own any business logic

4. ***Dual read modes***: Data Services Platform should provide for two kinds of data read modes:
   * ***Off-set based delta streams***: Subscribers receive delta changes (flowing since the last full refresh) from their current read location. Consumers retain the option of setting/re-setting the start read location to refresh data. This is read mode consumers to replay all the events that occurred at the source

   * ***__Latest__ version of 100% of unique records***: A materialized view of the latest state of the entire universe of unique records in an event bucket starting from the recent full-refresh of events into that bucket.
   Example: A full refresh happened on 1st January. As of 31st December there are 100,000 unique records with multiple events published for each unique record. Total number of events are in the region of 1M. Record_1234 has 100 updates with last update on 31st Dec. Record_abcd has 1 update with last update on 1st Jan. Only 100,000 events to be made available with latest update for each unique record. Record_1234 available with update published on 31st Dec. Record_abcd available with update published on 1st Jan. Overall, consumers exposed only to 100,000 records

5. ***Runtime composition of projection set***: Although the Data Services Platform  presents an universal interface to clients, the information should be organized and classified into groups of attributes. Users should be able to subscribe or access a set of these groupings of their choice along with the core group.

Example: Product data services attributes could be organized into allergens, volumetrics etc. Customers can choose to subscribe a combination of these groupings and receive only events related to their grouping

6. ***End-to-end traceability***: As events flow from data source to clients, they hop through many event buckets. It is necessary to have an unique identifier that traces uniquely each event end-to-end.

7. ***Enable choices in Data Consumption***: The platform should provide for flexibility to the consumers for consuming data. At the minimum the consumers should be offered:
   * Push based data access using a streaming platform
   * Pull(query) based data access using a API (not applicable for Data & Events)

8. ***KISS for Pull based APIs***: The pull based access should follow the Keep It Simple principle and should follow the universality principle:
   * Projection choices to be limited to stitching together groups of attributes
   * Avoid dynamic querying that allows end-users free-form querying against the queryable dataset

9. ***Data Quality to be fixed at relevant source***: Fixing data quality is not the responsibility of the data services platform. Data quality is to be addressed at the relevant source systems

10. ***Mediate unique ids***: This would work would be required in the interim state when data is maintained in old data sources as well as new master data platforms. Each event typically would be associated with a particular business entity. This business entity would have its own unique id as generated within its current source system. This unique id might not fit into newer MDM systems into which these events would be migrated. The MDM systems also can not be relied to generate the ids during the migration process as there might be clash with existing ids. Hence, a third party service is required to mediate and generate unique ids. This is 




