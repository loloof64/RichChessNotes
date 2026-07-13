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
class TranslationsFr with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsFr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.fr,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <fr>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsFr _root = this; // ignore: unused_field

	@override 
	TranslationsFr $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsFr(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$options$fr options = _Translations$options$fr._(_root);
	@override late final _Translations$pages$fr pages = _Translations$pages$fr._(_root);
	@override late final _Translations$misc$fr misc = _Translations$misc$fr._(_root);
}

// Path: options
class _Translations$options$fr implements Translations$options$en {
	_Translations$options$fr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Options';
	@override String get dark_mode_label => 'Dark mode';
	@override late final _Translations$options$snack_messages$fr snack_messages = _Translations$options$snack_messages$fr._(_root);
	@override late final _Translations$options$dropbox$fr dropbox = _Translations$options$dropbox$fr._(_root);
}

// Path: pages
class _Translations$pages$fr implements Translations$pages$en {
	_Translations$pages$fr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$pages$home$fr home = _Translations$pages$home$fr._(_root);
	@override late final _Translations$pages$note_editor$fr note_editor = _Translations$pages$note_editor$fr._(_root);
	@override late final _Translations$pages$note_details$fr note_details = _Translations$pages$note_details$fr._(_root);
}

// Path: misc
class _Translations$misc$fr implements Translations$misc$en {
	_Translations$misc$fr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$misc$buttons$fr buttons = _Translations$misc$buttons$fr._(_root);
	@override String get cancelled_by_user => 'Annulé par l\'utilisateur';
}

// Path: options.snack_messages
class _Translations$options$snack_messages$fr implements Translations$options$snack_messages$en {
	_Translations$options$snack_messages$fr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$options$snack_messages$dropbox$fr dropbox = _Translations$options$snack_messages$dropbox$fr._(_root);
}

// Path: options.dropbox
class _Translations$options$dropbox$fr implements Translations$options$dropbox$en {
	_Translations$options$dropbox$fr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get login_button => 'Connexion Dropbox';
	@override String get logout_button => 'Déconnexion Dropbox';
	@override String get sync_button => 'Synchroniser les fichiers';
	@override String get reset_tokens => 'Effacer données de connexion';
	@override String get tokens_reseted => 'Données Dropbox effacées. Veuillez vous reconnecter.';
	@override String failed_reseting_tokens({required Object err}) => 'Échec de la réinitialisation des données Dropbox : ${err}';
}

// Path: pages.home
class _Translations$pages$home$fr implements Translations$pages$home$en {
	_Translations$pages$home$fr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Accueil';
	@override late final _Translations$pages$home$misc$fr misc = _Translations$pages$home$misc$fr._(_root);
	@override late final _Translations$pages$home$misc_errors$fr misc_errors = _Translations$pages$home$misc_errors$fr._(_root);
	@override late final _Translations$pages$home$delete_folder_dialog$fr delete_folder_dialog = _Translations$pages$home$delete_folder_dialog$fr._(_root);
	@override late final _Translations$pages$home$delete_note_dialog$fr delete_note_dialog = _Translations$pages$home$delete_note_dialog$fr._(_root);
	@override late final _Translations$pages$home$create_folder_dialog$fr create_folder_dialog = _Translations$pages$home$create_folder_dialog$fr._(_root);
	@override late final _Translations$pages$home$rename_folder_errors$fr rename_folder_errors = _Translations$pages$home$rename_folder_errors$fr._(_root);
	@override late final _Translations$pages$home$create_folder_errors$fr create_folder_errors = _Translations$pages$home$create_folder_errors$fr._(_root);
	@override late final _Translations$pages$home$create_note_errors$fr create_note_errors = _Translations$pages$home$create_note_errors$fr._(_root);
	@override late final _Translations$pages$home$rename_folder_dialog$fr rename_folder_dialog = _Translations$pages$home$rename_folder_dialog$fr._(_root);
	@override late final _Translations$pages$home$rename_note_dialog$fr rename_note_dialog = _Translations$pages$home$rename_note_dialog$fr._(_root);
	@override late final _Translations$pages$home$rename_note_errors$fr rename_note_errors = _Translations$pages$home$rename_note_errors$fr._(_root);
	@override late final _Translations$pages$home$new_filename_dialog$fr new_filename_dialog = _Translations$pages$home$new_filename_dialog$fr._(_root);
}

// Path: pages.note_editor
class _Translations$pages$note_editor$fr implements Translations$pages$note_editor$en {
	_Translations$pages$note_editor$fr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Éditeur de note';
	@override String get placeholder => 'Ecrivez votre texte en Markdown...';
	@override String get insert_board_tooltip => 'Insérer un échiquier';
	@override late final _Translations$pages$note_editor$save_content_dialog$fr save_content_dialog = _Translations$pages$note_editor$save_content_dialog$fr._(_root);
	@override String get content_saved => 'Contenu sauvegardé';
}

// Path: pages.note_details
class _Translations$pages$note_details$fr implements Translations$pages$note_details$en {
	_Translations$pages$note_details$fr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Details de la note';
}

