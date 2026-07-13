///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsEs with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsEs({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.es,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <es>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsEs _root = this; // ignore: unused_field

	@override 
	TranslationsEs $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsEs(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$options$es options = _Translations$options$es._(_root);
	@override late final _Translations$pages$es pages = _Translations$pages$es._(_root);
	@override late final _Translations$misc$es misc = _Translations$misc$es._(_root);
}

// Path: options
class _Translations$options$es implements Translations$options$en {
	_Translations$options$es._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Opciones';
	@override String get dark_mode_label => 'Modo oscuro';
	@override late final _Translations$options$snack_messages$es snack_messages = _Translations$options$snack_messages$es._(_root);
	@override late final _Translations$options$dropbox$es dropbox = _Translations$options$dropbox$es._(_root);
}

// Path: pages
class _Translations$pages$es implements Translations$pages$en {
	_Translations$pages$es._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override late final _Translations$pages$home$es home = _Translations$pages$home$es._(_root);
	@override late final _Translations$pages$note_editor$es note_editor = _Translations$pages$note_editor$es._(_root);
	@override late final _Translations$pages$note_details$es note_details = _Translations$pages$note_details$es._(_root);
}

// Path: misc
class _Translations$misc$es implements Translations$misc$en {
	_Translations$misc$es._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override late final _Translations$misc$buttons$es buttons = _Translations$misc$buttons$es._(_root);
	@override String get cancelled_by_user => 'Cancelado por el usuario';
}

// Path: options.snack_messages
class _Translations$options$snack_messages$es implements Translations$options$snack_messages$en {
	_Translations$options$snack_messages$es._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override late final _Translations$options$snack_messages$dropbox$es dropbox = _Translations$options$snack_messages$dropbox$es._(_root);
}

// Path: options.dropbox
class _Translations$options$dropbox$es implements Translations$options$dropbox$en {
	_Translations$options$dropbox$es._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get login_button => 'Iniciar sesión en Dropbox';
	@override String get logout_button => 'Cerrar sesión en Dropbox';
	@override String get sync_button => 'Sincronizar archivos';
	@override String get reset_tokens => 'Borrar datos de conexión';
	@override String get tokens_reseted => 'Datos de Dropbox borrados. Por favor, inicie sesión de nuevo.';
	@override String failed_reseting_tokens({required Object err}) => 'No se pudo borrar los datos de Dropbox: ${err}';
}

// Path: pages.home
class _Translations$pages$home$es implements Translations$pages$home$en {
	_Translations$pages$home$es._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Inicio';
	@override late final _Translations$pages$home$misc$es misc = _Translations$pages$home$misc$es._(_root);
	@override late final _Translations$pages$home$misc_errors$es misc_errors = _Translations$pages$home$misc_errors$es._(_root);
	@override late final _Translations$pages$home$delete_folder_dialog$es delete_folder_dialog = _Translations$pages$home$delete_folder_dialog$es._(_root);
	@override late final _Translations$pages$home$delete_note_dialog$es delete_note_dialog = _Translations$pages$home$delete_note_dialog$es._(_root);
	@override late final _Translations$pages$home$create_folder_dialog$es create_folder_dialog = _Translations$pages$home$create_folder_dialog$es._(_root);
	@override late final _Translations$pages$home$rename_folder_errors$es rename_folder_errors = _Translations$pages$home$rename_folder_errors$es._(_root);
	@override late final _Translations$pages$home$create_folder_errors$es create_folder_errors = _Translations$pages$home$create_folder_errors$es._(_root);
	@override late final _Translations$pages$home$create_note_errors$es create_note_errors = _Translations$pages$home$create_note_errors$es._(_root);
	@override late final _Translations$pages$home$rename_folder_dialog$es rename_folder_dialog = _Translations$pages$home$rename_folder_dialog$es._(_root);
	@override late final _Translations$pages$home$rename_note_dialog$es rename_note_dialog = _Translations$pages$home$rename_note_dialog$es._(_root);
	@override late final _Translations$pages$home$rename_note_errors$es rename_note_errors = _Translations$pages$home$rename_note_errors$es._(_root);
	@override late final _Translations$pages$home$new_filename_dialog$es new_filename_dialog = _Translations$pages$home$new_filename_dialog$es._(_root);
}

// Path: pages.note_editor
class _Translations$pages$note_editor$es implements Translations$pages$note_editor$en {
	_Translations$pages$note_editor$es._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Editor de notas';
	@override String get placeholder => 'Escribe tu texto en markdown...';
	@override String get insert_board_tooltip => 'Insertar un tablero de ajedrez';
	@override late final _Translations$pages$note_editor$save_content_dialog$es save_content_dialog = _Translations$pages$note_editor$save_content_dialog$es._(_root);
	@override String get content_saved => 'Contenido guardado';
}

// Path: pages.note_details
class _Translations$pages$note_details$es implements Translations$pages$note_details$en {
	_Translations$pages$note_details$es._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Detalles de la nota';
}

