<template>
  <div class="form-group">
    <label
      v-if="label"
      :for="labelId"
    >
      {{ label }}
    </label>
    <input
      class="form-control"
      :class="{
        'is-invalid': !!errorMessage,
      }"
      :id="labelId"
      :value="value"
      v-bind="$attrs"
      v-on="listeners"
    />
    <div
      v-if='errorMessage'
      class="invalid-feedback"
    >
      {{ errorMessage }}
    </div>
  </div>
</template>

<script lang="ts">
import Vue from 'vue'
export default Vue.extend({
  props: {
    value: {
      required: false,
      type: String,
      default: ""
    },
    label: {
      required: false,
      type: String,
      default: undefined
    },
    error: {
      required: false,
      default: null,
      type: [String, Object],
      validator(value: string | { fullMessage? : string }) : boolean {
        if (typeof value === 'string') {
          return true
        }
        if (value.fullMessage) {
          return true
        }
        // eslint-disable-next-line no-console
        console.warn("InputText's `error` prop should be a string or an object with a `fullMessage` string property")
        return false
      }
    }
  },
  inheritAttrs: false,
  computed: {
    labelId(): string {
      return `input-${(this as any)._uid}`
    },
    listeners(): Record<string, Function | Function[]> {
      return {
        ...this.$listeners,
        input: ($event: any) => {
          this.updateValue($event.target.value)
        }
      }
    },
    errorMessage(): string | undefined {
      if (!(this as any).error) {
        return undefined
      }
      if (typeof (this as any).error === "string") {
        return (this as any).error
      } else if ((this as any).error.fullMessage) {
        return (this as any).error.fullMessage
      } else {
        return undefined
      }
    },
  },
  methods: {
    updateValue(value: string | undefined) {
      this.$emit("input", value)
    },
  }
})
</script>
