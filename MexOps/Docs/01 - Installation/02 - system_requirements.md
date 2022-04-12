# Installation

### System Requirements
​
#### VMs
​
- Vault
    
    - Three VMs in different zones
        
    - Each VM:
        
        - GCP n1-standard-2 or equivalent
            
        - 100 GB of storage
            
- Gitlab host:
    
    - GCP n1-standard-2 or equivalent
        
    - 100 GB of storage
        
- Console and Master Controller
    
    - GCP n1-standard-2 or equivalent
        
    - 100 GB of storage
        
- Harbor (Internal Docker Registry)
    
    - GCP n1-standard-2 or equivalent
        
    - 50 GB of storage
        
- Chef Master
    
    - 8 CPU
        
    - 40 GB of RAM
        
    - 2 TB of storage

- APT Cache
    - GCP n1-standard-2 or equivalent
    - 1 TB of storage
        
​
### Region Clusters, Kubernetes
​
For each supported region:
​
- At least a three node cluster
    
- Node size: Azure Standard\_D2s\_v3 or better
    
- Tested with Kubernetes version 1.18.19

