import ApplicationRecord from './application-record'
import { Model, Attr, BelongsTo } from 'spraypaint'
import { User } from './user'

@Model({
  jsonapiType: 'credentials'
})
export class Credential extends ApplicationRecord {
  @Attr email!: string
  @Attr password!: string
  @Attr({persist: false}) jsonWebToken!: string
  @BelongsTo() user!: User
}
