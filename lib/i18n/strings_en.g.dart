///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final Translations$pages$en pages = Translations$pages$en._(_root);
	late final Translations$misc$en misc = Translations$misc$en._(_root);
}

// Path: pages
class Translations$pages$en {
	Translations$pages$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$pages$home$en home = Translations$pages$home$en._(_root);
	late final Translations$pages$note_editor$en note_editor = Translations$pages$note_editor$en._(_root);
	late final Translations$pages$note_details$en note_details = Translations$pages$note_details$en._(_root);
}

// Path: misc
class Translations$misc$en {
	Translations$misc$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$misc$buttons$en buttons = Translations$misc$buttons$en._(_root);

	/// en: 'Cancelled by user'
	String get cancelled_by_user => 'Cancelled by user';
}

// Path: pages.home
class Translations$pages$home$en {
	Translations$pages$home$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Home'
	String get title => 'Home';

	late final Translations$pages$home$misc$en misc = Translations$pages$home$misc$en._(_root);
	late final Translations$pages$home$misc_errors$en misc_errors = Translations$pages$home$misc_errors$en._(_root);
	late final Translations$pages$home$delete_folder_dialog$en delete_folder_dialog = Translations$pages$home$delete_folder_dialog$en._(_root);
	late final Translations$pages$home$create_folder_dialog$en create_folder_dialog = Translations$pages$home$create_folder_dialog$en._(_root);
	late final Translations$pages$home$rename_folder_errors$en rename_folder_errors = Translations$pages$home$rename_folder_errors$en._(_root);
	late final Translations$pages$home$create_folder_errors$en create_folder_errors = Translations$pages$home$create_folder_errors$en._(_root);
	late final Translations$pages$home$create_note_errors$en create_note_errors = Translations$pages$home$create_note_errors$en._(_root);
	late final Translations$pages$home$rename_folder_dialog$en rename_folder_dialog = Translations$pages$home$rename_folder_dialog$en._(_root);
	late final Translations$pages$home$new_filename_dialog$en new_filename_dialog = Translations$pages$home$new_filename_dialog$en._(_root);
}

// Path: pages.note_editor
class Translations$pages$note_editor$en {
	Translations$pages$note_editor$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Note editor'
	String get title => 'Note editor';

	/// en: 'Write your text in markdown...'
	String get placeholder => 'Write your text in markdown...';

	/// en: 'Insert a chess board'
	String get insert_board_tooltip => 'Insert a chess board';

	late final Translations$pages$note_editor$save_content_dialog$en save_content_dialog = Translations$pages$note_editor$save_content_dialog$en._(_root);

	/// en: 'Content saved'
	String get content_saved => 'Content saved';
}

// Path: pages.note_details
class Translations$pages$note_details$en {
	Translations$pages$note_details$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Note details'
	String get title => 'Note details';
}

// Path: misc.buttons
class Translations$misc$buttons$en {
	Translations$misc$buttons$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Ok'
	String get ok => 'Ok';

	/// en: 'Cancel'
	String get cancel => 'Cancel';
}

// Path: pages.home.misc
class Translations$pages$home$misc$en {
	Translations$pages$home$misc$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '[APP_ROOT]'
	String get base_directory => '[APP_ROOT]';

	/// en: 'No item'
	String get no_item => 'No item';
}

// Path: pages.home.misc_errors
class Translations$pages$home$misc_errors$en {
	Translations$pages$home$misc_errors$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Failed to open folder'
	String get failed_opening_folder => 'Failed to open folder';

	/// en: 'Failed to open note'
	String get failed_opening_note => 'Failed to open note';

	/// en: 'Failed to open note details'
	String get failed_opening_note_details => 'Failed to open note details';

	/// en: 'Failed to delete folder'
	String get failed_deleting_folder => 'Failed to delete folder';
}

// Path: pages.home.delete_folder_dialog
class Translations$pages$home$delete_folder_dialog$en {
	Translations$pages$home$delete_folder_dialog$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Delete folder ?'
	String get title => 'Delete folder ?';

	/// en: 'Do you want to delete folder $name ?'
	String message({required Object name}) => 'Do you want to delete folder ${name} ?';
}