// Path: misc.buttons
class _Translations$misc$buttons$fr implements Translations$misc$buttons$en {
	_Translations$misc$buttons$fr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get ok => 'Ok';
	@override String get cancel => 'Annuler';
}

// Path: options.snack_messages.dropbox
class _Translations$options$snack_messages$dropbox$fr implements Translations$options$snack_messages$dropbox$en {
	_Translations$options$snack_messages$dropbox$fr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get connection_success => 'Connecté à votre compte Dropbox.';
	@override String get connection_error => 'Échec de connexion à votre compte Dropbox : veuillez réessayer.';
	@override String get disconnection_success => 'Déconnecté de votre compte Dropbox.';
	@override String get disconnection_error => 'Échec de déconnexion de votre compte Dropbox.';
	@override String get sync_success => 'Fichiers synchronisés avec succès.';
	@override String get sync_error => 'La synchronisation des fichiers a échoué.';
}

// Path: pages.home.misc
class _Translations$pages$home$misc$fr implements Translations$pages$home$misc$en {
	_Translations$pages$home$misc$fr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get base_directory => '[RACINE_APP]';
	@override String get no_item => 'Aucun élément';
}

// Path: pages.home.misc_errors
class _Translations$pages$home$misc_errors$fr implements Translations$pages$home$misc_errors$en {
	_Translations$pages$home$misc_errors$fr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get failed_opening_folder => 'Échec d\'ouverture du dossier';
	@override String get failed_opening_note => 'Échec d\'ouverture de la note';
	@override String get failed_opening_note_details => 'Échec d\'ouverture des détails de la note';
	@override String get failed_deleting_folder => 'Échec de suppression de dossier';
	@override String get failed_deleting_note => 'Échec de suppression de la note';
}

// Path: pages.home.delete_folder_dialog
class _Translations$pages$home$delete_folder_dialog$fr implements Translations$pages$home$delete_folder_dialog$en {
	_Translations$pages$home$delete_folder_dialog$fr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Supprimer le dossier ?';
	@override String message({required Object name}) => 'Voulez-vous supprimer le dossier ${name} ?';
}

// Path: pages.home.delete_note_dialog
class _Translations$pages$home$delete_note_dialog$fr implements Translations$pages$home$delete_note_dialog$en {
	_Translations$pages$home$delete_note_dialog$fr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Supprimer la note ?';
	@override String message({required Object name}) => 'Voulez-vous supprimer la note ${name} ?';
}

// Path: pages.home.create_folder_dialog
class _Translations$pages$home$create_folder_dialog$fr implements Translations$pages$home$create_folder_dialog$en {
	_Translations$pages$home$create_folder_dialog$fr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Créér un dossier';
	@override String get placeholder => 'Nom';
}

// Path: pages.home.rename_folder_errors
class _Translations$pages$home$rename_folder_errors$fr implements Translations$pages$home$rename_folder_errors$en {
	_Translations$pages$home$rename_folder_errors$fr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get already_exists => 'Le dossier existe déjà';
	@override String get modification_error => 'Échec de la modification du dossier';
}

// Path: pages.home.create_folder_errors
class _Translations$pages$home$create_folder_errors$fr implements Translations$pages$home$create_folder_errors$en {
	_Translations$pages$home$create_folder_errors$fr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get already_exists => 'Le dossier existe déjà';
	@override String get creation_error => 'Échec de la création du dossier';
}

// Path: pages.home.create_note_errors
class _Translations$pages$home$create_note_errors$fr implements Translations$pages$home$create_note_errors$en {
	_Translations$pages$home$create_note_errors$fr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get failed_creating_note => 'Échec de la création de la note';
}

// Path: pages.home.rename_folder_dialog
class _Translations$pages$home$rename_folder_dialog$fr implements Translations$pages$home$rename_folder_dialog$en {
	_Translations$pages$home$rename_folder_dialog$fr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String title({required Object oldFolderName}) => 'Renommer le dossier (${oldFolderName})';
	@override String get name_placeholder => 'Nouveau nom';
}

// Path: pages.home.rename_note_dialog
class _Translations$pages$home$rename_note_dialog$fr implements Translations$pages$home$rename_note_dialog$en {
	_Translations$pages$home$rename_note_dialog$fr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String title({required Object oldFileName}) => 'Renommer la note (${oldFileName})';
	@override String get name_placeholder => 'Nouveau nom';
}

// Path: pages.home.rename_note_errors
class _Translations$pages$home$rename_note_errors$fr implements Translations$pages$home$rename_note_errors$en {
	_Translations$pages$home$rename_note_errors$fr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get already_exists => 'La note existe déjà';
	@override String get modification_error => 'Échec de la modification de la note';
}

// Path: pages.home.new_filename_dialog
class _Translations$pages$home$new_filename_dialog$fr implements Translations$pages$home$new_filename_dialog$en {
	_Translations$pages$home$new_filename_dialog$fr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Créer une nouvelle note';
	@override String get placeholder => 'Nom';
}

