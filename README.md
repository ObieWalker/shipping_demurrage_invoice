# shipurrage

This is a shipping application that handles cargo as they arrive and processes the demurrage costs. 

## Setup

Clone the app to a folder and carry out the following instructions.

```bash
bin/setup or bundle install
```

Configure DB, import legacy schema (test_schema.sql), run migration: 

```bash
rails db:migrate
```

(Optional) rails db:seed

Then Run

```bash
rails s
```

## Tests

```bash
bundle exec rspec
```

## API

### For overdue invoices:

```bash
curl -s http://localhost:3000/invoices/overdue | jq
```


### To generate invoices:

```bash
curl -X POST -s http://localhost:3000/invoices/generate | jq
```

## Design Decisions

-I took the approach of mapping the legacy tables with self.table_name and alias_attribute so that there are no destructive renames.

- I enforced a non-NULL FK: facture.numero_bl → bl.numero_bl and then kept existing index.

- I skipped BLs with any unpaid invoice i.e. zero-container BLs ignored.
