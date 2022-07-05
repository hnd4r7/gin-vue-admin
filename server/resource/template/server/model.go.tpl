package model

import (
	"santa/global"
)

// {{.StructName}} 结构体
// 如果含有time.Time 请自行import time包
type {{.StructName}} struct {
      global.MODEL {{- range .Fields}}
            {{- if ne .FieldType "string" }}
      {{.FieldName}}  *{{.FieldType}} `json:"{{.FieldJson}}" form:"{{.FieldJson}}" gorm:"column:{{.ColumnName}};comment:{{.Comment}}{{- if .DataType -}};type:{{.DataType}}{{- end }}"`
            {{- else }}
      {{.FieldName}}  {{.FieldType}} `json:"{{.FieldJson}}" form:"{{.FieldJson}}" gorm:"column:{{.ColumnName}};comment:{{.Comment}}{{- if .DataType -}};type:{{.DataType}}{{- if eq .FieldType "string" -}}{{- if .DataTypeLong -}}({{.DataTypeLong}}){{- end -}}{{- end -}};{{- if ne .FieldType "string" -}}{{- if .DataTypeLong -}}size:{{.DataTypeLong}};{{- end -}}{{- end -}}{{- end -}}"`
            {{- end }} {{- end }}
}

{{ if .TableName }}
func ({{.StructName}}) TableName() string {
  return "{{.TableName}}"
}
{{ end }}
