# The host role in this policy will be used by the jobs in a folder called "".
policy "jenkins/user-database/v1" do
  policy_resource.annotations['description'] = 'This policy declares secrets (via Conjur variables) which are available to Jenkins jobs located within the user-database Jenkins Folder.'
  
  variables = [
    [variable('cloud/access_key_id'), "user-database Jenkins job api key to cloud service"],
    [variable('cloud/secret_access_key'),"user-database Jenkins job secret access key"],
    [variable('rsa_key'),"RSA key to authenticate with an external service"]
  ]

  group "secret_managers" do |group|
    group.resource.annotations['description'] = "Members are able to update the value of all secrets within the policy"

    variables.each do |var| 
      can 'read',    var[0]
      can 'execute', var[0]
      can 'update',  var[0]
      var[0].resource.annotations['description'] = var[1]
    end
  end

  host do |host|    
    host.resource.annotations['kind'] = "Jenkins folder"
    host.resource.annotations['description'] = "Host identity for running Jenkins jobs in user-database folder - can access user-database API keys"    
    variables.each do |var| 
      can 'read',    var[0]
      can 'execute', var[0]
    end
  end  
end