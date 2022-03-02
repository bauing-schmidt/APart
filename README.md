# APart

A framework for building database-centric, domain-specific solutions


## How to install

You need Pharo 10 image with Gtk3 support, see https://github.com/pharo-spec/Spec-Gtk for installation details.

```smalltalk
Metacello new
        repository: 'github://pharo-spec/Spec-Gtk';
        baseline: 'SpecGtk';
        onConflict: [ :e | e useIncoming ];
        onUpgrade: [ :e | e useIncoming ];
        ignoreImage;
        load.

Metacello new
  baseline: 'APart';
  repository: 'github://bauing-schmidt/APart/src';
  load.
```

## APart Form Editor

```smalltalk
ApedFormEditor openWithGtkDE
```