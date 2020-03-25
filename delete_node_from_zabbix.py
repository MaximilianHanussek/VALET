import os
from pyzabbix.api import ZabbixAPI

# Create ZabbixAPI class instance
pasted_URL = 'http://' + str(os.environ["MASTER_NODE_IP_PUBLIC"]) + '/zabbix/'
zapi = ZabbixAPI(url=str(pasted_URL), user='admin', password='zabbix')

node_name_removed = str(os.environ["NODE_NAME_REMOVED"])

# Get dictionary of host to be deleted
result_removed_host_id = zapi.do_request('host.get',
{
	'filter': {'name': [node_name_removed]}
})

# Get id of host to be deleted
parsed_removed_host_id = result_removed_host_id['result'][0]['hostid']

# Delete node based on its id
result_delete_node = zapi.do_request('host.delete', [parsed_removed_host_id])

# Logout from Zabbix
zapi.user.logout()