// Path: pages.home.create_folder_dialog
class Translations$pages$home$create_folder_dialog$en {
	Translations$pages$home$create_folder_dialog$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Create new folder'
	String get title => 'Create new folder';

	/// en: 'Name'
	String get placeholder => 'Name';
}

// Path: pages.home.rename_folder_errors
class Translations$pages$home$rename_folder_errors$en {
	Translations$pages$home$rename_folder_errors$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Folder already exists'
	String get already_exists => 'Folder already exists';

	/// en: 'Failed to modify folder'
	String get modification_error => 'Failed to modify folder';
}

// Path: pages.home.create_folder_errors
class Translations$pages$home$create_folder_errors$en {
	Translations$pages$home$create_folder_errors$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Folder already exists'
	String get already_exists => 'Folder already exists';

	/// en: 'Failed to create folder'
	String get creation_error => 'Failed to create folder';
}

// Path: pages.home.create_note_errors
class Translations$pages$home$create_note_errors$en {
	Translations$pages$home$create_note_errors$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Failed to create note'
	String get failed_creating_note => 'Failed to create note';
}

// Path: pages.home.rename_folder_dialog
class Translations$pages$home$rename_folder_dialog$en {
	Translations$pages$home$rename_folder_dialog$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Rename folder ($oldFolderName)'
	String title({required Object oldFolderName}) => 'Rename folder (${oldFolderName})';

	/// en: 'New name'
	String get name_placeholder => 'New name';
}

// Path: pages.home.new_filename_dialog
class Translations$pages$home$new_filename_dialog$en {
	Translations$pages$home$new_filename_dialog$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Create new note'
	String get title => 'Create new note';

	/// en: 'Name'
	String get placeholder => 'Name';
}

// Path: pages.note_editor.save_content_dialog
class Translations$pages$note_editor$save_content_dialog$en {
	Translations$pages$note_editor$save_content_dialog$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Save content ?'
	String get title => 'Save content ?';

	/// en: 'Do you want to save content ?'
	String get message => 'Do you want to save content ?';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'pages.home.title' => 'Home',
			'pages.home.misc.base_directory' => '[APP_ROOT]',
			'pages.home.misc.no_item' => 'No item',
			'pages.home.misc_errors.failed_opening_folder' => 'Failed to open folder',
			'pages.home.misc_errors.failed_opening_note' => 'Failed to open note',
			'pages.home.misc_errors.failed_opening_note_details' => 'Failed to open note details',
			'pages.home.misc_errors.failed_deleting_folder' => 'Failed to delete folder',
			'pages.home.delete_folder_dialog.title' => 'Delete folder ?',
			'pages.home.delete_folder_dialog.message' => ({required Object name}) => 'Do you want to delete folder ${name} ?',
			'pages.home.create_folder_dialog.title' => 'Create new folder',
			'pages.home.create_folder_dialog.placeholder' => 'Name',
			'pages.home.rename_folder_errors.already_exists' => 'Folder already exists',
			'pages.home.rename_folder_errors.modification_error' => 'Failed to modify folder',
			'pages.home.create_folder_errors.already_exists' => 'Folder already exists',
			'pages.home.create_folder_errors.creation_error' => 'Failed to create folder',
			'pages.home.create_note_errors.failed_creating_note' => 'Failed to create note',
			'pages.home.rename_folder_dialog.title' => ({required Object oldFolderName}) => 'Rename folder (${oldFolderName})',
			'pages.home.rename_folder_dialog.name_placeholder' => 'New name',
			'pages.home.new_filename_dialog.title' => 'Create new note',
			'pages.home.new_filename_dialog.placeholder' => 'Name',
			'pages.note_editor.title' => 'Note editor',
			'pages.note_editor.placeholder' => 'Write your text in markdown...',
			'pages.note_editor.insert_board_tooltip' => 'Insert a chess board',
			'pages.note_editor.save_content_dialog.title' => 'Save content ?',
			'pages.note_editor.save_content_dialog.message' => 'Do you want to save content ?',
			'pages.note_editor.content_saved' => 'Content saved',
			'pages.note_details.title' => 'Note details',
			'misc.buttons.ok' => 'Ok',
			'misc.buttons.cancel' => 'Cancel',
			'misc.cancelled_by_user' => 'Cancelled by user',
			_ => null,
		};
	}
}
