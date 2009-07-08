#!/usr/bin/env rackup -s thin -e none

require 'rubygems'
require 'rack/cache'
require 'rubygems'
require 'sinatra'
require 'logger'
require 'image_server'
require 'lib/cache_purge'


OriginServer = 'static.shopify.com'
$logger      = Logger.new(STDOUT)

use Rack::Cache, 
  :verbose     => true, 
  :metastore   => 'memcached://localhost:11211/meta',
  :entitystore => 'file:/tmp/cache/rack/body'

use CachePurge

run ImageServer.new
