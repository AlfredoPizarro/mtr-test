# mtr-test
Container prepared to run an infinite mtr test to check latency between etcd members.

It will create a container using rhel8/support-tool image and running mtr to test 3 endpoints. It will use the host context so the test is perform directly from the main node's interface and not from the SDN. 

Instructions:

- Create the test-network project:
```
 $ oc new-project test-network
```
- Add the label `test-network: true` to the nodes where the containers will run.
- Add the privileged scc to the default service account:
```
 $ oc adm policy add-scc-to-user privileged -z default
```
- Create the test-network-entrypoint configmap using the entrypoint.sh file: 
```
$ oc create configmap test-network-entrypoint --from-file entrypoint.sh
```
- Edit the daemonset-test-network.yaml and modify the ETCD1, ETCD2 and ETCD3 vars to reflect your etcd hosts.
- Create the daemonset:
```
$ oc create -f daemonset-test-network.yaml
```

The entrypoint.sh script will run mtr using 600 test and then will run again over an infinite loop. You can adjust that modifying the entrypoint.sh file. To obtain the results just obtain the logs from each pod.