// Path: misc.buttons
class _Translations$misc$buttons$es implements Translations$misc$buttons$en {
	_Translations$misc$buttons$es._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get ok => 'De acuerdo';
	@override String get cancel => 'Anular';
}

// Path: options.snack_messages.dropbox
class _Translations$options$snack_messages$dropbox$es implements Translations$options$snack_messages$dropbox$en {
	_Translations$options$snack_messages$dropbox$es._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get connection_success => 'Conectado a tu cuenta de Dropbox.';
	@override String get connection_error => 'No se pudo conectar a tu cuenta de Dropbox: por favor, inténtalo de nuevo.';
	@override String get disconnection_success => 'Desconectado de tu cuenta de Dropbox.';
	@override String get disconnection_error => 'No se pudo desconectar de tu cuenta de Dropbox.';
	@override String get sync_success => 'Archivos sincronizados correctamente.';
	@override String get sync_error => 'La sincronización de archivos falló.';
}

// Path: pages.home.misc
class _Translations$pages$home$misc$es implements Translations$pages$home$misc$en {
	_Translations$pages$home$misc$es._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get base_directory => '[RAÍZ_APP]';
	@override String get no_item => 'Ningún elemento';
}

// Path: pages.home.misc_errors
class _Translations$pages$home$misc_errors$es implements Translations$pages$home$misc_errors$en {
	_Translations$pages$home$misc_errors$es._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get failed_opening_folder => 'No se pudo abrir la carpeta';
	@override String get failed_opening_note => 'No se pudo abrir la nota';
	@override String get failed_opening_note_details => 'No se pudieron abrir los detalles de la nota';
	@override String get failed_deleting_folder => 'No se pudo eliminar la carpeta';
	@override String get failed_deleting_note => 'No se pudo eliminar la nota';
}

// Path: pages.home.delete_folder_dialog
class _Translations$pages$home$delete_folder_dialog$es implements Translations$pages$home$delete_folder_dialog$en {
	_Translations$pages$home$delete_folder_dialog$es._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => '¿Eliminar carpeta?';
	@override String message({required Object name}) => '¿Deseas eliminar la carpeta ${name}?';
}

// Path: pages.home.delete_note_dialog
class _Translations$pages$home$delete_note_dialog$es implements Translations$pages$home$delete_note_dialog$en {
	_Translations$pages$home$delete_note_dialog$es._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => '¿Eliminar nota?';
	@override String message({required Object name}) => '¿Deseas eliminar la nota ${name}?';
}

// Path: pages.home.create_folder_dialog
class _Translations$pages$home$create_folder_dialog$es implements Translations$pages$home$create_folder_dialog$en {
	_Translations$pages$home$create_folder_dialog$es._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Crear nueva carpeta';
	@override String get placeholder => 'Nombre';
}

// Path: pages.home.rename_folder_errors
class _Translations$pages$home$rename_folder_errors$es implements Translations$pages$home$rename_folder_errors$en {
	_Translations$pages$home$rename_folder_errors$es._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get already_exists => 'La carpeta ya existe';
	@override String get modification_error => 'No se pudo modificar la carpeta';
}

// Path: pages.home.create_folder_errors
class _Translations$pages$home$create_folder_errors$es implements Translations$pages$home$create_folder_errors$en {
	_Translations$pages$home$create_folder_errors$es._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get already_exists => 'La carpeta ya existe';
	@override String get creation_error => 'No se pudo crear la carpeta';
}

// Path: pages.home.create_note_errors
class _Translations$pages$home$create_note_errors$es implements Translations$pages$home$create_note_errors$en {
	_Translations$pages$home$create_note_errors$es._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get failed_creating_note => 'No se pudo crear la nota';
}

// Path: pages.home.rename_folder_dialog
class _Translations$pages$home$rename_folder_dialog$es implements Translations$pages$home$rename_folder_dialog$en {
	_Translations$pages$home$rename_folder_dialog$es._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String title({required Object oldFolderName}) => 'Renombrar carpeta (${oldFolderName})';
	@override String get name_placeholder => 'Nuevo nombre';
}

// Path: pages.home.rename_note_dialog
class _Translations$pages$home$rename_note_dialog$es implements Translations$pages$home$rename_note_dialog$en {
	_Translations$pages$home$rename_note_dialog$es._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String title({required Object oldFileName}) => 'Renombrar nota (${oldFileName})';
	@override String get name_placeholder => 'Nuevo nombre';
}

// Path: pages.home.rename_note_errors
class _Translations$pages$home$rename_note_errors$es implements Translations$pages$home$rename_note_errors$en {
	_Translations$pages$home$rename_note_errors$es._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get already_exists => 'La nota ya existe';
	@override String get modification_error => 'No se pudo modificar la nota';
}

// Path: pages.home.new_filename_dialog
class _Translations$pages$home$new_filename_dialog$es implements Translations$pages$home$new_filename_dialog$en {
	_Translations$pages$home$new_filename_dialog$es._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Crear nueva nota';
	@override String get placeholder => 'Nombre';
}

