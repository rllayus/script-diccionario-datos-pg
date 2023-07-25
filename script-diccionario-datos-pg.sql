SELECT
       c.relname as TABLA,
       pg_catalog.obj_description(c.oid, 'pg_class') as DESCRIPCION
FROM pg_catalog.pg_class c
         LEFT JOIN pg_catalog.pg_namespace n ON n.oid = c.relnamespace
WHERE c.relkind IN ('r','p','')
  AND n.nspname <> 'pg_catalog'
  AND n.nspname <> 'information_schema'
  AND n.nspname !~ '^pg_toast'
  AND pg_catalog.pg_table_is_visible(c.oid)
ORDER BY 1,2;

\


select
       table_name AS TABLA,
       column_name AS COLUMNA,
       concat(data_type, '(', (case when character_maximum_length is not null
                                        then character_maximum_length
                                    else numeric_precision END),')' ) as TIPO_DATO,
       is_nullable AS REQUERIDO,
       '' AS DESCRIPCION
from information_schema.columns
where table_schema ='public'
order by table_schema,
         table_name,
         ordinal_position;
