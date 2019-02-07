import ApplicationRecord from './application-record'
import { Model, Attr } from 'spraypaint'

@Model({
  jsonapiType: 'registrations'
})
export class Registration extends ApplicationRecord {
  @Attr email!: string
  @Attr name!: string
  @Attr password!: string
  @Attr passwordConfirmation!: string
}
