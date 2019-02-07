import ApplicationRecord from './application-record'
import { Model, Attr } from 'spraypaint'

@Model({
  jsonapiType: 'users'
})
export class User extends ApplicationRecord {
  @Attr email!: string
  @Attr name!: string
  @Attr avatarUrl!: string
}
