# Cloudlet upgrades & Maintenance: 

Chef is used as configuration management tool for cloudlet upgrades and maintenance since mostof the operator environment and ingress restricted environmnent.

Each cloudlet up-grade will have a new Cookbook and node attributes for upgrade.
Steps for up-grade is as below:

1. Modify the cookbook recipe code for up-grade
2. Update the cookbook version in metadata.rb file
3. Go to chef/policyfiles folder in edgecloud
4. Remove old docker_crm.lock.json (if change is in docker policy)
5. Generate new lock.json file: chef install docker_crm.rb
6. Push it to your group: chef push production docker_crm.rb
7. For Node attributes upgrade: Three types of attributes to be updated:

  a. Node specific: Use knife exec command to update it
  ```
    knife exec -E 'nodes.search("name:dev*pf") {|n| puts n.name; n.normal["attributename"]="attributevalue"; n.save}'
  ```
  b. Recipe/Cookbook specific: Store the attributes in attributes file of the cookbook
  ```
    cat attributes/default.rb
    normal['crmserver']['args']['d'] = 'etcd,notify,infra,metrics'
  ```
  c. Setup specific: These attributes will be part of PolicyFile itself
  ```
    override['dev']['edgeCloudVersion'] = "2020-06-12"
  ```