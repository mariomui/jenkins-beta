requirements
* java 1.8 installed

This only builds a local pod version of jenkins and installs plugins
Nothing more, nothing less
Step 1:
<!-- * go to helperfiles and run ./startup.sh 
  * Only run startup.sh in helper files (yeah i need to polish it) DEPRECATED-->
* npm run jenkins:startup
* type in the namespace you'd like to run, make sure it's unique
  * like beta will also trigger a noop if you created something like betabeta
  * <namespace>-jenkins will be the service automatically
  * <namespace>-pv will be the persistent volume
  * the root values.yaml will be automatically changed
  * the pv and yaml folder will be updated with new yaml files
    * this will grow in size and needs flushing. Will move to var/tmp folder soon.
* If everything is successful, type in .exit
  * Some text will echo out that you should paste and get the password and accesspoint. I have already generated. It takes a while for the jenkins pod to install all the plugins.

Step 2:
  * wait for jenkins server to load
  * use the prompt for the password and local access url
  * username: admin
    * password is auto generated
    * if you forget it: npm run jenkins:getPassword
    * if you forget the accessPoint: npm run jenkins:getAccessPoint

Caveats:
  * You can create multiple namespaces with each namespace having their own jenkins pod. They will run simultaneously but the scripts to get password and local accesspoint will have to be supplied an argument
  npm run jenkins:getPassword <namespace>
  npm run jenkins:getAccessPoint <namespace>

original helm chart came from here.
https://github.com/helm/charts/tree/master/stable/jenkins
