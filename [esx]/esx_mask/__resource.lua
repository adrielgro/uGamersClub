resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Mask'

version '1.0.0'

server_scripts {
	'@es_extended/locale.lua',
	'locales/de.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/es.lua',
	'locales/fr.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/de.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/es.lua',
	'locales/fr.lua',
	'config.lua',
	'client/main.lua'
}
