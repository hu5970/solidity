{
	// This is a test for an older version where
	// inlining was performed on a function
	// just being called. This is a problem
	// because the statemenst of the original
	// function might be in an invalid state.

	function f(x) {
		mstore(0, x)
		mstore(7, h())
		g(10)
		mstore(1, x)
	}
	function g(x) {
		f(1)
	}
	function h() -> t {
		t := 2

	}
	{
		f(100)
	}
}
// ----
// fullInliner
// {
//     {
//         {
//             f(100)
//         }
//     }
//     function f(x)
//     {
//         mstore(0, x)
//         let h_t
//         h_t := 2
//         mstore(7, h_t)
//         let g_x_1 := 10
//         f(1)
//         mstore(1, x)
//     }
//     function g(x_1)
//     {
//         f(1)
//     }
//     function h() -> t
//     {
//         t := 2
//     }
// }