// Path: pages.note_editor.save_content_dialog
class _Translations$pages$note_editor$save_content_dialog$es implements Translations$pages$note_editor$save_content_dialog$en {
	_Translations$pages$note_editor$save_content_dialog$es._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => '¿Guardar contenido?';
	@override String get message => '¿Deseas guardar el contenido?';
}

/// The flat map containing all translations for locale <es>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsEs {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'options.title' => 'Opciones',
			'options.dark_mode_label' => 'Modo oscuro',
			'options.snack_messages.dropbox.connection_success' => 'Conectado a tu cuenta de Dropbox.',
			'options.snack_messages.dropbox.connection_error' => 'No se pudo conectar a tu cuenta de Dropbox: por favor, inténtalo de nuevo.',
			'options.snack_messages.dropbox.disconnection_success' => 'Desconectado de tu cuenta de Dropbox.',
			'options.snack_messages.dropbox.disconnection_error' => 'No se pudo desconectar de tu cuenta de Dropbox.',
			'options.snack_messages.dropbox.sync_success' => 'Archivos sincronizados correctamente.',
			'options.snack_messages.dropbox.sync_error' => 'La sincronización de archivos falló.',
			'options.dropbox.login_button' => 'Iniciar sesión en Dropbox',
			'options.dropbox.logout_button' => 'Cerrar sesión en Dropbox',
			'options.dropbox.sync_button' => 'Sincronizar archivos',
			'options.dropbox.reset_tokens' => 'Borrar datos de conexión',
			'options.dropbox.tokens_reseted' => 'Datos de Dropbox borrados. Por favor, inicie sesión de nuevo.',
			'options.dropbox.failed_reseting_tokens' => ({required Object err}) => 'No se pudo borrar los datos de Dropbox: ${err}',
			'pages.home.title' => 'Inicio',
			'pages.home.misc.base_directory' => '[RAÍZ_APP]',
			'pages.home.misc.no_item' => 'Ningún elemento',
			'pages.home.misc_errors.failed_opening_folder' => 'No se pudo abrir la carpeta',
			'pages.home.misc_errors.failed_opening_note' => 'No se pudo abrir la nota',
			'pages.home.misc_errors.failed_opening_note_details' => 'No se pudieron abrir los detalles de la nota',
			'pages.home.misc_errors.failed_deleting_folder' => 'No se pudo eliminar la carpeta',
			'pages.home.misc_errors.failed_deleting_note' => 'No se pudo eliminar la nota',
			'pages.home.delete_folder_dialog.title' => '¿Eliminar carpeta?',
			'pages.home.delete_folder_dialog.message' => ({required Object name}) => '¿Deseas eliminar la carpeta ${name}?',
			'pages.home.delete_note_dialog.title' => '¿Eliminar nota?',
			'pages.home.delete_note_dialog.message' => ({required Object name}) => '¿Deseas eliminar la nota ${name}?',
			'pages.home.create_folder_dialog.title' => 'Crear nueva carpeta',
			'pages.home.create_folder_dialog.placeholder' => 'Nombre',
			'pages.home.rename_folder_errors.already_exists' => 'La carpeta ya existe',
			'pages.home.rename_folder_errors.modification_error' => 'No se pudo modificar la carpeta',
			'pages.home.create_folder_errors.already_exists' => 'La carpeta ya existe',
			'pages.home.create_folder_errors.creation_error' => 'No se pudo crear la carpeta',
			'pages.home.create_note_errors.failed_creating_note' => 'No se pudo crear la nota',
			'pages.home.rename_folder_dialog.title' => ({required Object oldFolderName}) => 'Renombrar carpeta (${oldFolderName})',
			'pages.home.rename_folder_dialog.name_placeholder' => 'Nuevo nombre',
			'pages.home.rename_note_dialog.title' => ({required Object oldFileName}) => 'Renombrar nota (${oldFileName})',
			'pages.home.rename_note_dialog.name_placeholder' => 'Nuevo nombre',
			'pages.home.rename_note_errors.already_exists' => 'La nota ya existe',
			'pages.home.rename_note_errors.modification_error' => 'No se pudo modificar la nota',
			'pages.home.new_filename_dialog.title' => 'Crear nueva nota',
			'pages.home.new_filename_dialog.placeholder' => 'Nombre',
			'pages.note_editor.title' => 'Editor de notas',
			'pages.note_editor.placeholder' => 'Escribe tu texto en markdown...',
			'pages.note_editor.insert_board_tooltip' => 'Insertar un tablero de ajedrez',
			'pages.note_editor.save_content_dialog.title' => '¿Guardar contenido?',
			'pages.note_editor.save_content_dialog.message' => '¿Deseas guardar el contenido?',
			'pages.note_editor.content_saved' => 'Contenido guardado',
			'pages.note_details.title' => 'Detalles de la nota',
			'misc.buttons.ok' => 'De acuerdo',
			'misc.buttons.cancel' => 'Anular',
			'misc.cancelled_by_user' => 'Cancelado por el usuario',
			_ => null,
		};
	}
}
