package ${packageName}.repository;
import java.io.Serializable;
import javax.persistence.*;
import lombok.Data;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import org.hibernate.annotations.Type;

/**
*  ${classInfo.classComment}
* @author ${authorName} ${.now?string('yyyy-MM-dd')}
*/
@Entity
@Data
@Table(name="${classInfo.tableName}")
public class ${classInfo.className}  {
<#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0>
    <#list classInfo.fieldList as fieldItem >
    /**
    * ${fieldItem.fieldComment}
    */
    <#if fieldItem.primaryKey>
    @Id
    @GeneratedValue
    </#if>
    <#if fieldItem.annotation?exists>
    ${fieldItem.annotation}
    </#if>
    private ${fieldItem.fieldClass} ${fieldItem.fieldName};
    </#list>
</#if>

}