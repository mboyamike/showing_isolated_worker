onmessage = a => { var t, s; void 0 !== a.data[0] && "$init_scripts" === a.data[0] ? (s = a.data.slice(1), _i(s)) : (t = a.data[0], s = a.data[1], a = a.data[2], _d(t, s, a)) }; const _i = a => { importScripts(...a) }, _d = async (s, e, a) => { try { let t; if ("string" == typeof e) t = self[e]; else { var r = e.length; t = self[e[0]]; for (let a = 1; a < r; a++)t = t[e[a]] } var i = await t(a); postMessage([s, e, "result", i]) } catch (a) { postMessage([s, e, "error", a]) } };


function fibonacci(n) {
    if (n <= 2) {
        return 1
    }
    return fibonacci(n-1) + fibonacci(n-2);
}