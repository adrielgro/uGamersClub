resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Vehicle Shop'

version '1.0.0'

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  '@es_extended/locale.lua' ,
  'locales/br.lua' ,
  'locales/de.lua' ,
  'locales/en.lua' ,
  'locales/es.lua' ,
  'locales/fr.lua' ,
  'config.lua',
  'server/main.lua'
}

client_scripts {
  '@es_extended/locale.lua' ,
  'locales/br.lua' ,
  'locales/de.lua' ,
  'locales/en.lua' ,
  'locales/es.lua' ,
  'locales/fr.lua' ,
  'config.lua',
  'client/main.lua'
}
