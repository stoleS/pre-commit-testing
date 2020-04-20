const { sayHello } = require('../../utils/string-utils')

describe('String utils tests', () => {
  it('should return provided name in message!', () => {
    const names = ['Predrag', 'Milos', 'Djordje']

    names.forEach(name => {
      const res = sayHello(name)
      expect(res).toBe(`Hello ${name}!`)
    })
  })
})