// Path: pages.note_editor.save_content_dialog
class _Translations$pages$note_editor$save_content_dialog$fr implements Translations$pages$note_editor$save_content_dialog$en {
	_Translations$pages$note_editor$save_content_dialog$fr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sauvegarder ?';
	@override String get message => 'Souhaitez-vous sauvegarder le contenu ?';
}

/// The flat map containing all translations for locale <fr>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsFr {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'options.title' => 'Options',
			'options.dark_mode_label' => 'Dark mode',
			'options.snack_messages.dropbox.connection_success' => 'Connecté à votre compte Dropbox.',
			'options.snack_messages.dropbox.connection_error' => 'Échec de connexion à votre compte Dropbox : veuillez réessayer.',
			'options.snack_messages.dropbox.disconnection_success' => 'Déconnecté de votre compte Dropbox.',
			'options.snack_messages.dropbox.disconnection_error' => 'Échec de déconnexion de votre compte Dropbox.',
			'options.snack_messages.dropbox.sync_success' => 'Fichiers synchronisés avec succès.',
			'options.snack_messages.dropbox.sync_error' => 'La synchronisation des fichiers a échoué.',
			'options.dropbox.login_button' => 'Connexion Dropbox',
			'options.dropbox.logout_button' => 'Déconnexion Dropbox',
			'options.dropbox.sync_button' => 'Synchroniser les fichiers',
			'options.dropbox.reset_tokens' => 'Effacer données de connexion',
			'options.dropbox.tokens_reseted' => 'Données Dropbox effacées. Veuillez vous reconnecter.',
			'options.dropbox.failed_reseting_tokens' => ({required Object err}) => 'Échec de la réinitialisation des données Dropbox : ${err}',
			'pages.home.title' => 'Accueil',
			'pages.home.misc.base_directory' => '[RACINE_APP]',
			'pages.home.misc.no_item' => 'Aucun élément',
			'pages.home.misc_errors.failed_opening_folder' => 'Échec d\'ouverture du dossier',
			'pages.home.misc_errors.failed_opening_note' => 'Échec d\'ouverture de la note',
			'pages.home.misc_errors.failed_opening_note_details' => 'Échec d\'ouverture des détails de la note',
			'pages.home.misc_errors.failed_deleting_folder' => 'Échec de suppression de dossier',
			'pages.home.misc_errors.failed_deleting_note' => 'Échec de suppression de la note',
			'pages.home.delete_folder_dialog.title' => 'Supprimer le dossier ?',
			'pages.home.delete_folder_dialog.message' => ({required Object name}) => 'Voulez-vous supprimer le dossier ${name} ?',
			'pages.home.delete_note_dialog.title' => 'Supprimer la note ?',
			'pages.home.delete_note_dialog.message' => ({required Object name}) => 'Voulez-vous supprimer la note ${name} ?',
			'pages.home.create_folder_dialog.title' => 'Créér un dossier',
			'pages.home.create_folder_dialog.placeholder' => 'Nom',
			'pages.home.rename_folder_errors.already_exists' => 'Le dossier existe déjà',
			'pages.home.rename_folder_errors.modification_error' => 'Échec de la modification du dossier',
			'pages.home.create_folder_errors.already_exists' => 'Le dossier existe déjà',
			'pages.home.create_folder_errors.creation_error' => 'Échec de la création du dossier',
			'pages.home.create_note_errors.failed_creating_note' => 'Échec de la création de la note',
			'pages.home.rename_folder_dialog.title' => ({required Object oldFolderName}) => 'Renommer le dossier (${oldFolderName})',
			'pages.home.rename_folder_dialog.name_placeholder' => 'Nouveau nom',
			'pages.home.rename_note_dialog.title' => ({required Object oldFileName}) => 'Renommer la note (${oldFileName})',
			'pages.home.rename_note_dialog.name_placeholder' => 'Nouveau nom',
			'pages.home.rename_note_errors.already_exists' => 'La note existe déjà',
			'pages.home.rename_note_errors.modification_error' => 'Échec de la modification de la note',
			'pages.home.new_filename_dialog.title' => 'Créer une nouvelle note',
			'pages.home.new_filename_dialog.placeholder' => 'Nom',
			'pages.note_editor.title' => 'Éditeur de note',
			'pages.note_editor.placeholder' => 'Ecrivez votre texte en Markdown...',
			'pages.note_editor.insert_board_tooltip' => 'Insérer un échiquier',
			'pages.note_editor.save_content_dialog.title' => 'Sauvegarder ?',
			'pages.note_editor.save_content_dialog.message' => 'Souhaitez-vous sauvegarder le contenu ?',
			'pages.note_editor.content_saved' => 'Contenu sauvegardé',
			'pages.note_details.title' => 'Details de la note',
			'misc.buttons.ok' => 'Ok',
			'misc.buttons.cancel' => 'Annuler',
			'misc.cancelled_by_user' => 'Annulé par l\'utilisateur',
			_ => null,
		};
	}
}
