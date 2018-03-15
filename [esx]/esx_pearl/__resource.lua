description 'esx_lsd'

version '1.0.0'

server_scripts {

  '@es_extended/locale.lua',
	'locales/fr.lua',
	'locales/en.lua',
	'locales/es.lua',
  'server/esx_pearl_sv.lua',
  'config.lua'

}

client_scripts {

  '@es_extended/locale.lua',
	'locales/fr.lua',
	'locales/en.lua',
	'locales/es.lua',
  'config.lua',
  'client/esx_pearl_cl.lua'

}
