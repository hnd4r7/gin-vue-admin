package service

import (
	"santa/global"
	"santa/model"
	"santa/model/request"
)

func Create{{.StructName}}({{.Abbreviation}} model.{{.StructName}}) (err error) {
	err = global.DB.Create(&{{.Abbreviation}}).Error
	return err
}


func Delete{{.StructName}}(id int) (err error) {
    var {{.Abbreviation}} model.{{.StructName}}
	err = global.DB.Where("id = ?", id).Delete(&{{.Abbreviation}}).Error
	return err
}


func Update{{.StructName}}({{.Abbreviation}} model.{{.StructName}}) (err error) {
    cur, err := Get{{.StructName}}({{.Abbreviation}}.ID)
	if err != nil {
		return err
	}
	{{.Abbreviation}}.MODEL = cur.MODEL
	err = global.DB.Save(&{{.Abbreviation}}).Error
	return err
}

func Get{{.StructName}}(id int) ({{.Abbreviation}} model.{{.StructName}}, err error) {
	err = global.DB.Where("id = ?", id).First(&{{.Abbreviation}}).Error
	return
}

func List{{.StructName}}(info request.{{.StructName}}Search) (list []*model.{{.StructName}}, total int64, err error) {
	db := global.DB.Model(&model.{{.StructName}}{})
    var {{.Abbreviation}}s []*model.{{.StructName}}
        {{- range .Fields}}
            {{- if .FieldSearchType}}
                {{- if eq .FieldType "string" }}
    if info.{{.FieldName}} != "" {
        db = db.Where("`{{.ColumnName}}` {{.FieldSearchType}} ?",{{if eq .FieldSearchType "LIKE"}}"%"+ {{ end }}info.{{.FieldName}}{{if eq .FieldSearchType "LIKE"}}+"%"{{ end }})
    }
                {{- else if eq .FieldType "bool" }}
    if info.{{.FieldName}} != nil {
        db = db.Where("`{{.ColumnName}}` {{.FieldSearchType}} ?",{{if eq .FieldSearchType "LIKE"}}"%"+{{ end }}info.{{.FieldName}}{{if eq .FieldSearchType "LIKE"}}+"%"{{ end }})
    }
                {{- else if eq .FieldType "int" }}
    if info.{{.FieldName}} != nil {
        db = db.Where("`{{.ColumnName}}` {{.FieldSearchType}} ?",{{if eq .FieldSearchType "LIKE"}}"%"+{{ end }}info.{{.FieldName}}{{if eq .FieldSearchType "LIKE"}}+"%"{{ end }})
    }
                {{- else if eq .FieldType "float64" }}
    if info.{{.FieldName}} != nil {
        db = db.Where("`{{.ColumnName}}` {{.FieldSearchType}} ?",{{if eq .FieldSearchType "LIKE"}}"%"+{{ end }}info.{{.FieldName}}{{if eq .FieldSearchType "LIKE"}}+"%"{{ end }})
    }
                {{- else if eq .FieldType "time.Time" }}
    if info.{{.FieldName}} != nil {
         db = db.Where("`{{.ColumnName}}` {{.FieldSearchType}} ?",{{if eq .FieldSearchType "LIKE"}}"%"+{{ end }}info.{{.FieldName}}{{if eq .FieldSearchType "LIKE"}}+"%"{{ end }})
    }
                {{- end }}
        {{- end }}
    {{- end }}
	err = db.Count(&total).Error
	if err!=nil {
    	return
    }
    if info.Page != -1 {
		limit := info.PageSize
		offset := info.PageSize * (info.Page - 1)
		db = db.Limit(limit).Offset(offset)
	}
	err = db.Find(&{{.Abbreviation}}s).Error
	return {{.Abbreviation}}s, total, err
}
