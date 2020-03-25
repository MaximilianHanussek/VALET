import os
from pyzabbix.api import ZabbixAPI

# Create ZabbixAPI class instance
pasted_URL = 'http://' + str(os.environ["MASTER_IP_PUBLIC"]) + '/zabbix/'
zapi = ZabbixAPI(url=str(pasted_URL), user='admin', password='zabbix')

# Create new hostgroup
result1 = zapi.do_request('hostgroup.create',
{
	'name': 'Unicore compute nodes'
})

# Get id of newly created hostgroup
parsed_group_id_unicore = result1['result']['groupids'][0]

# Get dictionary of discovered hostgroup
result_discovered_host_groups = zapi.do_request('hostgroup.get',
{
	'filter': {'name': ['Discovered hosts']}
})

# Get id of discovered hostgroup
parsed_group_id_discovered = result_discovered_host_groups['result'][0]['groupid']

# Get templateid of Linux Template
result2 = zapi.do_request('template.get',
{
	'filter': {'host': ['Template OS Linux']}
})

parsed_template_id = result2['result'][0]['templateid']

# Create new action 
result3 = zapi.do_request('action.create',
{
'name'          : 'Discover new compute nodes',
'esc_period'    : '2m',
'eventsource'   : 2,
'filter'        : {'evaltype': 0,
                   'conditions': [{'conditiontype': 22, 'operator': 2, 'value': 'compute'}]},
                   'operations': [{'operationtype': 4, 'opgroup': [{'groupid': parsed_group_id_unicore}]},
                      		 {'operationtype': 6, 'optemplate': [{'templateid': parsed_template_id}]},
				 {'operationtype': 5, 'opgroup': [{'groupid': parsed_group_id_discovered}]}
				 ]
                  })

# Get id of swap space trigger of Template OS Linux
result4 = zapi.do_request('trigger.get',
{
	'output': ['triggerid', 'description'],
	'templateids': parsed_template_id	
})

for i in range(len(result4['result'])):
	if result4['result'][i]['description'] == "Lack of free swap space on {HOST.NAME}":
		array_entry = i

parsed_trigger_id = result4['result'][array_entry]['triggerid']

# Disable swap space trigger
result5 = zapi.do_request('trigger.update',
{
	'triggerid': parsed_trigger_id,
	'status': 1
})


# Logout from Zabbix
zapi.user.logout()
