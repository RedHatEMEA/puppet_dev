puppet_dev
==========

Tool for developing puppet modules when using Red Hat Satellite 6

To facilitate development of Puppet modules which are to be used 
together with the Red Hat Satellite 6, this puppet_dev module has been 
created. When this module is applied to a host, the command puppet_dev_run is 
made available. This command can be used to develop and test locally modified
Puppet modules on host.
To use this command, the repositories containing all the Puppet modules should 
be checked out locally on the host. When puppet_dev_run is then executed, the
locally modified Puppet modules are applied on the host together with the ENC
 information from the Red Hat Satellite 6 as shown in the example below:

#puppet_dev_run --modulepath <colon-separated-paths-to-local-modules> <manifest> 
