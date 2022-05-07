package sqltil

import (
	"github.com/beego/beego/v2/client/orm"
	"strings"
)

//转义like语法的%_符号
func EscapeLike(keyword string) string {
	return strings.Replace(strings.Replace(keyword, "_", "\\_", -1), "%", "\\%", -1)
}

func DBSpecificLimitOffset(driverType orm.DriverType) string {
	switch driverType {
	case orm.DRPostgres:
		return " OFFSET ? LIMIT ?"

	}
	return " LIMIT ?, ?"
}
