#
# Cookbook Name:: openresty
# Recipe:: commons_conf
#
# Author:: Panagiotis Papadomitsos (<pj@ezgr.net>)
#
# Copyright 2012, Panagiotis Papadomitsos
# Based heavily on Opscode's original nginx cookbook (https://github.com/opscode-cookbooks/nginx)
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

if node['openresty']['logrotate']

  include_recipe 'logrotate'

  # Log rotation
  logrotate_app 'openresty' do
    path "#{node['openresty']['log_dir']}/*.log"
    enable true
    frequency 'daily'
    rotate 7
    cookbook 'logrotate'
    create "0644 #{node['openresty']['user']} adm"
    options [ 'missingok', 'delaycompress', 'notifempty', 'compress', 'sharedscripts' ]
    postrotate "[[ ! -f #{node['openresty']['pid']} ]] || kill -USR1 $(cat #{node['openresty']['pid']})"
  end

end
