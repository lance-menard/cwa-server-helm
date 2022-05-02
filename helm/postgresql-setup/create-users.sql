/* Creates CWA users */

CREATE USER {{ .Values.pg.flyway.user | quote }} WITH INHERIT IN ROLE cwa_flyway ENCRYPTED PASSWORD {{ .Values.pg.flyway.password | squote }};
CREATE USER {{ .Values.pg.submission.user | quote }} WITH INHERIT IN ROLE cwa_submission ENCRYPTED PASSWORD {{ .Values.pg.submission.password | squote }};
CREATE USER {{ .Values.pg.distribution.user | quote }} WITH INHERIT IN ROLE cwa_distribution ENCRYPTED PASSWORD {{ .Values.pg.distribution.password | squote }};

/* --------------- Interoperability --------------- */
CREATE USER {{ .Values.pg.callback.user | quote }} WITH INHERIT IN ROLE cwa_federation_callback ENCRYPTED PASSWORD {{ .Values.pg.callback.password | squote }};
CREATE USER {{ .Values.pg.download.user | quote }} WITH INHERIT IN ROLE cwa_federation_download ENCRYPTED PASSWORD {{ .Values.pg.download.password | squote }};
CREATE USER {{ .Values.pg.upload.user | quote }} WITH INHERIT IN ROLE cwa_federation_upload ENCRYPTED PASSWORD {{ .Values.pg.upload.password | squote }};

/* --------------- Swiss Federation Gateway --------------- */
CREATE USER {{ .Values.pg.chgs_upload.user | quote }} WITH INHERIT IN ROLE cwa_chgs_upload ENCRYPTED PASSWORD {{ .Values.pg.chgs_upload.password | squote }};
