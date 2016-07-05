# collectdwin
[![Build Status](https://travis-ci.com/kkzinger/kkzinger-collectdwin.svg?token=yPyCdfT7MLbXsdDVmTkE&branch=master)](https://travis-ci.com/kkzinger/kkzinger-collectdwin)
#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with collectdwin](#setup)
    * [What collectdwin affects](#what-collectdwin-affects)
    * [Beginning with collectdwin](#beginning-with-collectdwin)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Description

kkzinger-collectdwin manages the collectdwin service on Windows Platforms. This allows 
collectd like Performance Monitoring.

The Module is able to add Performance Counters to the collectdwin configuration, and definition of destinations where the metrics should be sent via http-post. 

## Setup

### What collectdwin affects

collectdwin will be installed through chocolatey. If the system has no internet access 
a local chocolatey mirror has to be provided.

### Beginning with collectdwin

Basic deployment of collectdwin on node.
~~~puppet
    class { '::collectdwin' :
      collectdwin_version => '0.5.14',
      debug_level         => 'Info',
      service_state       => 'running',
    }
~~~

## Usage

To add a new destination to metrics the ::collectdwin::httpdestination define has to 
used.

~~~puppet
  ::collectdwin::httpdestination{
    'graphite-flask': 
    node_name     => 'conmondev001-graphite-flask',
    url           => 'https://192.168.1.1:8888/',
    timeout       => '100',
    batch_size    => '30',
    max_idle_time => '600000',
    proxy_enable  => false,
    proxy_url     => '',
  }                                                                                                                                                            
~~~

To add Performance Counters that should be read from collectdwin the ::collectdwin::percounter define can be used.

~~~puppet
  ::collectdwin::perfcounter{
    'cpu_foo':     
              category          => 'Processor',
              counter_name      => '% Processor Time',
              instance          => '_Total',
              cd_plugin         => 'cpu',
              cd_plugininstance => 'cpu-average',
              cd_type           => 'cpu',
              cd_typeinstance   => 'processor'; 
    'mem_foo': 
              category          => 'Memory',
              counter_name      => 'Available Bytes',
              instance          => '',
              cd_plugin         => 'memory',
              cd_plugininstance => '',
              cd_type           => 'memory',
              cd_typeinstance   => 'free'; 
  }
~~~

## Reference

Classes:
* collectdwin
* collectdwin::params
* collectdwin::install
* collectdwin::config

Defines:
* collectdwin::httpdestination
* collectdwin::perfcounter

## Limitations

* Managment of AMQP Plugin is not implemented
* Managment of STATSD Plugin is not implemented

## Development

Patches are very welcome!
Please send your pull requests on github!


