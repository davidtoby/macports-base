# filetypes.tcl --
#
#	Tcl based file type recognizer using the runtime core and
#	generated from /usr/share/misc/magic.mime. Limited output,
#	but only mime-types, i.e. standardized.
#
# Copyright (c) 2016-2017 Poor Yorick     <tk.tcl.core.tcllib@pooryorick.com>
# Copyright (c) 2004-2005 Colin McCormack <coldstore@users.sourceforge.net>
# Copyright (c) 2005-2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
#
# See the file "license.terms" for information on usage and redistribution
# of this file, and for a DISCLAIMER OF ALL WARRANTIES.

#####
#
# "mime type discriminator"
# http://wiki.tcl.tk/12537
#
# Tcl code harvested on:  10 Feb 2005, 04:16 GMT
# Wiki page last updated: ???
#
#####

# ### ### ### ######### ######### #########
## Requirements.

package require Tcl 8.6
package require fileutil::magic::rt 3-

# ### ### ### ######### ######### #########
## Implementation

namespace eval ::fileutil::magic::filetype {
    namespace import ::fileutil::magic::rt::*
}

proc ::fileutil::magic::filetype file {
    namespace upvar filetype named named tests tests
    if {![file exists $file]} {
	return -code error "file not found: \"$file\""
    }
    if {[file isdirectory $file]} {
	return [list directory application/x-directory {}]
    }

    set chan [open $file]
    try {
	set matches {}
	file stat $file stats
	set finfo [array get stats]
	dict set finfo name $file
	set ft [rt::new $finfo $chan $named [
	    list [namespace which filetype::analyze]]]
	set class [$ft]
	while 1 {
	    lassign [$ft] weight result mimetype ext 
	    dict update matches $weight weight {
		lappend weight [list $result $mimetype $ext]
	    }
	}
    } finally {
	close $chan
    }

    set keys [dict keys $matches]
    if {[llength $keys]} {
	set res [lindex [dict get $matches [::tcl::mathfunc::max {*}$keys]] end]
	lassign $res result mimetype ext
	foreach item $result {
	    if {$item ne {}} {
		return $res
	    }
	}
	if {$mimtetype ne {} || $ext ne {}} {
	    return $res
	}
    }
    return [list $class {} {}]
}


package provide fileutil::magic::filetype 2.0.1


namespace eval ::fileutil::magic::filetype {
# The actual recognizer is the command below.

##
## -- Do not edit after this line !
## -- ** BEGIN GENERATED CODE ** --

variable named {
	7
		{PIT-entry {if {[N ulequad [O 0] 0 0 & 18446744060824649724 == 0]} {
		>
			if {[N ubyte [O 36] 0 0 {} {} != 0]} {
				>
					if {[S string [O 36] 0 {} {} > \0]} {
						>
							emit %-.32s
						<
					}
	
					if {[N ulelong [O 12] 0 0 & 2 == 2]} {
						>
							emit {\b+RW}
						<
					}
	
					if {[N ulelong [O 8] 0 0 {} {} x {}]} {
						>
							emit (0x%x)
						<
					}
	
					if {[S string [O 68] 0 {} {} > \0]} {
						>
							emit {"%-.64s"}
						<
					}
	
				<
			}
	
		<
	}
	}}
	12
		{apple-driver-map {if {[N ubequad [O 0] 0 0 {} {} != 0]} {
		>
			if {[N ubelong [O 0] 0 0 {} {} x {}]} {
				>
					emit {\b, driver start block %u}
				<
			}
	
			if {[N ubeshort [O 4] 0 0 {} {} x {}]} {
				>
					emit {\b, size %u}
				<
			}
	
			if {[N ubeshort [O 6] 0 0 {} {} x {}]} {
				>
					emit {\b, type 0x%x}
				<
			}
	
		<
	}
	} apple-apm {if {[N belong [O 0] 0 0 {} {} == 1347223552]} {
		>
			emit {Apple Partition Map}
			if {[N ubelong [O 4] 0 0 {} {} x {}]} {
				>
					emit {\b, map block count %u}
				<
			}
	
			if {[N ubelong [O 8] 0 0 {} {} x {}]} {
				>
					emit {\b, start block %u}
				<
			}
	
			if {[N ubelong [O 12] 0 0 {} {} x {}]} {
				>
					emit {\b, block count %u}
				<
			}
	
			if {[S string [O 16] 0 {} {} > 0]} {
				>
					emit {\b, name %s}
				<
			}
	
			if {[S string [O 48] 0 {} {} > 0]} {
				>
					emit {\b, type %s}
				<
			}
	
			if {[S string [O 120] 0 {} {} > 0]} {
				>
					emit {\b, processor %s}
				<
			}
	
			if {[S string [O 136] 0 {} {} > 0]} {
				>
					emit {\b, boot arguments %s}
				<
			}
	
			if {[N belong [O 88] 0 0 {} {} & 1]} {
				>
					emit {\b, valid}
				<
			}
	
			if {[N belong [O 88] 0 0 {} {} & 2]} {
				>
					emit {\b, allocated}
				<
			}
	
			if {[N belong [O 88] 0 0 {} {} & 4]} {
				>
					emit {\b, in use}
				<
			}
	
			if {[N belong [O 88] 0 0 {} {} & 8]} {
				>
					emit {\b, has boot info}
				<
			}
	
			if {[N belong [O 88] 0 0 {} {} & 16]} {
				>
					emit {\b, readable}
				<
			}
	
			if {[N belong [O 88] 0 0 {} {} & 32]} {
				>
					emit {\b, writable}
				<
			}
	
			if {[N belong [O 88] 0 0 {} {} & 64]} {
				>
					emit {\b, pic boot code}
				<
			}
	
			if {[N belong [O 88] 0 0 {} {} & 128]} {
				>
					emit {\b, chain compatible driver}
				<
			}
	
			if {[N belong [O 88] 0 0 {} {} & 256]} {
				>
					emit {\b, real driver}
				<
			}
	
			if {[N belong [O 88] 0 0 {} {} & 512]} {
				>
					emit {\b, chain driver}
				<
			}
	
			if {[N ubelong [O 88] 0 0 {} {} & 1073741824]} {
				>
					emit {\b, mount at startup}
				<
			}
	
			if {[N ubelong [O 88] 0 0 {} {} & 2147483648]} {
				>
					emit {\b, is the startup partition}
				<
			}
	
		<
	}
	} appleworks {switch [Nv belong [O 0] 0 & 16777215] {
		34819 {
			>
				emit {ClarisWorks CWK Document}
			<
		}
		516352 {
			>
				emit {AppleWorks CWK Document}
			<
		}
	}
	
	if {[D [O 0]]} {
		>
			if {[N belong [O 0] 0 0 {} {} x {}]} {
				>
					emit {AppleWorks/ClarisWorks CWK Document}
				<
			}
	
		<
	}
	
	if {[N byte [O 0] 0 0 {} {} x {}]} {
		>
			emit {\b, version %d}
		<
	}
	
	if {[N beshort [O 30] 0 0 {} {} x {}]} {
		>
			emit {\b, %d}
		<
	}
	
	if {[N beshort [O 32] 0 0 {} {} x {}]} {
		>
			emit {\bx%d}
			ext cwk
		<
	}
	}}
	15
		{apt-cache-64bit-be {if {[N beshort [O 12] 0 0 {} {} == 1]} {
		>
			emit {\b, dirty}
		<
	}
	
	if {[N bequad [O 40] 0 0 {} {} x {}]} {
		>
			emit {\b, %llu packages}
		<
	}
	
	if {[N bequad [O 48] 0 0 {} {} x {}]} {
		>
			emit {\b, %llu versions}
		<
	}
	} apt-cache-32bit-be {if {[N beshort [O 8] 0 0 {} {} == 1]} {
		>
			emit {\b, dirty}
		<
	}
	
	if {[N belong [O 40] 0 0 {} {} x {}]} {
		>
			emit {\b, %u packages}
		<
	}
	
	if {[N belong [O 44] 0 0 {} {} x {}]} {
		>
			emit {\b, %u versions}
		<
	}
	} apt-cache-be {if {[N byte [O 6] 0 0 {} {} == 1]} {
		>
			emit {\b, dirty}
		<
	}
	
	if {[N belong [O 24] 0 0 {} {} x {}]} {
		>
			emit {\b, %u packages}
		<
	}
	
	if {[N belong [O 28] 0 0 {} {} x {}]} {
		>
			emit {\b, %u versions}
		<
	}
	}}
	16
		{tar-file {if {[S string [O 257] 0 {} {} ne ustar]} {
		>
			if {[N ulong [O 257] 0 0 {} {} == 0]} {
				>
					switch [Nv ubyte [O 156] 0 {} {}] {
						76 {
							>
								emit {GNU tar archive}
								mime application/x-gtar
								ext tar/gtar
							<
						}
						77 {
							>
								emit {GNU tar archive}
								mime application/x-gtar
								ext tar/gtar
							<
						}
						86 {
							>
								emit {GNU tar archive}
								mime application/x-gtar
								ext tar/gtar
							<
						}
					}
	
					if {[D [O 156]]} {
						>
							emit {tar archive (V7)}
							mime application/x-tar
							ext tar
						<
					}
	
				<
			}
	
			if {[N ulong [O 257] 0 0 {} {} != 0]} {
				>
					emit {tar archive (old)}
					mime application/x-tar
					ext tar
				<
			}
	
		<
	}
	
	if {[S string [O 257] 0 {} {} eq ustar]} {
		>
			switch [Nv ubelong [O 261] 0 {} {}] {
				1912602624 {
					>
						emit {tar archive (ustar)}
						mime application/x-ustar
						ext tar/ustar
					<
				}
				1912614960 {
					>
						emit POSIX
						switch [Nv ubyte [O 156] 0 {} {}] {
							103 {
								>
									emit {\b.1-2001}
								<
							}
							120 {
								>
									emit {\b.1-2001}
								<
							}
						}
	
						if {[N ubyte [O 156] 0 0 {} {} x {}]} {
							>
								emit {tar archive}
								mime application/x-ustar
								ext tar/ustar
							<
						}
	
					<
				}
				1914707968 {
					>
						emit {POSIX tar archive (GNU)}
						mime application/x-gtar
						ext tar/gtar
					<
				}
			}
	
			if {[D [O 261]]} {
				>
					emit {tar archive (unknown ustar)}
					mime application/x-ustar
					ext tar/ustar
				<
			}
	
		<
	}
	
	if {[N ubyte [O 156] 0 0 {} {} x {}]} {
		>
			switch [Nv ubyte [O 156] 0 {} {}] {
				0 {
					>
						emit {\b, file}
					<
				}
				48 {
					>
						emit {\b, file}
					<
				}
				49 {
					>
						emit {\b, hard link}
					<
				}
				50 {
					>
						emit {\b, symlink}
					<
				}
				51 {
					>
						emit {\b, char device}
					<
				}
				52 {
					>
						emit {\b, block device}
					<
				}
				53 {
					>
						emit {\b, directory}
					<
				}
				54 {
					>
						emit {\b, fifo}
					<
				}
				55 {
					>
						emit {\b, reserved}
					<
				}
				76 {
					>
						emit {\b, long path}
					<
				}
				77 {
					>
						emit {\b, multi volume}
					<
				}
				86 {
					>
						emit {\b, volume}
					<
				}
				103 {
					>
						emit {\b, global}
					<
				}
				120 {
					>
						emit {\b, extension}
					<
				}
			}
	
			if {[D [O 156]]} {
				>
					emit {\b, type}
					if {[N ubyte [O 156] 0 0 {} {} x {}]} {
						>
							emit '%c'
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string [O 0] 0 {} {} > \0]} {
		>
			emit %-.60s
		<
	}
	
	if {[S string [O 100] 0 {} {} > \0]} {
		>
			emit {\b, mode %-.7s}
		<
	}
	
	if {[S string [O 108] 0 {} {} > \0]} {
		>
			emit {\b, uid %-.7s}
		<
	}
	
	if {[S string [O 116] 0 {} {} > \0]} {
		>
			emit {\b, gid %-.7s}
		<
	}
	
	if {[N ubyte [O 124] 0 0 {} {} < 56]} {
		>
			if {[S string [O 124] 0 {} {} > \0]} {
				>
					emit {\b, size %-.12s}
				<
			}
	
		<
	}
	
	if {[N ubyte [O 124] 0 0 {} {} > 239]} {
		>
			emit {\b, size 0x}
			if {[N ubyte [O 124] 0 0 {} {} != 255]} {
				>
					emit {\b%2.2x}
				<
			}
	
			if {[N ubyte [O 125] 0 0 {} {} != 255]} {
				>
					emit {\b%2.2x}
				<
			}
	
			if {[N ubyte [O 126] 0 0 {} {} != 255]} {
				>
					emit {\b%2.2x}
				<
			}
	
			if {[N ubyte [O 127] 0 0 {} {} != 255]} {
				>
					emit {\b%2.2x}
				<
			}
	
			if {[N ubyte [O 128] 0 0 {} {} != 255]} {
				>
					emit {\b%2.2x}
				<
			}
	
			if {[N ubyte [O 129] 0 0 {} {} != 255]} {
				>
					emit {\b%2.2x}
				<
			}
	
			if {[N ubyte [O 130] 0 0 {} {} != 255]} {
				>
					emit {\b%2.2x}
				<
			}
	
			if {[N ubyte [O 131] 0 0 {} {} != 255]} {
				>
					emit {\b%2.2x}
				<
			}
	
			if {[N ubyte [O 132] 0 0 {} {} != 255]} {
				>
					emit {\b%2.2x}
				<
			}
	
			if {[N ubyte [O 133] 0 0 {} {} != 255]} {
				>
					emit {\b%2.2x}
				<
			}
	
			if {[N ubyte [O 134] 0 0 {} {} != 255]} {
				>
					emit {\b%2.2x}
				<
			}
	
			if {[N ubyte [O 135] 0 0 {} {} != 255]} {
				>
					emit {\b%2.2x}
				<
			}
	
		<
	}
	
	if {[S string [O 136] 0 {} {} > \0]} {
		>
			emit {\b, seconds %-.11s}
		<
	}
	
	if {[S string [O 157] 0 {} {} > \0]} {
		>
			emit {\b, linkname %-.40s}
		<
	}
	
	if {[S string [O 257] 0 {} {} eq ustar]} {
		>
			if {[S string [O 265] 0 {} {} > \0]} {
				>
					emit {\b, user %-.32s}
				<
			}
	
			if {[S string [O 297] 0 {} {} > \0]} {
				>
					emit {\b, group %-.32s}
				<
			}
	
			if {[N ubequad [O 329] 0 0 & 14974415777481871327 != 0]} {
				>
					if {[S string [O 329] 0 {} {} x {}]} {
						>
							emit {\b, devmaj %-.7s}
						<
					}
	
				<
			}
	
			if {[N ubequad [O 337] 0 0 & 14974415777481871327 != 0]} {
				>
					if {[S string [O 337] 0 {} {} x {}]} {
						>
							emit {\b, devmin %-.7s}
						<
					}
	
				<
			}
	
			if {[S string [O 345] 0 {} {} > \0]} {
				>
					emit {\b, prefix %-.155s}
				<
			}
	
		<
	}
	
	if {[S string [O 257] 0 {} {} ne ustar]} {
		>
			if {[S string [O 508] 0 {} {} eq tar\0]} {
				>
					if {[S string [O 257] 0 {} {} > \0]} {
						>
							emit {\b, padding: %-.40s}
						<
					}
	
				<
			}
	
			if {[D [O 508]]} {
				>
					if {[S string [O 257] 0 {} {} > \0]} {
						>
							emit {\b, comment: %-.40s}
						<
					}
	
				<
			}
	
		<
	}
	} lharc-file {if {[S string [O 2] 0 {} {} eq -]} {
		>
			if {[S string [O 6] 0 {} {} eq -]} {
				>
					if {[N ubyte [O 20] 0 0 {} {} < 4]} {
						>
							if {[S regex [O 3] 0 {} {} eq ^(lh\[0-9a-ex\]|lz\[s2-8\]|pm\[012\]|pc1)]} {
								>
									emit {\b }
									if {[S string [O 2] 0 {} {} eq -lz]} {
										>
											emit {\b }
											if {[S string [O 2] 0 {} {} eq -lzs]} {
												>
													emit {LHa/LZS archive data}
												<
											}
	
											if {[S regex [O 3] 0 {} {} eq ^lz\[45\]]} {
												>
													emit {LHarc 1.x archive data}
												<
											}
	
											if {[S regex [O 3] 0 {} {} eq ^lz\[2378\]]} {
												>
													emit {LArc archive}
												<
											}
	
											ext lzs
										<
									}
	
									if {[S string [O 2] 0 {} {} eq -lh]} {
										>
											emit {\b}
											if {[S regex [O 3] 0 {} {} eq ^lh\[01\]]} {
												>
													emit {LHarc 1.x/ARX archive data}
													if {[S string [O 2] 0 {} {} eq -lh1]} {
														>
															emit {\b }
															ext lha/lzh/ice
														<
													}
	
												<
											}
	
											if {[S regex [O 3] 0 {} {} eq ^lh\[23d\]]} {
												>
													emit {LHa 2.x? archive data}
												<
											}
	
											if {[S regex [O 3] 0 {} {} eq ^lh\[7\]]} {
												>
													emit {LHa (2.x)/LHark archive data}
												<
											}
	
											if {[S regex [O 3] 0 {} {} eq ^lh\[456\]]} {
												>
													emit {LHa (2.x) archive data}
													if {[S string [O 2] 0 {} {} eq -lh5]} {
														>
															emit {\b }
															ext lha/lzh/rom/bin
														<
													}
	
												<
											}
	
											if {[S regex [O 3] 0 {} {} eq ^lh\[89a-ce\]]} {
												>
													emit {LHa (Joe Jared) archive}
												<
											}
	
											if {[S string [O 2] 0 {} {} eq -lhx]} {
												>
													emit {LHa (UNLHA32) archive}
												<
											}
	
											if {[S regex [O 3] 0 {} {} ne ^(lh1|lh5)]} {
												>
													emit {\b }
													ext lha/lzh
												<
											}
	
											if {[D [O 2]]} {
												>
													emit {LHa (unknown) archive}
												<
											}
	
										<
									}
	
									if {[S regex [O 3] 0 {} {} eq ^pm\[012\]]} {
										>
											emit {PMarc archive data}
											ext pma
										<
									}
	
									if {[S string [O 3] 0 {} {} x {}]} {
										>
											emit {[%3.3s]}
											U 16 lharc-header [O 0]
	
										<
									}
	
									mime application/x-lzh-compressed
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	} lharc-header {if {[N ubyte [O 0] 0 0 {} {} x {}]} {
		>
		<
	}
	
	switch [Nv ubyte [O 20] 0 {} {}] {
		1 {
			>
				if {[N ubyte [O [I 21 ubyte 0 + 0 24]] 0 0 {} {} < 33]} {
					>
						emit {\b, 0x%x OS}
					<
				}
	
				if {[N ubyte [O [I 21 ubyte 0 + 0 24]] 0 0 {} {} > 32]} {
					>
						emit {\b, '%c' OS}
					<
				}
	
			<
		}
		2 {
			>
				if {[N ubyte [O 23] 0 0 {} {} < 33]} {
					>
						emit {\b, 0x%x OS}
					<
				}
	
				if {[N ubyte [O 23] 0 0 {} {} > 32]} {
					>
						emit {\b, '%c' OS}
					<
				}
	
			<
		}
	}
	
	if {[N ubyte [O 20] 0 0 {} {} < 2]} {
		>
			if {[N ubyte [O 21] 0 0 {} {} > 0]} {
				>
					emit {\b, with}
					if {[S pstring [O 21] 0 {} {} x {}]} {
						>
							emit {"%s"}
						<
					}
	
				<
			}
	
		<
	}
	} rar-file-header {switch [Nv byte [O 24] 0 {} {}] {
		15 {
			>
				emit {\b, v1.5}
			<
		}
		20 {
			>
				emit {\b, v2.0}
			<
		}
		29 {
			>
				emit {\b, v4}
			<
		}
	}
	
	switch [Nv byte [O 15] 0 {} {}] {
		0 {
			>
				emit {\b, os: MS-DOS}
			<
		}
		1 {
			>
				emit {\b, os: OS/2}
			<
		}
		2 {
			>
				emit {\b, os: Win32}
			<
		}
		3 {
			>
				emit {\b, os: Unix}
			<
		}
		4 {
			>
				emit {\b, os: Mac OS}
			<
		}
		5 {
			>
				emit {\b, os: BeOS}
			<
		}
	}
	} rar-archive-header {if {[N leshort [O 3] 0 0 & 511 > 0]} {
		>
			emit {\b, flags:}
			if {[N leshort [O 3] 0 0 {} {} & 1]} {
				>
					emit ArchiveVolume
				<
			}
	
			if {[N leshort [O 3] 0 0 {} {} & 2]} {
				>
					emit Commented
				<
			}
	
			if {[N leshort [O 3] 0 0 {} {} & 4]} {
				>
					emit Locked
				<
			}
	
			if {[N leshort [O 3] 0 0 {} {} & 16]} {
				>
					emit NewVolumeNaming
				<
			}
	
			if {[N leshort [O 3] 0 0 {} {} & 8]} {
				>
					emit Solid
				<
			}
	
			if {[N leshort [O 3] 0 0 {} {} & 32]} {
				>
					emit Authenticated
				<
			}
	
			if {[N leshort [O 3] 0 0 {} {} & 64]} {
				>
					emit RecoveryRecordPresent
				<
			}
	
			if {[N leshort [O 3] 0 0 {} {} & 128]} {
				>
					emit EncryptedBlockHeader
				<
			}
	
			if {[N leshort [O 3] 0 0 {} {} & 256]} {
				>
					emit FirstVolume
				<
			}
	
		<
	}
	}}
	37
		{mach-o {U 37 mach-o-cpu [O 0]
	
	emit {\b:}
	T [O [I 8 ubelong 0 + 0 0]] {}
	
	if {[N belong [O 0] 0 0 {} {} x {}]} {
		>
			emit {\b]}
		<
	}
	}}
	47
		{display-coff {if {[N uleshort [O 18] 0 0 & 36480 == 0]} {
		>
			if {[S clear [O 0] 0 {} {} x {}]} {
				>
				<
			}
	
			switch [Nv uleshort [O 0] 0 {} {}] {
				332 {
					>
						emit {Intel 80386}
					<
				}
				1280 {
					>
						emit {Hitachi SH big-endian}
					<
				}
				1360 {
					>
						emit {Hitachi SH little-endian}
					<
				}
			}
	
			if {[D [O 0]]} {
				>
					if {[N uleshort [O 0] 0 0 {} {} x {}]} {
						>
							emit {type 0x%04x}
						<
					}
	
				<
			}
	
			if {[N uleshort [O 0] 0 0 {} {} x {}]} {
				>
					emit COFF
				<
			}
	
			if {[N leshort [O 18] 0 0 {} {} ^ 2]} {
				>
					emit {object file}
				<
			}
	
			if {[N leshort [O 18] 0 0 {} {} & 2]} {
				>
					emit executable
				<
			}
	
			if {[N leshort [O 18] 0 0 {} {} & 1]} {
				>
					emit {\b, no relocation info}
				<
			}
	
			if {[N leshort [O 18] 0 0 {} {} & 4]} {
				>
					emit {\b, no line number info}
				<
			}
	
			if {[N leshort [O 18] 0 0 {} {} & 8]} {
				>
					emit {\b, stripped}
				<
			}
	
			if {[N leshort [O 18] 0 0 {} {} ^ 8]} {
				>
					emit {\b, not stripped}
				<
			}
	
			if {[N uleshort [O 2] 0 0 {} {} < 2]} {
				>
					emit {\b, %d section}
				<
			}
	
			if {[N uleshort [O 2] 0 0 {} {} > 1]} {
				>
					emit {\b, %d sections}
				<
			}
	
			if {[N ulelong [O 8] 0 0 {} {} > 0]} {
				>
					emit {\b, symbol offset=0x%x}
				<
			}
	
			if {[N ulelong [O 12] 0 0 {} {} > 0]} {
				>
					emit {\b, %d symbols}
				<
			}
	
			if {[N uleshort [O 16] 0 0 {} {} > 0]} {
				>
					emit {\b, optional header size %d}
				<
			}
	
		<
	}
	}}
	50
		{zstd-dictionary-id {if {[N byte [O 0] 0 0 {} {} & 32]} {
		>
			emit {\b, Dictionary ID:}
			switch [Nv byte [O 0] 0 & 3] {
				0 {
					>
						emit None
					<
				}
				1 {
					>
						if {[N byte [O 1] 0 0 {} {} x {}]} {
							>
								emit %u
							<
						}
	
					<
				}
				2 {
					>
						if {[N leshort [O 1] 0 0 {} {} x {}]} {
							>
								emit %u
							<
						}
	
					<
				}
				3 {
					>
						if {[N lelong [O 1] 0 0 {} {} x {}]} {
							>
								emit %u
							<
						}
	
					<
				}
			}
	
		<
	}
	
	if {[N byte [O 0] 0 0 {} {} ^ 32]} {
		>
			emit {\b, Dictionary ID:}
			switch [Nv byte [O 0] 0 & 3] {
				0 {
					>
						emit None
					<
				}
				1 {
					>
						if {[N byte [O 2] 0 0 {} {} x {}]} {
							>
								emit %u
							<
						}
	
					<
				}
				2 {
					>
						if {[N leshort [O 2] 0 0 {} {} x {}]} {
							>
								emit %u
							<
						}
	
					<
				}
				3 {
					>
						if {[N lelong [O 2] 0 0 {} {} x {}]} {
							>
								emit %u
							<
						}
	
					<
				}
			}
	
		<
	}
	}}
	51
		{nes-rom-image-ines {switch [Nv byte [O 7] 0 & 12] {
		8 {
			>
				emit {(NES 2.0)}
			<
			>
				switch [Nv byte [O 12] 0 & 3] {
					0 {
						>
							emit {[NTSC]}
						<
					}
					1 {
						>
							emit {[PAL]}
						<
					}
				}
	
				if {[N byte [O 12] 0 0 & 2 == 2]} {
					>
						emit {[NTSC+PAL]}
					<
				}
	
			<
		}
	}
	
	if {[N byte [O 4] 0 0 {} {} x {}]} {
		>
			emit {\b: %ux16k PRG}
		<
	}
	
	if {[N byte [O 5] 0 0 {} {} x {}]} {
		>
			emit {\b, %ux8k CHR}
		<
	}
	
	if {[N byte [O 6] 0 0 & 8 == 8]} {
		>
			emit {[4-Scr]}
		<
	}
	
	switch [Nv byte [O 6] 0 & 9] {
		0 {
			>
				emit {[H-mirror]}
			<
		}
		1 {
			>
				emit {[V-mirror]}
			<
		}
	}
	
	if {[N byte [O 6] 0 0 & 2 == 2]} {
		>
			emit {[SRAM]}
		<
	}
	
	if {[N byte [O 6] 0 0 & 4 == 4]} {
		>
			emit {[Trainer]}
		<
	}
	
	switch [Nv byte [O 7] 0 & 3] {
		1 {
			>
				emit {[VS]}
				if {[N byte [O 7] 0 0 & 12 == 8]} {
					>
						switch [Nv byte [O 13] 0 & 15] {
							0 {
								>
									emit {\b, RP2C03B}
								<
							}
							1 {
								>
									emit {\b, RP2C03G}
								<
							}
							2 {
								>
									emit {\b, RP2C04-0001}
								<
							}
							3 {
								>
									emit {\b, RP2C04-0002}
								<
							}
							4 {
								>
									emit {\b, RP2C04-0003}
								<
							}
							5 {
								>
									emit {\b, RP2C04-0004}
								<
							}
							6 {
								>
									emit {\b, RP2C03B}
								<
							}
							7 {
								>
									emit {\b, RP2C03C}
								<
							}
							8 {
								>
									emit {\b, RP2C05-01}
								<
							}
							9 {
								>
									emit {\b, RP2C05-02}
								<
							}
							10 {
								>
									emit {\b, RP2C05-03}
								<
							}
							11 {
								>
									emit {\b, RP2C05-04}
								<
							}
							12 {
								>
									emit {\b, RP2C05-05}
								<
							}
						}
	
					<
				}
	
				if {[N byte [O 7] 0 0 {} {} x {}]} {
					>
						emit {\b]}
					<
				}
	
			<
		}
		2 {
			>
				emit {[PC10]}
			<
		}
	}
	} nintendo-fds-disk-info-block {if {[N byte [O 23] 0 0 {} {} != 1]} {
		>
			emit FMC-
		<
	}
	
	if {[N byte [O 23] 0 0 {} {} == 1]} {
		>
			emit FSC-
		<
	}
	
	if {[S string [O 16] 0 {} {} x {}]} {
		>
			emit {\b%.3s}
		<
	}
	
	if {[N byte [O 15] 0 0 {} {} x {}]} {
		>
			emit {\b, mfr %02X}
		<
	}
	
	if {[N byte [O 20] 0 0 {} {} x {}]} {
		>
			emit (Rev.%02u)
		<
	}
	} sega-mega-drive-header {if {[N byte [O 288] 0 0 {} {} > 32]} {
		>
			if {[S string [O 288] 0 {} {} > \0]} {
				>
					emit {\b: "%.16s"}
				<
			}
	
		<
	}
	
	if {[N byte [O 288] 0 0 {} {} < 33]} {
		>
			if {[S string [O 336] 0 {} {} > \0]} {
				>
					emit {\b: "%.16s"}
				<
			}
	
		<
	}
	
	if {[S string [O 384] 0 {} {} > \0]} {
		>
			emit (%.14s
			if {[S string [O 272] 0 {} {} > \0]} {
				>
					emit {\b, %.16s}
				<
			}
	
		<
	}
	
	if {[N byte [O 384] 0 0 {} {} == 0]} {
		>
			if {[S string [O 272] 0 {} {} > \0]} {
				>
					emit (%.16s
				<
			}
	
		<
	}
	
	if {[N byte [O 0] 0 0 {} {} x {}]} {
		>
			emit {\b)}
		<
	}
	} sega-genesis-smd-header {if {[N byte [O 0] 0 0 {} {} x {}]} {
		>
			emit {%dx16k blocks}
		<
	}
	
	if {[N byte [O 2] 0 0 {} {} == 0]} {
		>
			emit {\b, last in series or standalone}
		<
	}
	
	if {[N byte [O 2] 0 0 {} {} > 0]} {
		>
			emit {\b, split ROM}
		<
	}
	} sega-master-system-rom-header {switch [Nv byte [O 15] 0 & -16] {
		48 {
			>
				emit {Sega Master System}
				mime application/x-sms-rom
			<
		}
		64 {
			>
				emit {Sega Master System}
				mime application/x-sms-rom
			<
		}
		80 {
			>
				emit {Sega Game Gear}
				mime application/x-gamegear-rom
			<
		}
		96 {
			>
				emit {Sega Game Gear}
				mime application/x-gamegear-rom
			<
		}
		112 {
			>
				emit {Sega Game Gear}
				mime application/x-gamegear-rom
			<
		}
	}
	
	if {[D [O 15]]} {
		>
			emit {Sega Master System / Game Gear}
			mime application/x-sms-rom
		<
	}
	
	if {[N byte [O 0] 0 0 {} {} x {}]} {
		>
			emit {ROM image:}
		<
	}
	
	switch [Nv byte [O 14] 0 & -16] {
		-128 {
			>
				emit 8
			<
		}
		-112 {
			>
				emit 9
			<
		}
		-96 {
			>
				emit 10
			<
		}
		-80 {
			>
				emit 11
			<
		}
		-64 {
			>
				emit 12
			<
		}
		-48 {
			>
				emit 13
			<
		}
		-32 {
			>
				emit 14
			<
		}
		-16 {
			>
				emit 15
			<
		}
		0 {
			>
				if {[N leshort [O 12] 0 0 {} {} x {}]} {
					>
						emit %04x
					<
				}
	
			<
		}
		16 {
			>
				emit 1
			<
		}
		32 {
			>
				emit 2
			<
		}
		48 {
			>
				emit 3
			<
		}
		64 {
			>
				emit 4
			<
		}
		80 {
			>
				emit 5
			<
		}
		96 {
			>
				emit 6
			<
		}
		112 {
			>
				emit 7
			<
		}
	}
	
	if {[N byte [O 14] 0 0 & -16 != 0]} {
		>
			if {[N leshort [O 12] 0 0 {} {} x {}]} {
				>
					emit {\b%04x}
				<
			}
	
		<
	}
	
	if {[N byte [O 14] 0 0 & 15 x {}]} {
		>
			emit (Rev.%02d)
		<
	}
	
	switch [Nv byte [O 15] 0 & 15] {
		0 {
			>
				emit {(256 KB)}
			<
		}
		1 {
			>
				emit {(512 KB)}
			<
		}
		2 {
			>
				emit {(1 MB)}
			<
		}
		10 {
			>
				emit {(8 KB)}
			<
		}
		11 {
			>
				emit {(16 KB)}
			<
		}
		12 {
			>
				emit {(32 KB)}
			<
		}
		13 {
			>
				emit {(48 KB)}
			<
		}
		14 {
			>
				emit {(64 KB)}
			<
		}
		15 {
			>
				emit {(128 KB)}
			<
		}
	}
	} sega-saturn-disc-header {if {[S string [O 96] 0 {} {} > \0]} {
		>
			emit {\b: "%.32s"}
		<
	}
	
	if {[S string [O 32] 0 {} {} > \0]} {
		>
			emit (%.10s
			if {[S string [O 42] 0 {} {} > \0]} {
				>
					emit {\b, %.6s)}
				<
			}
	
			if {[N byte [O 42] 0 0 {} {} == 0]} {
				>
					emit {\b)}
				<
			}
	
		<
	}
	} sega-dreamcast-disc-header {if {[S string [O 128] 0 {} {} > \0]} {
		>
			emit {\b: "%.32s"}
		<
	}
	
	if {[S string [O 64] 0 {} {} > \0]} {
		>
			emit (%.10s
			if {[S string [O 74] 0 {} {} > \0]} {
				>
					emit {\b, %.6s)}
				<
			}
	
			if {[N byte [O 74] 0 0 {} {} == 0]} {
				>
					emit {\b)}
				<
			}
	
		<
	}
	} nintendo-gcn-disc-common {if {[S string [O 32] 0 {} {} x {}]} {
		>
			emit {"%.64s"}
		<
	}
	
	if {[S string [O 0] 0 {} {} x {}]} {
		>
			emit (%.6s
		<
	}
	
	if {[N byte [O 6] 0 0 {} {} > 0]} {
		>
			switch [Nv byte [O 6] 0 {} {}] {
				1 {
					>
						emit {\b, Disc 2}
					<
				}
				2 {
					>
						emit {\b, Disc 3}
					<
				}
				3 {
					>
						emit {\b, Disc 4}
					<
				}
			}
	
		<
	}
	
	if {[N byte [O 7] 0 0 {} {} x {}]} {
		>
			emit {\b, Rev.%02u)}
		<
	}
	
	if {[N belong [O 24] 0 0 {} {} == 1562156707]} {
		>
			if {[N beshort [O 96] 0 0 {} {} == 257]} {
				>
					emit {\b (Unencrypted)}
				<
			}
	
		<
	}
	} nintendo-3ds-version-code {if {[N leshort [O 0] 0 0 {} {} x {}]} {
		>
			emit {\b%u,}
		<
	}
	
	switch [Nv leshort [O 0] 0 & -1024] {
		0 {
			>
				emit 0
			<
		}
		1024 {
			>
				emit 1
			<
		}
		2048 {
			>
				emit 2
			<
		}
		3072 {
			>
				emit 3
			<
		}
		4096 {
			>
				emit 4
			<
		}
		5120 {
			>
				emit 5
			<
		}
		6144 {
			>
				emit 6
			<
		}
		7168 {
			>
				emit 7
			<
		}
		8192 {
			>
				emit 8
			<
		}
		9216 {
			>
				emit 9
			<
		}
		10240 {
			>
				emit 10
			<
		}
		11264 {
			>
				emit 11
			<
		}
		12288 {
			>
				emit 12
			<
		}
		13312 {
			>
				emit 13
			<
		}
		14336 {
			>
				emit 14
			<
		}
		15360 {
			>
				emit 15
			<
		}
	}
	
	switch [Nv leshort [O 0] 0 & 1008] {
		0 {
			>
				emit {\b.0}
			<
		}
		16 {
			>
				emit {\b.1}
			<
		}
		32 {
			>
				emit {\b.2}
			<
		}
		48 {
			>
				emit {\b.3}
			<
		}
		64 {
			>
				emit {\b.4}
			<
		}
		80 {
			>
				emit {\b.5}
			<
		}
		96 {
			>
				emit {\b.6}
			<
		}
		112 {
			>
				emit {\b.7}
			<
		}
		128 {
			>
				emit {\b.8}
			<
		}
		144 {
			>
				emit {\b.9}
			<
		}
		160 {
			>
				emit {\b.10}
			<
		}
		176 {
			>
				emit {\b.11}
			<
		}
		192 {
			>
				emit {\b.12}
			<
		}
		208 {
			>
				emit {\b.13}
			<
		}
		224 {
			>
				emit {\b.14}
			<
		}
		240 {
			>
				emit {\b.15}
			<
		}
	}
	
	if {[N leshort [O 0] 0 0 & 15 x {}]} {
		>
			emit {\b.%u}
		<
	}
	}}
	58
		{cups-le {if {[N lelong [O 280] 0 0 {} {} x {}]} {
		>
			emit {\b, %d}
		<
	}
	
	if {[N lelong [O 284] 0 0 {} {} x {}]} {
		>
			emit {\bx%d dpi}
		<
	}
	
	if {[N lelong [O 376] 0 0 {} {} x {}]} {
		>
			emit {\b, %dx}
		<
	}
	
	if {[N lelong [O 380] 0 0 {} {} x {}]} {
		>
			emit {\b%d pixels}
		<
	}
	
	if {[N lelong [O 388] 0 0 {} {} x {}]} {
		>
			emit {%d bits/color}
		<
	}
	
	if {[N lelong [O 392] 0 0 {} {} x {}]} {
		>
			emit {%d bits/pixel}
		<
	}
	
	switch [Nv lelong [O 400] 0 {} {}] {
		0 {
			>
				emit ColorOrder=Chunky
			<
		}
		1 {
			>
				emit ColorOrder=Banded
			<
		}
		2 {
			>
				emit ColorOrder=Planar
			<
		}
	}
	
	switch [Nv lelong [O 404] 0 {} {}] {
		0 {
			>
				emit ColorSpace=gray
			<
		}
		1 {
			>
				emit ColorSpace=RGB
			<
		}
		2 {
			>
				emit ColorSpace=RGBA
			<
		}
		3 {
			>
				emit ColorSpace=black
			<
		}
		4 {
			>
				emit ColorSpace=CMY
			<
		}
		5 {
			>
				emit ColorSpace=YMC
			<
		}
		6 {
			>
				emit ColorSpace=CMYK
			<
		}
		7 {
			>
				emit ColorSpace=YMCK
			<
		}
		8 {
			>
				emit ColorSpace=KCMY
			<
		}
		9 {
			>
				emit ColorSpace=KCMYcm
			<
		}
		10 {
			>
				emit ColorSpace=GMCK
			<
		}
		11 {
			>
				emit ColorSpace=GMCS
			<
		}
		12 {
			>
				emit ColorSpace=WHITE
			<
		}
		13 {
			>
				emit ColorSpace=GOLD
			<
		}
		14 {
			>
				emit ColorSpace=SILVER
			<
		}
		15 {
			>
				emit {ColorSpace=CIE XYZ}
			<
		}
		16 {
			>
				emit {ColorSpace=CIE Lab}
			<
		}
		17 {
			>
				emit ColorSpace=RGBW
			<
		}
		18 {
			>
				emit ColorSpace=sGray
			<
		}
		19 {
			>
				emit ColorSpace=sRGB
			<
		}
		20 {
			>
				emit ColorSpace=AdobeRGB
			<
		}
	}
	}}
	60
		{xbase-type {if {[N ubyte [O 0] 0 0 {} {} < 2]} {
		>
		<
	}
	
	if {[N ubyte [O 0] 0 0 {} {} > 1]} {
		>
			switch [Nv ubyte [O 0] 0 {} {}] {
				2 {
					>
						emit FoxBase
					<
				}
				3 {
					>
						emit {FoxBase+/dBase III}
						mime application/x-dbf
					<
				}
				4 {
					>
						emit {dBase IV}
						mime application/x-dbf
					<
				}
				5 {
					>
						emit {dBase V}
						mime application/x-dbf
					<
				}
				48 {
					>
						emit {Visual FoxPro}
						mime application/x-dbf
					<
				}
				49 {
					>
						emit {Visual FoxPro, autoincrement}
						mime application/x-dbf
					<
				}
				50 {
					>
						emit {Visual FoxPro, with field type Varchar}
						mime application/x-dbf
					<
				}
				67 {
					>
						emit {dBase IV, with SQL table}
						mime application/x-dbf
					<
				}
				123 {
					>
						emit {dBase IV, with memo}
						mime application/x-dbf
					<
				}
				131 {
					>
						emit {FoxBase+/dBase III, with memo .DBT}
						mime application/x-dbf
					<
				}
				135 {
					>
						emit {VISUAL OBJECTS, with memo file}
						mime application/x-dbf
					<
				}
				139 {
					>
						emit {dBase IV, with memo .DBT}
						mime application/x-dbf
					<
				}
				142 {
					>
						emit {dBase IV, with SQL table}
						mime application/x-dbf
					<
				}
				179 {
					>
						emit Flagship
					<
				}
				203 {
					>
						emit {dBase IV with SQL table, with memo .DBT}
						mime application/x-dbf
					<
				}
				229 {
					>
						emit {Clipper SIX with memo}
						mime application/x-dbf
					<
				}
				245 {
					>
						emit {FoxPro with memo}
						mime application/x-dbf
					<
				}
			}
	
			if {[D [O 0]]} {
				>
					emit xBase
					if {[N ubyte [O 0] 0 0 {} {} x {}]} {
						>
							emit (0x%x)
						<
					}
	
					mime application/x-dbf
				<
			}
	
		<
	}
	} xbase-date {if {[N ubelong [O 0] 0 0 {} {} x {}]} {
		>
		<
	}
	
	if {[N ubyte [O 1] 0 0 {} {} < 13]} {
		>
			if {[N ubyte [O 1] 0 0 {} {} > 0]} {
				>
					if {[N ubyte [O 2] 0 0 {} {} > 0]} {
						>
							if {[N ubyte [O 2] 0 0 {} {} < 32]} {
								>
									if {[N ubyte [O 0] 0 0 {} {} x {}]} {
										>
											if {[N ubyte [O 0] 0 0 {} {} < 100]} {
												>
													emit {\b %.2d}
												<
											}
	
											if {[N ubyte [O 0] 0 0 {} {} > 99]} {
												>
													emit {\b %d}
												<
											}
	
										<
									}
	
									if {[N ubyte [O 1] 0 0 {} {} x {}]} {
										>
											emit {\b-%d}
										<
									}
	
									if {[N ubyte [O 2] 0 0 {} {} x {}]} {
										>
											emit {\b-%d}
										<
									}
	
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	} dbase3-memo-print {if {[N ubyte [O 0] 0 0 {} {} x {}]} {
		>
			emit {dBase III DBT}
		<
	}
	
	if {[N ubyte [O 16] 0 0 {} {} != 3]} {
		>
			emit {\b, version number %u}
		<
	}
	
	if {[N lelong [O 0] 0 0 {} {} != 0]} {
		>
			emit {\b, next free block index %u}
		<
	}
	
	if {[N uleshort [O 20] 0 0 {} {} != 0]} {
		>
			emit {\b, block length %u}
		<
	}
	
	if {[S string [O 512] 0 {} {} > \0]} {
		>
			emit {\b, 1st item "%s"}
		<
	}
	} dbase4-memo-print {if {[N lelong [O 0] 0 0 {} {} x {}]} {
		>
			emit {dBase IV DBT}
			mime application/x-dbt
			ext dbt
		<
	}
	
	if {[N ubelong [O 8] 0 0 {} {} > 536870912]} {
		>
			if {[N uleshort [O 20] 0 0 {} {} > 0]} {
				>
					if {[S string [O 8] 0 {} {} > \0]} {
						>
							emit {\b of %-.8s.DBF}
						<
					}
	
				<
			}
	
		<
	}
	
	if {[N ulelong [O 4] 0 0 {} {} != 0]} {
		>
			if {[N ulelong [O 4] 0 0 & 63 == 0]} {
				>
					emit {\b, blocks size %u}
				<
			}
	
		<
	}
	
	if {[N uleshort [O 20] 0 0 {} {} > 0]} {
		>
			emit {\b, block length %u}
		<
	}
	
	if {[N lelong [O 0] 0 0 {} {} != 0]} {
		>
			emit {\b, next free block index %u}
		<
	}
	
	if {[N uleshort [O 20] 0 0 {} {} > 0]} {
		>
			if {[N ubelong [O [I 20 uleshort 0 + 0 0]] 0 0 {} {} x {}]} {
				>
					U 60 dbase4-memofield-print [R [O -4]]
	
				<
			}
	
		<
	}
	
	if {[N uleshort [O 20] 0 0 {} {} == 0]} {
		>
			if {[N ubelong [O 512] 0 0 {} {} x {}]} {
				>
					U 60 dbase4-memofield-print [R [O -4]]
	
				<
			}
	
		<
	}
	} dbase4-memofield-print {if {[N ubelong [O 0] 0 0 {} {} != 4294903808]} {
		>
			if {[N lelong [O 0] 0 0 {} {} x {}]} {
				>
					emit {\b, next free block %u}
				<
			}
	
			if {[N lelong [O 4] 0 0 {} {} x {}]} {
				>
					emit {\b, next used block %u}
				<
			}
	
		<
	}
	
	if {[N ubelong [O 0] 0 0 {} {} == 4294903808]} {
		>
			if {[N lelong [O 4] 0 0 {} {} x {}]} {
				>
					emit {\b, field length %d}
					if {[S string [O 8] 0 {} {} > \0]} {
						>
							emit {\b, 1st used item "%s"}
						<
					}
	
				<
			}
	
		<
	}
	} foxpro-memo-print {if {[N belong [O 0] 0 0 {} {} x {}]} {
		>
			emit {FoxPro FPT}
		<
	}
	
	if {[N ubeshort [O 6] 0 0 {} {} x {}]} {
		>
			emit {\b, blocks size %u}
		<
	}
	
	if {[N belong [O 0] 0 0 {} {} != 0]} {
		>
			emit {\b, next free block index %u}
		<
	}
	
	if {[N ubelong [O 512] 0 0 {} {} < 3]} {
		>
			emit {\b, field type %u}
		<
	}
	
	if {[N ubelong [O 512] 0 0 {} {} == 1]} {
		>
			if {[N belong [O 516] 0 0 {} {} > 0]} {
				>
					emit {\b, field length %d}
					if {[S string [O 520] 0 {} {} > \0]} {
						>
							emit {\b, 1st item "%s"}
						<
					}
	
				<
			}
	
		<
	}
	}}
	63
		{certinfo {}}
	68
		{new-dump-be {if {[N bedate [O 4] 0 0 {} {} x {}]} {
		>
			emit {This dump %s,}
		<
	}
	
	if {[N bedate [O 8] 0 0 {} {} x {}]} {
		>
			emit {Previous dump %s,}
		<
	}
	
	if {[N belong [O 12] 0 0 {} {} > 0]} {
		>
			emit {Volume %d,}
		<
	}
	
	if {[N belong [O 692] 0 0 {} {} == 0]} {
		>
			emit {Level zero, type:}
		<
	}
	
	if {[N belong [O 692] 0 0 {} {} > 0]} {
		>
			emit {Level %d, type:}
		<
	}
	
	switch [Nv belong [O 0] 0 {} {}] {
		1 {
			>
				emit {tape header,}
			<
		}
		2 {
			>
				emit {beginning of file record,}
			<
		}
		3 {
			>
				emit {map of inodes on tape,}
			<
		}
		4 {
			>
				emit {continuation of file record,}
			<
		}
		5 {
			>
				emit {end of volume,}
			<
		}
		6 {
			>
				emit {map of inodes deleted,}
			<
		}
		7 {
			>
				emit {end of medium (for floppy),}
			<
		}
	}
	
	if {[S string [O 676] 0 {} {} > \0]} {
		>
			emit {Label %s,}
		<
	}
	
	if {[S string [O 696] 0 {} {} > \0]} {
		>
			emit {Filesystem %s,}
		<
	}
	
	if {[S string [O 760] 0 {} {} > \0]} {
		>
			emit {Device %s,}
		<
	}
	
	if {[S string [O 824] 0 {} {} > \0]} {
		>
			emit {Host %s,}
		<
	}
	
	if {[N belong [O 888] 0 0 {} {} > 0]} {
		>
			emit {Flags %x}
		<
	}
	} old-dump-be {if {[N belong [O 12] 0 0 {} {} > 0]} {
		>
			emit {Volume %d,}
		<
	}
	
	if {[N belong [O 692] 0 0 {} {} == 0]} {
		>
			emit {Level zero, type:}
		<
	}
	
	if {[N belong [O 692] 0 0 {} {} > 0]} {
		>
			emit {Level %d, type:}
		<
	}
	
	switch [Nv belong [O 0] 0 {} {}] {
		1 {
			>
				emit {tape header,}
			<
		}
		2 {
			>
				emit {beginning of file record,}
			<
		}
		3 {
			>
				emit {map of inodes on tape,}
			<
		}
		4 {
			>
				emit {continuation of file record,}
			<
		}
		5 {
			>
				emit {end of volume,}
			<
		}
		6 {
			>
				emit {map of inodes deleted,}
			<
		}
		7 {
			>
				emit {end of medium (for floppy),}
			<
		}
	}
	
	if {[S string [O 676] 0 {} {} > \0]} {
		>
			emit {Label %s,}
		<
	}
	
	if {[S string [O 696] 0 {} {} > \0]} {
		>
			emit {Filesystem %s,}
		<
	}
	
	if {[S string [O 760] 0 {} {} > \0]} {
		>
			emit {Device %s,}
		<
	}
	
	if {[S string [O 824] 0 {} {} > \0]} {
		>
			emit {Host %s,}
		<
	}
	
	if {[N belong [O 888] 0 0 {} {} > 0]} {
		>
			emit {Flags %x}
		<
	}
	} ufs2-dump-be {if {[N beqdate [O 896] 0 0 {} {} x {}]} {
		>
			emit {This dump %s,}
		<
	}
	
	if {[N beqdate [O 904] 0 0 {} {} x {}]} {
		>
			emit {Previous dump %s,}
		<
	}
	
	if {[N belong [O 12] 0 0 {} {} > 0]} {
		>
			emit {Volume %d,}
		<
	}
	
	if {[N belong [O 692] 0 0 {} {} == 0]} {
		>
			emit {Level zero, type:}
		<
	}
	
	if {[N belong [O 692] 0 0 {} {} > 0]} {
		>
			emit {Level %d, type:}
		<
	}
	
	switch [Nv belong [O 0] 0 {} {}] {
		1 {
			>
				emit {tape header,}
			<
		}
		2 {
			>
				emit {beginning of file record,}
			<
		}
		3 {
			>
				emit {map of inodes on tape,}
			<
		}
		4 {
			>
				emit {continuation of file record,}
			<
		}
		5 {
			>
				emit {end of volume,}
			<
		}
		6 {
			>
				emit {map of inodes deleted,}
			<
		}
		7 {
			>
				emit {end of medium (for floppy),}
			<
		}
	}
	
	if {[S string [O 676] 0 {} {} > \0]} {
		>
			emit {Label %s,}
		<
	}
	
	if {[S string [O 696] 0 {} {} > \0]} {
		>
			emit {Filesystem %s,}
		<
	}
	
	if {[S string [O 760] 0 {} {} > \0]} {
		>
			emit {Device %s,}
		<
	}
	
	if {[S string [O 824] 0 {} {} > \0]} {
		>
			emit {Host %s,}
		<
	}
	
	if {[N belong [O 888] 0 0 {} {} > 0]} {
		>
			emit {Flags %x}
		<
	}
	}}
	71
		{vimnanoswap {if {[N byte [O 67] 0 0 {} {} == 0]} {
		>
			if {[N byte [O 107] 0 0 {} {} == 0]} {
				>
					if {[N ulelong [O 24] 0 0 {} {} x {}]} {
						>
							emit {\b, pid %d}
						<
					}
	
					if {[S string [O 28] 0 {} {} > \0]} {
						>
							emit {\b, user %s}
						<
					}
	
					if {[S string [O 68] 0 {} {} > \0]} {
						>
							emit {\b, host %s}
						<
					}
	
					if {[S string [O 108] 0 {} {} > \0]} {
						>
							emit {\b, file %s}
						<
					}
	
					if {[N byte [O 1007] 0 0 {} {} == 85]} {
						>
							emit {\b, modified}
						<
					}
	
				<
			}
	
		<
	}
	}}
	73
		{elf-mips {switch [Nv lelong [O 0] 0 & -268435456] {
		-2147483648 {
			>
				emit {MIPS64 rel2}
			<
		}
		-1879048192 {
			>
				emit {MIPS32 rel6}
			<
		}
		-1610612736 {
			>
				emit {MIPS64 rel6}
			<
		}
		0 {
			>
				emit MIPS-I
			<
		}
		268435456 {
			>
				emit MIPS-II
			<
		}
		536870912 {
			>
				emit MIPS-III
			<
		}
		805306368 {
			>
				emit MIPS-IV
			<
		}
		1073741824 {
			>
				emit MIPS-V
			<
		}
		1342177280 {
			>
				emit MIPS32
			<
		}
		1610612736 {
			>
				emit MIPS64
			<
		}
		1879048192 {
			>
				emit {MIPS32 rel2}
			<
		}
	}
	} elf-sparc {switch [Nv lelong [O 0] 0 & 16776960] {
		256 {
			>
				emit {V8+ Required,}
			<
		}
		512 {
			>
				emit {Sun UltraSPARC1 Extensions Required,}
			<
		}
		1024 {
			>
				emit {HaL R1 Extensions Required,}
			<
		}
		2048 {
			>
				emit {Sun UltraSPARC3 Extensions Required,}
			<
		}
	}
	
	switch [Nv lelong [O 0] 0 & 3] {
		0 {
			>
				emit {total store ordering,}
			<
		}
		1 {
			>
				emit {partial store ordering,}
			<
		}
		2 {
			>
				emit {relaxed memory ordering,}
			<
		}
	}
	} elf-pa-risc {if {[N leshort [O 2] 0 0 {} {} == 532]} {
		>
			emit 2.0
		<
	}
	
	if {[N leshort [O 0] 0 0 {} {} & 8]} {
		>
			emit (LP64)
		<
	}
	} elf-le {switch [Nv leshort [O 16] 0 {} {}] {
		0 {
			>
				emit {no file type,}
				mime application/octet-stream
			<
		}
		1 {
			>
				emit relocatable,
				mime application/x-object
			<
		}
		2 {
			>
				emit executable,
				mime application/x-executable
			<
		}
		3 {
			>
				emit {${x?pie executable:shared object},}
				mime {application/x-${x?pie-executable:sharedlib}}
			<
		}
		4 {
			>
				emit {core file,}
				mime application/x-coredump
			<
		}
	}
	
	if {[N byte [O 7] 0 0 {} {} == -54]} {
		>
			if {[N leshort [O 16] 0 0 {} {} == -511]} {
				>
					emit executable,
					mime application/x-executable
				<
			}
	
		<
	}
	
	if {[N leshort [O 16] 0 0 {} {} & -256]} {
		>
			emit processor-specific,
		<
	}
	
	if {[S clear [O 18] 0 {} {} x {}]} {
		>
		<
	}
	
	switch [Nv leshort [O 18] 0 {} {}] {
		-32233 {
			>
				emit {Ubicom IP2xxx (unofficial),}
			<
		}
		-31630 {
			>
				emit {OpenRISC (obsolete),}
			<
		}
		-28635 {
			>
				emit {Cygnus PowerPC (unofficial),}
			<
		}
		-28634 {
			>
				emit {Alpha (unofficial),}
			<
		}
		-28607 {
			>
				emit {Cygnus M32R (unofficial),}
			<
		}
		-28544 {
			>
				emit {Cygnus V850 (unofficial),}
			<
		}
		-23664 {
			>
				emit {IBM S/390 (obsolete),}
			<
		}
		-21561 {
			>
				emit {Old Xtensa (unofficial),}
			<
		}
		-21179 {
			>
				emit {xstormy16 (unofficial),}
			<
		}
		-17749 {
			>
				emit {Old MicroBlaze (unofficial),,}
			<
		}
		-16657 {
			>
				emit {Cygnus MN10300 (unofficial),}
			<
		}
		-8531 {
			>
				emit {Cygnus MN10200 (unofficial),}
			<
		}
		-4083 {
			>
				emit {Toshiba MeP (unofficial),}
			<
		}
		-336 {
			>
				emit {Renesas M32C (unofficial),}
			<
		}
		-326 {
			>
				emit {Vitesse IQ2000 (unofficial),}
			<
		}
		-325 {
			>
				emit {NIOS (unofficial),}
			<
		}
		-275 {
			>
				emit {Moxie (unofficial),}
			<
		}
		0 {
			>
				emit {no machine,}
			<
		}
		1 {
			>
				emit {AT&T WE32100,}
			<
		}
		2 {
			>
				emit SPARC,
			<
		}
		3 {
			>
				emit {Intel 80386,}
			<
		}
		4 {
			>
				emit {Motorola m68k,}
				if {[N byte [O 4] 0 0 {} {} == 1]} {
					>
						if {[N lelong [O 36] 0 0 {} {} & 16777216]} {
							>
								emit 68000,
							<
						}
	
						if {[N lelong [O 36] 0 0 {} {} & 8454144]} {
							>
								emit CPU32,
							<
						}
	
						if {[N lelong [O 36] 0 0 {} {} == 0]} {
							>
								emit 68020,
							<
						}
	
					<
				}
	
			<
		}
		5 {
			>
				emit {Motorola m88k,}
			<
		}
		6 {
			>
				emit {Intel 80486,}
			<
		}
		7 {
			>
				emit {Intel 80860,}
			<
		}
		8 {
			>
				emit MIPS,
				if {[N byte [O 4] 0 0 {} {} == 1]} {
					>
						if {[N lelong [O 36] 0 0 {} {} & 32]} {
							>
								emit N32
							<
						}
	
					<
				}
	
			<
			>
				switch [Nv byte [O 4] 0 {} {}] {
					1 {
						>
							U 73 elf-mips [O 36]
	
						<
					}
					2 {
						>
							U 73 elf-mips [O 48]
	
						<
					}
				}
	
			<
		}
		9 {
			>
				emit Amdahl,
			<
		}
		10 {
			>
				emit MIPS,
				if {[N byte [O 4] 0 0 {} {} == 1]} {
					>
						if {[N lelong [O 36] 0 0 {} {} & 32]} {
							>
								emit N32
							<
						}
	
					<
				}
	
			<
			>
				emit {MIPS (deprecated),}
			<
		}
		11 {
			>
				emit RS6000,
			<
		}
		15 {
			>
				emit PA-RISC,
				switch [Nv byte [O 4] 0 {} {}] {
					1 {
						>
							U 73 elf-pa-risc [O 36]
	
						<
					}
					2 {
						>
							U 73 elf-pa-risc [O 48]
	
						<
					}
				}
	
			<
		}
		16 {
			>
				emit nCUBE,
			<
		}
		17 {
			>
				emit {Fujitsu VPP500,}
			<
		}
		18 {
			>
				emit SPARC32PLUS,
				if {[N byte [O 4] 0 0 {} {} == 1]} {
					>
						U 73 elf-sparc [O 36]
	
					<
				}
	
			<
		}
		19 {
			>
				emit {Intel 80960,}
			<
		}
		20 {
			>
				emit {PowerPC or cisco 4500,}
			<
		}
		21 {
			>
				emit {64-bit PowerPC or cisco 7500,}
			<
		}
		22 {
			>
				emit {IBM S/390,}
			<
		}
		23 {
			>
				emit {Cell SPU,}
			<
		}
		24 {
			>
				emit {cisco SVIP,}
			<
		}
		25 {
			>
				emit {cisco 7200,}
			<
		}
		36 {
			>
				emit {NEC V800 or cisco 12000,}
			<
		}
		37 {
			>
				emit {Fujitsu FR20,}
			<
		}
		38 {
			>
				emit {TRW RH-32,}
			<
		}
		39 {
			>
				emit {Motorola RCE,}
			<
		}
		40 {
			>
				emit ARM,
				if {[N byte [O 4] 0 0 {} {} == 1]} {
					>
						switch [Nv lelong [O 36] 0 & -16777216] {
							67108864 {
								>
									emit EABI4
								<
							}
							83886080 {
								>
									emit EABI5
								<
							}
						}
	
						if {[N lelong [O 36] 0 0 {} {} & 8388608]} {
							>
								emit BE8
							<
						}
	
						if {[N lelong [O 36] 0 0 {} {} & 4194304]} {
							>
								emit LE8
							<
						}
	
					<
				}
	
			<
		}
		41 {
			>
				emit Alpha,
			<
		}
		42 {
			>
				emit {Renesas SH,}
			<
		}
		43 {
			>
				emit {SPARC V9,}
				if {[N byte [O 4] 0 0 {} {} == 2]} {
					>
						U 73 elf-sparc [O 48]
	
					<
				}
	
			<
		}
		44 {
			>
				emit {Siemens Tricore Embedded Processor,}
			<
		}
		45 {
			>
				emit {Argonaut RISC Core, Argonaut Technologies Inc.,}
			<
		}
		46 {
			>
				emit {Renesas H8/300,}
			<
		}
		47 {
			>
				emit {Renesas H8/300H,}
			<
		}
		48 {
			>
				emit {Renesas H8S,}
			<
		}
		49 {
			>
				emit {Renesas H8/500,}
			<
		}
		50 {
			>
				emit IA-64,
			<
		}
		51 {
			>
				emit {Stanford MIPS-X,}
			<
		}
		52 {
			>
				emit {Motorola Coldfire,}
			<
		}
		53 {
			>
				emit {Motorola M68HC12,}
			<
		}
		54 {
			>
				emit {Fujitsu MMA,}
			<
		}
		55 {
			>
				emit {Siemens PCP,}
			<
		}
		56 {
			>
				emit {Sony nCPU,}
			<
		}
		57 {
			>
				emit {Denso NDR1,}
			<
		}
		58 {
			>
				emit Start*Core,
			<
		}
		59 {
			>
				emit {Toyota ME16,}
			<
		}
		60 {
			>
				emit ST100,
			<
		}
		61 {
			>
				emit {Tinyj emb.,}
			<
		}
		62 {
			>
				emit x86-64,
			<
		}
		63 {
			>
				emit {Sony DSP,}
			<
		}
		64 {
			>
				emit {DEC PDP-10,}
			<
		}
		65 {
			>
				emit {DEC PDP-11,}
			<
		}
		66 {
			>
				emit FX66,
			<
		}
		67 {
			>
				emit {ST9+ 8/16 bit,}
			<
		}
		68 {
			>
				emit {ST7 8 bit,}
			<
		}
		69 {
			>
				emit MC68HC16,
			<
		}
		70 {
			>
				emit MC68HC11,
			<
		}
		71 {
			>
				emit MC68HC08,
			<
		}
		72 {
			>
				emit MC68HC05,
			<
		}
		73 {
			>
				emit {SGI SVx or Cray NV1,}
			<
		}
		74 {
			>
				emit {ST19 8 bit,}
			<
		}
		75 {
			>
				emit {Digital VAX,}
			<
		}
		76 {
			>
				emit {Axis cris,}
			<
		}
		77 {
			>
				emit {Infineon 32-bit embedded,}
			<
		}
		78 {
			>
				emit {Element 14 64-bit DSP,}
			<
		}
		79 {
			>
				emit {LSI Logic 16-bit DSP,}
			<
		}
		80 {
			>
				emit MMIX,
			<
		}
		81 {
			>
				emit {Harvard machine-independent,}
			<
		}
		82 {
			>
				emit {SiTera Prism,}
			<
		}
		83 {
			>
				emit {Atmel AVR 8-bit,}
			<
		}
		84 {
			>
				emit {Fujitsu FR30,}
			<
		}
		85 {
			>
				emit {Mitsubishi D10V,}
			<
		}
		86 {
			>
				emit {Mitsubishi D30V,}
			<
		}
		87 {
			>
				emit {NEC v850,}
			<
		}
		88 {
			>
				emit {Renesas M32R,}
			<
		}
		89 {
			>
				emit {Matsushita MN10300,}
			<
		}
		90 {
			>
				emit {Matsushita MN10200,}
			<
		}
		91 {
			>
				emit picoJava,
			<
		}
		92 {
			>
				emit OpenRISC,
			<
		}
		93 {
			>
				emit {ARC Cores Tangent-A5,}
			<
		}
		94 {
			>
				emit {Tensilica Xtensa,}
			<
		}
		95 {
			>
				emit {Alphamosaic VideoCore,}
			<
		}
		96 {
			>
				emit {Thompson Multimedia,}
			<
		}
		97 {
			>
				emit {NatSemi 32k,}
			<
		}
		98 {
			>
				emit {Tenor Network TPC,}
			<
		}
		99 {
			>
				emit {Trebia SNP 1000,}
			<
		}
		100 {
			>
				emit {STMicroelectronics ST200,}
			<
		}
		101 {
			>
				emit {Ubicom IP2022,}
			<
		}
		102 {
			>
				emit {MAX Processor,}
			<
		}
		103 {
			>
				emit {NatSemi CompactRISC,}
			<
		}
		104 {
			>
				emit {Fujitsu F2MC16,}
			<
		}
		105 {
			>
				emit {TI msp430,}
			<
		}
		106 {
			>
				emit {Analog Devices Blackfin,}
			<
		}
		107 {
			>
				emit {S1C33 Family of Seiko Epson,}
			<
		}
		108 {
			>
				emit {Sharp embedded,}
			<
		}
		109 {
			>
				emit {Arca RISC,}
			<
		}
		110 {
			>
				emit {PKU-Unity Ltd.,}
			<
		}
		111 {
			>
				emit {eXcess: 16/32/64-bit,}
			<
		}
		112 {
			>
				emit {Icera Deep Execution Processor,}
			<
		}
		113 {
			>
				emit {Altera Nios II,}
			<
		}
		114 {
			>
				emit {NatSemi CRX,}
			<
		}
		115 {
			>
				emit {Motorola XGATE,}
			<
		}
		116 {
			>
				emit {Infineon C16x/XC16x,}
			<
		}
		117 {
			>
				emit {Renesas M16C series,}
			<
		}
		118 {
			>
				emit {Microchip dsPIC30F,}
			<
		}
		119 {
			>
				emit {Freescale RISC core,}
			<
		}
		120 {
			>
				emit {Renesas M32C series,}
			<
		}
		131 {
			>
				emit {Altium TSK3000 core,}
			<
		}
		132 {
			>
				emit {Freescale RS08,}
			<
		}
		134 {
			>
				emit {Cyan Technology eCOG2,}
			<
		}
		135 {
			>
				emit {Sunplus S+core7 RISC,}
			<
		}
		136 {
			>
				emit {New Japan Radio (NJR) 24-bit DSP,}
			<
		}
		137 {
			>
				emit {Broadcom VideoCore III,}
			<
		}
		138 {
			>
				emit LatticeMico32,
			<
		}
		139 {
			>
				emit {Seiko Epson C17 family,}
			<
		}
		140 {
			>
				emit {TI TMS320C6000 DSP family,}
			<
		}
		141 {
			>
				emit {TI TMS320C2000 DSP family,}
			<
		}
		142 {
			>
				emit {TI TMS320C55x DSP family,}
			<
		}
		160 {
			>
				emit {STMicroelectronics 64bit VLIW DSP,}
			<
		}
		161 {
			>
				emit {Cypress M8C,}
			<
		}
		162 {
			>
				emit {Renesas R32C series,}
			<
		}
		163 {
			>
				emit {NXP TriMedia family,}
			<
		}
		164 {
			>
				emit {QUALCOMM DSP6,}
			<
		}
		165 {
			>
				emit {Intel 8051 and variants,}
			<
		}
		166 {
			>
				emit {STMicroelectronics STxP7x family,}
			<
		}
		167 {
			>
				emit {Andes embedded RISC,}
			<
		}
		168 {
			>
				emit {Cyan eCOG1X family,}
			<
		}
		169 {
			>
				emit {Dallas MAXQ30,}
			<
		}
		170 {
			>
				emit {New Japan Radio (NJR) 16-bit DSP,}
			<
		}
		171 {
			>
				emit {M2000 Reconfigurable RISC,}
			<
		}
		172 {
			>
				emit {Cray NV2 vector architecture,}
			<
		}
		173 {
			>
				emit {Renesas RX family,}
			<
		}
		174 {
			>
				emit META,
			<
		}
		175 {
			>
				emit {MCST Elbrus,}
			<
		}
		176 {
			>
				emit {Cyan Technology eCOG16 family,}
			<
		}
		177 {
			>
				emit {NatSemi CompactRISC,}
			<
		}
		178 {
			>
				emit {Freescale Extended Time Processing Unit,}
			<
		}
		179 {
			>
				emit {Infineon SLE9X,}
			<
		}
		180 {
			>
				emit {Intel L1OM,}
			<
		}
		181 {
			>
				emit {Intel K1OM,}
			<
		}
		183 {
			>
				emit {ARM aarch64,}
			<
		}
		185 {
			>
				emit {Atmel 32-bit family,}
			<
		}
		186 {
			>
				emit {STMicroeletronics STM8 8-bit,}
			<
		}
		187 {
			>
				emit {Tilera TILE64,}
			<
		}
		188 {
			>
				emit {Tilera TILEPro,}
			<
		}
		189 {
			>
				emit {Xilinx MicroBlaze 32-bit RISC,}
			<
		}
		190 {
			>
				emit {NVIDIA CUDA architecture,}
			<
		}
		191 {
			>
				emit {Tilera TILE-Gx,}
			<
		}
		197 {
			>
				emit {Renesas RL78 family,}
			<
		}
		199 {
			>
				emit {Renesas 78K0R,}
			<
		}
		200 {
			>
				emit {Freescale 56800EX,}
			<
		}
		201 {
			>
				emit {Beyond BA1,}
			<
		}
		202 {
			>
				emit {Beyond BA2,}
			<
		}
		203 {
			>
				emit {XMOS xCORE,}
			<
		}
		204 {
			>
				emit {Microchip 8-bit PIC(r),}
			<
		}
		210 {
			>
				emit {KM211 KM32,}
			<
		}
		211 {
			>
				emit {KM211 KMX32,}
			<
		}
		212 {
			>
				emit {KM211 KMX16,}
			<
		}
		213 {
			>
				emit {KM211 KMX8,}
			<
		}
		214 {
			>
				emit {KM211 KVARC,}
			<
		}
		215 {
			>
				emit {Paneve CDP,}
			<
		}
		216 {
			>
				emit {Cognitive Smart Memory,}
			<
		}
		217 {
			>
				emit {iCelero CoolEngine,}
			<
		}
		218 {
			>
				emit {Nanoradio Optimized RISC,}
			<
		}
		243 {
			>
				emit {UCB RISC-V,}
			<
		}
		4183 {
			>
				emit {AVR (unofficial),}
			<
		}
		4185 {
			>
				emit {MSP430 (unofficial),}
			<
		}
		4643 {
			>
				emit {Adapteva Epiphany (unofficial),}
			<
		}
		9520 {
			>
				emit {Morpho MT (unofficial),}
			<
		}
		13104 {
			>
				emit {FR30 (unofficial),}
			<
		}
		13350 {
			>
				emit {OpenRISC (obsolete),}
			<
		}
		18056 {
			>
				emit {Infineon C166 (unofficial),}
			<
		}
		21569 {
			>
				emit {Cygnus FRV (unofficial),}
			<
		}
		23205 {
			>
				emit {DLX (unofficial),}
			<
		}
		30288 {
			>
				emit {Cygnus D10V (unofficial),}
			<
		}
		30326 {
			>
				emit {Cygnus D30V (unofficial),}
			<
		}
	}
	
	if {[D [O 18]]} {
		>
			if {[N leshort [O 18] 0 0 {} {} x {}]} {
				>
					emit {*unknown arch 0x%x*}
				<
			}
	
		<
	}
	
	switch [Nv lelong [O 20] 0 {} {}] {
		0 {
			>
				emit {invalid version}
			<
		}
		1 {
			>
				emit {version 1}
			<
		}
	}
	}}
	79
		{partid {switch [Nv ubyte [O 0] 0 {} {}] {
		0 {
			>
				emit Unused
			<
		}
		1 {
			>
				emit {12-bit FAT}
			<
		}
		2 {
			>
				emit {XENIX /}
			<
		}
		3 {
			>
				emit {XENIX /usr}
			<
		}
		4 {
			>
				emit {16-bit FAT, less than 32M}
			<
		}
		5 {
			>
				emit {extended partition}
			<
		}
		6 {
			>
				emit {16-bit FAT, more than 32M}
			<
		}
		7 {
			>
				emit {OS/2 HPFS, NTFS, QNX2, Adv. UNIX}
			<
		}
		8 {
			>
				emit {AIX or os, or etc.}
			<
		}
		9 {
			>
				emit {AIX boot partition or Coherent}
			<
		}
		10 {
			>
				emit {O/2 boot manager or Coherent swap}
			<
		}
		11 {
			>
				emit {32-bit FAT}
			<
		}
		12 {
			>
				emit {32-bit FAT, LBA-mapped}
			<
		}
		13 {
			>
				emit {7XXX, LBA-mapped}
			<
		}
		14 {
			>
				emit {16-bit FAT, LBA-mapped}
			<
		}
		15 {
			>
				emit {extended partition, LBA-mapped}
			<
		}
		16 {
			>
				emit OPUS
			<
		}
		17 {
			>
				emit {OS/2 DOS 12-bit FAT}
			<
		}
		18 {
			>
				emit {Compaq diagnostics}
			<
		}
		20 {
			>
				emit {OS/2 DOS 16-bit FAT <32M}
			<
		}
		22 {
			>
				emit {OS/2 DOS 16-bit FAT >=32M}
			<
		}
		23 {
			>
				emit {OS/2 hidden IFS}
			<
		}
		24 {
			>
				emit {AST Windows swapfile}
			<
		}
		25 {
			>
				emit {Willowtech Photon coS}
			<
		}
		27 {
			>
				emit {hidden win95 fat 32}
			<
		}
		28 {
			>
				emit {hidden win95 fat 32 lba}
			<
		}
		29 {
			>
				emit {hidden win95 fat 16 lba}
			<
		}
		32 {
			>
				emit {Willowsoft OFS1}
			<
		}
		33 {
			>
				emit reserved
			<
		}
		35 {
			>
				emit reserved
			<
		}
		36 {
			>
				emit {NEC DOS}
			<
		}
		38 {
			>
				emit reserved
			<
		}
		49 {
			>
				emit reserved
			<
		}
		50 {
			>
				emit {Alien Internet Services NOS}
			<
		}
		51 {
			>
				emit reserved
			<
		}
		52 {
			>
				emit reserved
			<
		}
		53 {
			>
				emit {JFS on OS2}
			<
		}
		54 {
			>
				emit reserved
			<
		}
		56 {
			>
				emit Theos
			<
		}
		57 {
			>
				emit {Plan 9, or Theos spanned}
			<
		}
		58 {
			>
				emit {Theos ver 4 4gb partition}
			<
		}
		59 {
			>
				emit {Theos ve 4 extended partition}
			<
		}
		60 {
			>
				emit {PartitionMagic recovery}
			<
		}
		61 {
			>
				emit {Hidden Netware}
			<
		}
		64 {
			>
				emit {VENIX 286 or LynxOS}
			<
		}
		65 {
			>
				emit PReP
			<
		}
		66 {
			>
				emit {linux swap sharing DRDOS disk}
			<
		}
		67 {
			>
				emit {linux sharing DRDOS disk}
			<
		}
		68 {
			>
				emit {GoBack change utility}
			<
		}
		69 {
			>
				emit {Boot US Boot manager}
			<
		}
		70 {
			>
				emit {EUMEL/Elan or Ergos 3}
			<
		}
		71 {
			>
				emit {EUMEL/Elan or Ergos 3}
			<
		}
		72 {
			>
				emit {EUMEL/Elan or Ergos 3}
			<
		}
		74 {
			>
				emit {ALFX/THIN filesystem for DOS}
			<
		}
		76 {
			>
				emit {Oberon partition}
			<
		}
		77 {
			>
				emit QNX4.x
			<
		}
		78 {
			>
				emit {QNX4.x 2nd part}
			<
		}
		79 {
			>
				emit {QNX4.x 3rd part}
			<
		}
		80 {
			>
				emit {DM (disk manager)}
			<
		}
		81 {
			>
				emit {DM6 Aux1 (or Novell)}
			<
		}
		82 {
			>
				emit {CP/M or Microport SysV/AT}
			<
		}
		83 {
			>
				emit {DM6 Aux3}
			<
		}
		84 {
			>
				emit {DM6 DDO}
			<
		}
		85 {
			>
				emit {EZ-Drive (disk manager)}
			<
		}
		86 {
			>
				emit {Golden Bow (disk manager)}
			<
		}
		87 {
			>
				emit {Drive PRO}
			<
		}
		92 {
			>
				emit {Priam Edisk (disk manager)}
			<
		}
		97 {
			>
				emit SpeedStor
			<
		}
		99 {
			>
				emit {GNU HURD or Mach or Sys V/386}
			<
		}
		100 {
			>
				emit {Novell Netware 2.xx or Speedstore}
			<
		}
		101 {
			>
				emit {Novell Netware 3.xx}
			<
		}
		102 {
			>
				emit {Novell 386 Netware}
			<
		}
		103 {
			>
				emit Novell
			<
		}
		104 {
			>
				emit Novell
			<
		}
		105 {
			>
				emit Novell
			<
		}
		112 {
			>
				emit {DiskSecure Multi-Boot}
			<
		}
		113 {
			>
				emit reserved
			<
		}
		115 {
			>
				emit reserved
			<
		}
		116 {
			>
				emit reserved
			<
		}
		117 {
			>
				emit PC/IX
			<
		}
		118 {
			>
				emit reserved
			<
		}
		119 {
			>
				emit {M2FS/M2CS partition}
			<
		}
		120 {
			>
				emit {XOSL boot loader filesystem}
			<
		}
		128 {
			>
				emit {MINIX until 1.4a}
			<
		}
		129 {
			>
				emit {MINIX since 1.4b}
			<
		}
		130 {
			>
				emit {Linux swap or Solaris}
			<
		}
		131 {
			>
				emit {Linux native}
			<
		}
		132 {
			>
				emit {OS/2 hidden C: drive}
			<
		}
		133 {
			>
				emit {Linux extended partition}
			<
		}
		134 {
			>
				emit {NT FAT volume set}
			<
		}
		135 {
			>
				emit {NTFS volume set or HPFS mirrored}
			<
		}
		138 {
			>
				emit {Linux Kernel AiR-BOOT partition}
			<
		}
		139 {
			>
				emit {Legacy Fault tolerant FAT32}
			<
		}
		140 {
			>
				emit {Legacy Fault tolerant FAT32 ext}
			<
		}
		141 {
			>
				emit {Hidden free FDISK FAT12}
			<
		}
		142 {
			>
				emit {Linux Logical Volume Manager}
			<
		}
		144 {
			>
				emit {Hidden free FDISK FAT16}
			<
		}
		145 {
			>
				emit {Hidden free FDISK DOS EXT}
			<
		}
		146 {
			>
				emit {Hidden free FDISK FAT16 Big}
			<
		}
		147 {
			>
				emit {Amoeba filesystem}
			<
		}
		148 {
			>
				emit {Amoeba bad block table}
			<
		}
		149 {
			>
				emit {MIT EXOPC native partitions}
			<
		}
		151 {
			>
				emit {Hidden free FDISK FAT32}
			<
		}
		152 {
			>
				emit {Datalight ROM-DOS Super-Boot}
			<
		}
		153 {
			>
				emit {Mylex EISA SCSI}
			<
		}
		154 {
			>
				emit {Hidden free FDISK FAT16 LBA}
			<
		}
		155 {
			>
				emit {Hidden free FDISK EXT LBA}
			<
		}
		159 {
			>
				emit BSDI?
			<
		}
		160 {
			>
				emit {IBM Thinkpad hibernation}
			<
		}
		161 {
			>
				emit {HP Volume expansion (SpeedStor)}
			<
		}
		163 {
			>
				emit {HP Volume expansion (SpeedStor)}
			<
		}
		164 {
			>
				emit {HP Volume expansion (SpeedStor)}
			<
		}
		165 {
			>
				emit {386BSD partition type}
			<
		}
		166 {
			>
				emit {OpenBSD partition type}
			<
		}
		167 {
			>
				emit {NeXTSTEP 486}
			<
		}
		168 {
			>
				emit {Apple UFS}
			<
		}
		169 {
			>
				emit {NetBSD partition type}
			<
		}
		170 {
			>
				emit {Olivetty Fat12 1.44MB Service part}
			<
		}
		171 {
			>
				emit {Apple Boot}
			<
		}
		174 {
			>
				emit {SHAG OS filesystem}
			<
		}
		175 {
			>
				emit {Apple HFS}
			<
		}
		176 {
			>
				emit {BootStar Dummy}
			<
		}
		177 {
			>
				emit reserved
			<
		}
		179 {
			>
				emit reserved
			<
		}
		180 {
			>
				emit reserved
			<
		}
		182 {
			>
				emit reserved
			<
		}
		183 {
			>
				emit {BSDI BSD/386 filesystem}
			<
		}
		184 {
			>
				emit {BSDI BSD/386 swap}
			<
		}
		187 {
			>
				emit {Boot Wizard Hidden}
			<
		}
		190 {
			>
				emit {Solaris 8 partition type}
			<
		}
		191 {
			>
				emit {Solaris partition type}
			<
		}
		192 {
			>
				emit CTOS
			<
		}
		193 {
			>
				emit {DRDOS/sec (FAT-12)}
			<
		}
		194 {
			>
				emit {Hidden Linux}
			<
		}
		195 {
			>
				emit {Hidden Linux swap}
			<
		}
		196 {
			>
				emit {DRDOS/sec (FAT-16, < 32M)}
			<
		}
		197 {
			>
				emit {DRDOS/sec (EXT)}
			<
		}
		198 {
			>
				emit {DRDOS/sec (FAT-16, >= 32M)}
			<
		}
		199 {
			>
				emit {Syrinx (Cyrnix?) or HPFS disabled}
			<
		}
		200 {
			>
				emit {Reserved for DR-DOS 8.0+}
			<
		}
		201 {
			>
				emit {Reserved for DR-DOS 8.0+}
			<
		}
		202 {
			>
				emit {Reserved for DR-DOS 8.0+}
			<
		}
		203 {
			>
				emit {DR-DOS 7.04+ Secured FAT32 CHS}
			<
		}
		204 {
			>
				emit {DR-DOS 7.04+ Secured FAT32 LBA}
			<
		}
		205 {
			>
				emit {CTOS Memdump}
			<
		}
		206 {
			>
				emit {DR-DOS 7.04+ FAT16X LBA}
			<
		}
		207 {
			>
				emit {DR-DOS 7.04+ EXT LBA}
			<
		}
		208 {
			>
				emit {REAL/32 secure big partition}
			<
		}
		209 {
			>
				emit {Old Multiuser DOS FAT12}
			<
		}
		212 {
			>
				emit {Old Multiuser DOS FAT16 Small}
			<
		}
		213 {
			>
				emit {Old Multiuser DOS Extended}
			<
		}
		214 {
			>
				emit {Old Multiuser DOS FAT16 Big}
			<
		}
		216 {
			>
				emit {CP/M 86}
			<
		}
		219 {
			>
				emit {CP/M or Concurrent CP/M}
			<
		}
		221 {
			>
				emit {Hidden CTOS Memdump}
			<
		}
		222 {
			>
				emit {Dell PowerEdge Server utilities}
			<
		}
		223 {
			>
				emit {DG/UX virtual disk manager}
			<
		}
		224 {
			>
				emit {STMicroelectronics ST AVFS}
			<
		}
		225 {
			>
				emit {DOS access or SpeedStor 12-bit}
			<
		}
		227 {
			>
				emit {DOS R/O or Storage Dimensions}
			<
		}
		228 {
			>
				emit {SpeedStor 16-bit FAT < 1024 cyl.}
			<
		}
		229 {
			>
				emit reserved
			<
		}
		230 {
			>
				emit reserved
			<
		}
		235 {
			>
				emit BeOS
			<
		}
		238 {
			>
				emit {GPT Protective MBR}
			<
		}
		239 {
			>
				emit {EFI system partition}
			<
		}
		240 {
			>
				emit {Linux PA-RISC boot loader}
			<
		}
		241 {
			>
				emit {SpeedStor or Storage Dimensions}
			<
		}
		242 {
			>
				emit {DOS 3.3+ Secondary}
			<
		}
		243 {
			>
				emit reserved
			<
		}
		244 {
			>
				emit {SpeedStor large partition}
			<
		}
		245 {
			>
				emit {Prologue multi-volumen partition}
			<
		}
		246 {
			>
				emit reserved
			<
		}
		249 {
			>
				emit {pCache: ext2/ext3 persistent cache}
			<
		}
		250 {
			>
				emit {Bochs x86 emulator}
			<
		}
		251 {
			>
				emit {VMware File System}
			<
		}
		252 {
			>
				emit {VMware Swap}
			<
		}
		253 {
			>
				emit {Linux RAID partition persistent sb}
			<
		}
		254 {
			>
				emit {LANstep or IBM PS/2 IML}
			<
		}
		255 {
			>
				emit {Xenix Bad Block Table}
			<
		}
	}
	} DOS-filename {if {[N ubyte [O 0] 0 0 & 223 > 0]} {
		>
			if {[N ubyte [O 0] 0 0 {} {} x {}]} {
				>
					emit {\b%c}
					if {[N ubyte [O 1] 0 0 & 223 > 0]} {
						>
							if {[N ubyte [O 1] 0 0 {} {} x {}]} {
								>
									emit {\b%c}
									if {[N ubyte [O 2] 0 0 & 223 > 0]} {
										>
											if {[N ubyte [O 2] 0 0 {} {} x {}]} {
												>
													emit {\b%c}
													if {[N ubyte [O 3] 0 0 & 223 > 0]} {
														>
															if {[N ubyte [O 3] 0 0 {} {} x {}]} {
																>
																	emit {\b%c}
																	if {[N ubyte [O 4] 0 0 & 223 > 0]} {
																		>
																			if {[N ubyte [O 4] 0 0 {} {} x {}]} {
																				>
																					emit {\b%c}
																					if {[N ubyte [O 5] 0 0 & 223 > 0]} {
																						>
																							if {[N ubyte [O 5] 0 0 {} {} x {}]} {
																								>
																									emit {\b%c}
																									if {[N ubyte [O 6] 0 0 & 223 > 0]} {
																										>
																											if {[N ubyte [O 6] 0 0 {} {} x {}]} {
																												>
																													emit {\b%c}
																													if {[N ubyte [O 7] 0 0 & 223 > 0]} {
																														>
																															if {[N ubyte [O 7] 0 0 {} {} x {}]} {
																																>
																																	emit {\b%c}
																																<
																															}
	
																														<
																													}
	
																												<
																											}
	
																										<
																									}
	
																								<
																							}
	
																						<
																					}
	
																				<
																			}
	
																		<
																	}
	
																<
															}
	
														<
													}
	
												<
											}
	
										<
									}
	
								<
							}
	
						<
					}
	
				<
			}
	
			if {[N ubyte [O 8] 0 0 & 223 > 0]} {
				>
					emit {\b.}
					if {[N ubyte [O 8] 0 0 {} {} x {}]} {
						>
							emit {\b%c}
							if {[N ubyte [O 9] 0 0 & 223 > 0]} {
								>
									if {[N ubyte [O 9] 0 0 {} {} x {}]} {
										>
											emit {\b%c}
											if {[N ubyte [O 10] 0 0 & 223 > 0]} {
												>
													if {[N ubyte [O 10] 0 0 {} {} x {}]} {
														>
															emit {\b%c}
														<
													}
	
												<
											}
	
										<
									}
	
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	} 2xDOS-filename {if {[N ubyte [O 0] 0 0 {} {} x {}]} {
		>
			emit {\b}
		<
	}
	
	U 79 DOS-filename [O 0]
	
	if {[N ubyte [O 11] 0 0 {} {} x {}]} {
		>
			emit {\b+}
		<
	}
	
	U 79 DOS-filename [O 11]
	} partition-table {U 79 partition-entry-test [O 0]
	
	U 79 partition-entry-test [O 16]
	
	U 79 partition-entry-test [O 32]
	
	U 79 partition-entry-test [O 48]
	} partition-entry-test {if {[N ubyte [O 4] 0 0 {} {} > 0]} {
		>
			if {[N ubyte [O 0] 0 0 {} {} == 0]} {
				>
					U 79 partition-entry [O 0]
	
				<
			}
	
			if {[N ubyte [O 0] 0 0 {} {} > 127]} {
				>
					U 79 partition-entry [O 0]
	
				<
			}
	
		<
	}
	} partition-entry {if {[N ubyte [O 4] 0 0 {} {} > 0]} {
		>
			emit {\b; partition}
			if {[N leshort [O 64] 0 0 {} {} == -21931]} {
				>
					emit 1
				<
			}
	
			if {[N leshort [O 48] 0 0 {} {} == -21931]} {
				>
					emit 2
				<
			}
	
			if {[N leshort [O 32] 0 0 {} {} == -21931]} {
				>
					emit 3
				<
			}
	
			if {[N leshort [O 16] 0 0 {} {} == -21931]} {
				>
					emit 4
				<
			}
	
			if {[N ubyte [O 4] 0 0 {} {} x {}]} {
				>
					emit {: ID=0x%x}
				<
			}
	
			if {[N ubyte [O 0] 0 0 & 128 == 128]} {
				>
					emit {\b, active}
				<
			}
	
			if {[N ubyte [O 0] 0 0 {} {} > 128]} {
				>
					emit 0x%x
				<
			}
	
			if {[N ubyte [O 1] 0 0 {} {} x {}]} {
				>
					emit {\b, start-CHS (}
				<
			}
	
			U 79 partition-chs [O 1]
	
			if {[N ubyte [O 5] 0 0 {} {} x {}]} {
				>
					emit {\b), end-CHS (}
				<
			}
	
			U 79 partition-chs [O 5]
	
			if {[N ulelong [O 8] 0 0 {} {} x {}]} {
				>
					emit {\b), startsector %u}
				<
			}
	
			if {[N ulelong [O 12] 0 0 {} {} x {}]} {
				>
					emit {\b, %u sectors}
				<
			}
	
		<
	}
	} partition-chs {if {[N ubyte [O 1] 0 0 {} {} x {}]} {
		>
			emit {\b0x}
		<
	}
	
	switch [Nv ubyte [O 1] 0 & 192] {
		64 {
			>
				emit {\b1}
			<
		}
		128 {
			>
				emit {\b2}
			<
		}
		192 {
			>
				emit {\b3}
			<
		}
	}
	
	if {[N ubyte [O 2] 0 0 {} {} x {}]} {
		>
			emit {\b%x}
		<
	}
	
	if {[N ubyte [O 0] 0 0 {} {} x {}]} {
		>
			emit {\b,%u}
		<
	}
	
	if {[N ubyte [O 1] 0 0 & 63 x {}]} {
		>
			emit {\b,%u}
		<
	}
	} cdrom {if {[S string [O 38913] 0 {} {} ne NSR0]} {
		>
			emit {ISO 9660 CD-ROM filesystem data}
			mime application/x-iso9660-image
			ext iso/iso9660
		<
	}
	
	if {[S string [O 38913] 0 {} {} eq NSR0]} {
		>
			emit {UDF filesystem data}
			if {[S string [O 38917] 0 {} {} eq 1]} {
				>
					emit {(version 1.0)}
				<
			}
	
			if {[S string [O 38917] 0 {} {} eq 2]} {
				>
					emit {(version 1.5)}
				<
			}
	
			if {[S string [O 38917] 0 {} {} eq 3]} {
				>
					emit {(version 2.0)}
				<
			}
	
			if {[N byte [O 38917] 0 0 {} {} > 51]} {
				>
					emit {(unknown version, ID 0x%X)}
				<
			}
	
			if {[N byte [O 38917] 0 0 {} {} < 49]} {
				>
					emit {(unknown version, ID 0x%X)}
				<
			}
	
			mime application/x-iso9660-image
			ext iso/udf
		<
	}
	
	if {[N leshort [O 510] 0 0 {} {} == -21931]} {
		>
			emit {(DOS/MBR boot sector)}
		<
	}
	
	if {[S string [O 32808] 0 T {} > \0]} {
		>
			emit '%s'
		<
	}
	
	if {[S string [O 34816] 0 {} {} eq \000CD001\001EL\ TORITO\ SPECIFICATION]} {
		>
			emit (bootable)
		<
	}
	}}
	81
		{swf-details {if {[S string [O 0] 0 {} {} eq F]} {
		>
			if {[N byte [O 8] 0 0 & -3 == 8]} {
				>
					emit {Macromedia Flash data}
					if {[N byte [O 3] 0 0 {} {} x {}]} {
						>
							emit {\b, version %d}
						<
					}
	
					mime application/x-shockwave-flash
				<
			}
	
			if {[N byte [O 8] 0 0 & -2 == 16]} {
				>
					emit {Macromedia Flash data}
					if {[N byte [O 3] 0 0 {} {} x {}]} {
						>
							emit {\b, version %d}
						<
					}
	
					mime application/x-shockwave-flash
				<
			}
	
			if {[N byte [O 8] 0 0 {} {} == 24]} {
				>
					emit {Macromedia Flash data}
					if {[N byte [O 3] 0 0 {} {} x {}]} {
						>
							emit {\b, version %d}
						<
					}
	
					mime application/x-shockwave-flash
				<
			}
	
			if {[N beshort [O 8] 0 0 & -121 == 8192]} {
				>
					emit {Macromedia Flash data}
					if {[N byte [O 3] 0 0 {} {} x {}]} {
						>
							emit {\b, version %d}
						<
					}
	
					mime application/x-shockwave-flash
				<
			}
	
			if {[N beshort [O 8] 0 0 & -32 == 12288]} {
				>
					emit {Macromedia Flash data}
					if {[N byte [O 3] 0 0 {} {} x {}]} {
						>
							emit {\b, version %d}
						<
					}
	
					mime application/x-shockwave-flash
				<
			}
	
			if {[N byte [O 8] 0 0 & 7 == 0]} {
				>
					if {[N ubyte [O 8] 0 0 {} {} > 47]} {
						>
							if {[N ubyte [O 9] 0 0 {} {} < 32]} {
								>
									emit {Macromedia Flash data}
									if {[N byte [O 3] 0 0 {} {} x {}]} {
										>
											emit {\b, version %d}
										<
									}
	
									mime application/x-shockwave-flash
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq C]} {
		>
			if {[N byte [O 8] 0 0 {} {} == 120]} {
				>
					emit {Macromedia Flash data (compressed)}
					if {[N byte [O 3] 0 0 {} {} x {}]} {
						>
							emit {\b, version %d}
						<
					}
	
					mime application/x-shockwave-flash
				<
			}
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq Z]} {
		>
			if {[N byte [O 8] 0 0 {} {} == 93]} {
				>
					emit {Macromedia Flash data (lzma compressed)}
					if {[N byte [O 3] 0 0 {} {} x {}]} {
						>
							emit {\b, version %d}
						<
					}
	
					mime application/x-shockwave-flash
				<
			}
	
		<
	}
	}}
	83
		{sfnt-font {if {[N ubeshort [O 4] 0 0 {} {} < 47]} {
		>
			if {[S regex [O 12] 0 l 4 eq ^\[A-Za-z\]\[A-Za-z\]\[A-Za-z/\]\[A-Za-z2\ \]]} {
				>
					if {[N ubelong [O 0] 0 0 {} {} != 1330926671]} {
						>
							emit TrueType
							mime application/font-sfnt
							ext ttf/tte
						<
					}
	
					if {[N ubelong [O 0] 0 0 {} {} == 1330926671]} {
						>
							emit OpenType
							mime application/font-sfnt
							ext otf
						<
					}
	
					if {[N ubelong [O 0] 0 0 {} {} x {}]} {
						>
							emit {Font data}
						<
					}
	
					if {[S search [O 12] 0 {} 432 eq DSIG]} {
						>
							emit {\b, digitally signed}
						<
					}
	
					if {[N ubeshort [O 4] 0 0 {} {} x {}]} {
						>
							emit {\b, %d tables}
						<
					}
	
					if {[S string [O 12] 0 {} {} x {}]} {
						>
							emit {\b, 1st "%4.4s"}
						<
					}
	
				<
			}
	
		<
	}
	} sfnt-names {if {[S search [O 12] 0 {} 432 eq s]} {
		>
			emit {name		}
			if {[N ubelong [R [O 8]] 0 0 {} {} > 1048576]} {
				>
					if {[N ubelong [R [O -4]] 0 0 {} {} x {}]} {
						>
							emit {\b, name offset 0x%x}
						<
					}
	
				<
			}
	
			if {[N ubelong [R [O 8]] 0 0 {} {} < 1048576]} {
				>
					if {[N ubelong [R [O -16]] 0 0 {} {} x {}]} {
						>
							if {[N ubequad [O [I [R 8] ubelong 0 + 0 0]] 0 0 {} {} x {}]} {
								>
									if {[N ubeshort [R [O -6]] 0 0 {} {} x {}]} {
										>
											emit {\b, %d names}
										<
									}
	
									switch [Nv ubeshort [R [O -2]] 0 {} {}] {
										0 {
											>
												emit {\b, Unicode}
											<
										}
										1 {
											>
												emit {\b, Macintosh}
											<
										}
										3 {
											>
												emit {\b, Microsoft}
											<
										}
									}
	
									if {[N ubeshort [R [O 2]] 0 0 {} {} > 0]} {
										>
											emit {\b, language 0x%x}
										<
									}
	
									if {[N ubeshort [R [O 4]] 0 0 {} {} > 0]} {
										>
											emit {\b, type %d string}
										<
									}
	
									if {[N ubeshort [R [O 0]] 0 0 {} {} == 0]} {
										>
											if {[N ubeshort [R [O 6]] 0 0 {} {} == 0]} {
												>
													if {[N ubyte [R [O [I [R -14] ubeshort 0 - 0 18]]] 0 0 {} {} != 0]} {
														>
															if {[S string [R [O -1]] 0 {} {} x {}]} {
																>
																	emit {\b, %-11.96s}
																<
															}
	
														<
													}
	
													if {[N ubyte [R [O [I [R -14] ubeshort 0 - 0 18]]] 0 0 {} {} == 0]} {
														>
															if {[S lestring16 [R [O 0]] 0 {} {} x {}]} {
																>
																	emit {\b, %-11.96s}
																<
															}
	
														<
													}
	
												<
											}
	
										<
									}
	
									if {[N ubeshort [R [O 0]] 0 0 {} {} > 0]} {
										>
											if {[N ubeshort [R [O 6]] 0 0 {} {} == 0]} {
												>
													if {[S lestring16 [R [O [I [R -14] ubeshort 0 - 0 17]]] 0 {} {} x {}]} {
														>
															emit {\b, %-11.96s}
														<
													}
	
												<
											}
	
										<
									}
	
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	} woff {switch [Nv belong [O 4] 0 {} {}] {
		65536 {
			>
				emit {\b, TrueType}
			<
		}
		1330926671 {
			>
				emit {\b, CFF}
			<
		}
		1953658213 {
			>
				emit {\b, TrueType}
			<
		}
	}
	
	if {[D [O 4]]} {
		>
			if {[N belong [O 4] 0 0 {} {} x {}]} {
				>
					emit {\b, flavor %d}
				<
			}
	
		<
	}
	
	if {[N belong [O 8] 0 0 {} {} x {}]} {
		>
			emit {\b, length %d}
		<
	}
	}}
	89
		{pak-entry {if {[N ulelong [O 56] 0 0 {} {} > 11]} {
		>
			if {[N ulelong [O 56] 0 0 {} {} x {}]} {
				>
					emit {at 0x%x}
				<
			}
	
			if {[N ulelong [O 60] 0 0 {} {} x {}]} {
				>
					emit {%u bytes}
				<
			}
	
			if {[S string [O 0] 0 {} {} x {}]} {
				>
					emit '%-.56s'
				<
			}
	
			emit {\b: }
			T [O [I 56 long 0 + 0 0]] {}
	
		<
	}
	}}
	98
		{gpt-mbr-type {if {[N ubyte [O 450] 0 0 {} {} == 238]} {
		>
			if {[N ulelong [O 454] 0 0 {} {} == 1]} {
				>
					if {[S string [O 462] 0 {} {} ne \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0]} {
						>
							emit {\b (with hybrid MBR)}
						<
					}
	
				<
			}
	
			if {[N ulelong [O 454] 0 0 {} {} != 1]} {
				>
					emit {\b (nonstandard: not at LBA 1)}
				<
			}
	
		<
	}
	
	if {[N ubyte [O 466] 0 0 {} {} == 238]} {
		>
			if {[N ulelong [O 470] 0 0 {} {} == 1]} {
				>
					if {[S string [O 478] 0 {} {} eq \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0]} {
						>
							if {[S string [O 446] 0 {} {} ne \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0]} {
								>
									emit {\b (with hybrid MBR)}
								<
							}
	
						<
					}
	
					if {[S string [O 478] 0 {} {} ne \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0]} {
						>
							emit {\b (with hybrid MBR)}
						<
					}
	
				<
			}
	
			if {[N ulelong [O 470] 0 0 {} {} != 1]} {
				>
					emit {\b (nonstandard: not at LBA 1)}
				<
			}
	
		<
	}
	
	if {[N ubyte [O 482] 0 0 {} {} == 238]} {
		>
			if {[N ulelong [O 486] 0 0 {} {} == 1]} {
				>
					if {[S string [O 494] 0 {} {} eq \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0]} {
						>
							if {[S string [O 446] 0 {} {} ne \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0]} {
								>
									emit {\b (with hybrid MBR)}
								<
							}
	
						<
					}
	
					if {[S string [O 494] 0 {} {} ne \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0]} {
						>
							emit {\b (with hybrid MBR)}
						<
					}
	
				<
			}
	
			if {[N ulelong [O 486] 0 0 {} {} != 1]} {
				>
					emit {\b (nonstandard: not at LBA 1)}
				<
			}
	
		<
	}
	
	if {[N ubyte [O 498] 0 0 {} {} == 238]} {
		>
			if {[N ulelong [O 502] 0 0 {} {} == 1]} {
				>
					if {[S string [O 446] 0 {} {} ne \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0]} {
						>
							emit {\b (with hybrid MBR)}
						<
					}
	
				<
			}
	
			if {[N ulelong [O 502] 0 0 {} {} != 1]} {
				>
					emit {\b (nonstandard: not at LBA 1)}
				<
			}
	
		<
	}
	} gpt-table {if {[N uleshort [O 10] 0 0 {} {} x {}]} {
		>
			emit {\b, version %u}
		<
	}
	
	if {[N uleshort [O 8] 0 0 {} {} x {}]} {
		>
			emit {\b.%u}
		<
	}
	
	if {[N ulelong [O 56] 0 0 {} {} x {}]} {
		>
			emit {\b, GUID: %08x}
		<
	}
	
	if {[N uleshort [O 60] 0 0 {} {} x {}]} {
		>
			emit {\b-%04x}
		<
	}
	
	if {[N uleshort [O 62] 0 0 {} {} x {}]} {
		>
			emit {\b-%04x}
		<
	}
	
	if {[N ubeshort [O 64] 0 0 {} {} x {}]} {
		>
			emit {\b-%04x}
		<
	}
	
	if {[N ubeshort [O 66] 0 0 {} {} x {}]} {
		>
			emit {\b-%04x}
		<
	}
	
	if {[N ubelong [O 68] 0 0 {} {} x {}]} {
		>
			emit {\b%08x}
		<
	}
	
	if {[N ulequad [O 32] 0 0 + 1 x {}]} {
		>
			emit {\b, disk size: %lld sectors}
		<
	}
	}}
	109
		{color-profile {if {[S string [O 36] 0 {} {} eq acsp]} {
		>
			if {[N ubeshort [O 26] 0 0 {} {} < 13]} {
				>
					if {[S string [O 40] 0 {} {} eq APPL]} {
						>
							emit ColorSync
						<
					}
	
					if {[S string [O 40] 0 {} {} eq MSFT]} {
						>
							emit Microsoft
						<
					}
	
					if {[S string [O 40] 0 {} {} eq SGI\ ]} {
						>
							emit SGI
						<
					}
	
					if {[S string [O 40] 0 {} {} eq SUNW]} {
						>
							emit {Sun KCMS}
						<
					}
	
					if {[S string [O 40] 0 {} {} eq TGNT]} {
						>
							emit Taligent
						<
					}
	
					if {[S string [O 40] 0 {} {} x {}]} {
						>
							emit {color profi}
							mime application/vnd.iccprofile
						<
					}
	
					if {[N ubyte [O 8] 0 0 {} {} == 2]} {
						>
							if {[N ubyte [O 9] 0 0 {} {} != 0]} {
								>
									emit {\ble}
									ext icc/icm
								<
							}
	
							if {[N ubyte [O 9] 0 0 {} {} == 0]} {
								>
									emit {\bl}
									if {[S string [O 4] 0 {} {} eq KCMS]} {
										>
											emit {\be}
											ext icc/icm/cc
										<
									}
	
									if {[S string [O 4] 0 {} {} ne KCMS]} {
										>
											emit {\be}
											ext icc/icm
										<
									}
	
								<
							}
	
						<
					}
	
					if {[N ubyte [O 8] 0 0 {} {} != 2]} {
						>
							emit {\ble}
							ext icc
						<
					}
	
					if {[N ubyte [O 8] 0 0 {} {} x {}]} {
						>
							emit %u
						<
					}
	
					if {[N ubyte [O 9] 0 0 / 16 x {}]} {
						>
							emit {\b.%u}
						<
					}
	
					if {[N ubyte [O 10] 0 0 {} {} > 0]} {
						>
							emit {\b.%u}
							if {[N ubyte [O 11] 0 0 {} {} > 0]} {
								>
									emit {\b.%u}
								<
							}
	
						<
					}
	
					if {[S string [O 4] 0 {} {} > \ ]} {
						>
							emit {\b, type %.2s}
							if {[S string [O 6] 0 {} {} > \ ]} {
								>
									emit {\b%.1s}
									if {[S string [O 7] 0 {} {} > \ ]} {
										>
											emit {\b%.1s}
										<
									}
	
								<
							}
	
						<
					}
	
					if {[S string [O 16] 0 {} {} x {}]} {
						>
							emit {\b, %.3s}
						<
					}
	
					if {[S string [O 19] 0 {} {} > \ ]} {
						>
							emit {\b%.1s}
						<
					}
	
					if {[S string [O 20] 0 {} {} > \0]} {
						>
							emit {\b/%.3s}
							if {[S string [O 23] 0 {} {} > \ ]} {
								>
									emit {\b%.1s}
								<
							}
	
						<
					}
	
					if {[S string [O 12] 0 {} {} x {}]} {
						>
							emit {\b-%.4s device}
						<
					}
	
					if {[S string [O 52] 0 {} {} > \040]} {
						>
							if {[N ubelong [O 52] 0 0 {} {} != 1852796517]} {
								>
									if {[S string [O 48] 0 {} {} x {}]} {
										>
											emit {\b, %.2s}
										<
									}
	
									if {[S string [O 50] 0 {} {} > \ ]} {
										>
											emit {\b%.1s}
										<
									}
	
									if {[S string [O 51] 0 {} {} > \ ]} {
										>
											emit {\b%.1s}
										<
									}
	
									if {[S string [O 52] 0 {} {} > \ \ ]} {
										>
											emit {\b/%.3s}
											if {[S string [O 55] 0 {} {} > \ ]} {
												>
													emit {\b%.1s}
												<
											}
	
										<
									}
	
									if {[S string [O 52] 0 {} {} x {}]} {
										>
											emit model
										<
									}
	
								<
							}
	
						<
					}
	
					if {[S string [O 80] 0 {} {} > \0]} {
						>
							emit {by %.2s}
							if {[S string [O 82] 0 {} {} > \ ]} {
								>
									emit {\b%.1s}
									if {[S string [O 83] 0 {} {} > \ ]} {
										>
											emit {\b%.1s}
										<
									}
	
								<
							}
	
						<
					}
	
					if {[N ubelong [O 0] 0 0 {} {} x {}]} {
						>
							emit {\b, %u bytes}
						<
					}
	
					if {[N ubequad [O 24] 0 0 {} {} != 0]} {
						>
							if {[N ubeshort [O 28] 0 0 {} {} x {}]} {
								>
									emit {\b, %u}
								<
							}
	
							if {[N ubeshort [O 26] 0 0 {} {} x {}]} {
								>
									emit {\b-%u}
								<
							}
	
							if {[N ubeshort [O 24] 0 0 {} {} x {}]} {
								>
									emit {\b-%u}
								<
							}
	
							if {[N ubequad [O 30] 0 0 & 18446744073709486080 != 0]} {
								>
									if {[N ubeshort [O 30] 0 0 {} {} x {}]} {
										>
											emit %u
										<
									}
	
									if {[N ubeshort [O 32] 0 0 {} {} x {}]} {
										>
											emit {\b:%.2u}
										<
									}
	
									if {[N ubeshort [O 34] 0 0 {} {} x {}]} {
										>
											emit {\b:%.2u}
										<
									}
	
								<
							}
	
						<
					}
	
					if {[N ubeshort [O 44] 0 0 {} {} > 0]} {
						>
							emit {\b, 0x%x vendor flags}
						<
					}
	
					if {[N ubelong [O 44] 0 0 {} {} & 1]} {
						>
							emit {\b, embedded}
						<
					}
	
					if {[N ubelong [O 44] 0 0 {} {} & 2]} {
						>
							emit {\b, dependently}
						<
					}
	
					if {[N ubelong [O 44] 0 0 {} {} & 4]} {
						>
							emit {\b, MCS}
						<
					}
	
					if {[N ubelong [O 56] 0 0 {} {} > 0]} {
						>
							emit {\b, 0x%x vendor attribute}
						<
					}
	
					if {[N ubelong [O 60] 0 0 {} {} & 1]} {
						>
							emit {\b, transparent}
						<
					}
	
					if {[N ubelong [O 60] 0 0 {} {} & 2]} {
						>
							emit {\b, matte}
						<
					}
	
					if {[N ubelong [O 60] 0 0 {} {} & 4]} {
						>
							emit {\b, negative}
						<
					}
	
					if {[N ubelong [O 60] 0 0 {} {} & 8]} {
						>
							emit {\b, black&white}
						<
					}
	
					if {[N ubelong [O 60] 0 0 {} {} & 16]} {
						>
							emit {\b, non-paper}
						<
					}
	
					if {[N ubelong [O 60] 0 0 {} {} & 32]} {
						>
							emit {\b, non-textured}
						<
					}
	
					if {[N ubelong [O 60] 0 0 {} {} & 64]} {
						>
							emit {\b, non-isotropic}
						<
					}
	
					if {[N ubelong [O 60] 0 0 {} {} & 128]} {
						>
							emit {\b, self-luminous}
						<
					}
	
					if {[N ubelong [O 64] 0 0 {} {} > 3]} {
						>
							emit {\b, 0x%x rendering intent}
						<
					}
	
					switch [Nv ubelong [O 64] 0 {} {}] {
						1 {
							>
								emit {\b, relative colorimetric}
							<
						}
						2 {
							>
								emit {\b, saturation}
							<
						}
						3 {
							>
								emit {\b, absolute colorimetric}
							<
						}
					}
	
					if {[N ubequad [O 71] 0 0 {} {} != 15420326223628206291]} {
						>
							emit {\b, PCS}
							if {[N ubelong [O 68] 0 0 {} {} != 63189]} {
								>
									emit X=0x%x
								<
							}
	
							if {[N ubelong [O 72] 0 0 {} {} != 65536]} {
								>
									emit Y=0x%x
								<
							}
	
							if {[N ubelong [O 76] 0 0 {} {} != 54061]} {
								>
									emit Z=0x%x
								<
							}
	
						<
					}
	
					if {[N ubequad [O 84] 0 0 {} {} > 0]} {
						>
							emit {\b, 0x%llx MD5}
						<
					}
	
					if {[N ubelong [O 128] 0 0 {} {} x {}]} {
						>
							if {[S search [O 132] 0 {} 508 eq cprt]} {
								>
								<
							}
	
							if {[D [O 132]]} {
								>
									emit {\b, no copyright tag}
								<
							}
	
						<
					}
	
					if {[S search [O 132] 0 {} 508 eq desc]} {
						>
							if {[S string [O [I [R 0] ubelong 0 + 0 0]] 0 {} {} eq desc]} {
								>
									if {[S pstring [R [O 4]] 0 l {} x {}]} {
										>
											emit {"%s"}
										<
									}
	
								<
							}
	
							if {[S string [O [I [R 0] ubelong 0 + 0 0]] 0 {} {} eq mluc]} {
								>
									if {[N ubequad [R [O [I [R 8] ubelong 0 + 0 0]]] 0 0 {} {} x {}]} {
										>
											if {[S bestring16 [R [O 4]] 0 {} {} x {}]} {
												>
													emit '%s'
												<
											}
	
										<
									}
	
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	}}
	111
		{tga-image {if {[N ubyte [O 2] 0 0 {} {} < 34]} {
		>
			emit {Targa image data}
			mime image/x-tga
			ext tga/tpic/icb/vda/vst
		<
	}
	
	switch [Nv ubyte [O 2] 0 & 247] {
		1 {
			>
				emit {- Map}
			<
		}
		2 {
			>
				emit {- RGB}
				if {[N ubyte [O 17] 0 0 & 15 > 0]} {
					>
						emit {\bA}
					<
				}
	
			<
		}
		3 {
			>
				emit {- Mono}
			<
		}
	}
	
	switch [Nv ubyte [O 2] 0 {} {}] {
		32 {
			>
				emit {- Color}
			<
		}
		33 {
			>
				emit {- Color}
			<
		}
	}
	
	if {[N ubyte [O 1] 0 0 {} {} == 1]} {
		>
			emit (
			if {[N uleshort [O 3] 0 0 {} {} > 0]} {
				>
					emit {\b%d-}
				<
			}
	
			if {[N uleshort [O 5] 0 0 {} {} x {}]} {
				>
					emit {\b%d)}
				<
			}
	
		<
	}
	
	if {[N ubyte [O 2] 0 0 & 8 == 8]} {
		>
			emit {- RLE}
		<
	}
	
	if {[N uleshort [O 12] 0 0 {} {} > 0]} {
		>
			emit {%d x}
		<
	}
	
	if {[N uleshort [O 12] 0 0 {} {} == 0]} {
		>
			emit {65536 x}
		<
	}
	
	if {[N uleshort [O 14] 0 0 {} {} > 0]} {
		>
			emit %d
		<
	}
	
	if {[N uleshort [O 14] 0 0 {} {} == 0]} {
		>
			emit 65536
		<
	}
	
	if {[N ubyte [O 16] 0 0 {} {} x {}]} {
		>
			emit {x %d}
		<
	}
	
	if {[N uleshort [O 8] 0 0 {} {} > 0]} {
		>
			emit +%d
		<
	}
	
	if {[N uleshort [O 10] 0 0 {} {} > 0]} {
		>
			emit +%d
		<
	}
	
	if {[N ubyte [O 17] 0 0 & 15 > 0]} {
		>
			emit {- %d-bit alpha}
		<
	}
	
	if {[N ubyte [O 17] 0 0 {} {} & 32]} {
		>
			emit {- top}
		<
	}
	
	if {[N ubyte [O 17] 0 0 {} {} & 16]} {
		>
			emit {- right}
		<
	}
	
	switch [Nv ubyte [O 17] 0 & 192] {
		64 {
			>
				emit {- interleave}
			<
		}
		128 {
			>
				emit {- four way interleave}
			<
		}
		192 {
			>
				emit {- reserved}
			<
		}
	}
	
	if {[N ubyte [O 0] 0 0 {} {} > 0]} {
		>
			if {[S string [O 18] 0 {} {} x {}]} {
				>
					emit {"%s"}
				<
			}
	
		<
	}
	
	if {[S search [O 18] 0 {} 4261301 eq s]} {
		>
			emit {TRUEVISION-XFILE.\0}
			if {[N ulelong [R [O -8]] 0 0 {} {} > 0]} {
				>
					if {[N uleshort [O [I [R -4] ulelong 0 + 0 0]] 0 0 {} {} == 495]} {
						>
							if {[S string [R [O 0]] 0 {} {} > \0]} {
								>
									emit {- author "%-.40s"}
								<
							}
	
							if {[S string [R [O 41]] 0 {} {} > \0]} {
								>
									emit {- comment "%-.80s"}
								<
							}
	
							if {[N ubequad [R [O 365]] 0 0 & 18446744073709486080 != 0]} {
								>
									if {[N uleshort [R [O -6]] 0 0 {} {} x {}]} {
										>
											emit %d
										<
									}
	
									if {[N uleshort [R [O -8]] 0 0 {} {} x {}]} {
										>
											emit {\b-%d}
										<
									}
	
									if {[N uleshort [R [O -4]] 0 0 {} {} x {}]} {
										>
											emit {\b-%d}
										<
									}
	
								<
							}
	
							if {[N ubequad [R [O 371]] 0 0 & 18446744073709486080 != 0]} {
								>
									if {[N uleshort [R [O -8]] 0 0 {} {} x {}]} {
										>
											emit %d
										<
									}
	
									if {[N uleshort [R [O -6]] 0 0 {} {} x {}]} {
										>
											emit {\b:%.2d}
										<
									}
	
									if {[N uleshort [R [O -4]] 0 0 {} {} x {}]} {
										>
											emit {\b:%.2d}
										<
									}
	
								<
							}
	
							if {[S string [R [O 377]] 0 {} {} > \0]} {
								>
									emit {- job "%-.40s"}
								<
							}
	
							if {[N ubequad [R [O 418]] 0 0 & 18446744073709486080 != 0]} {
								>
									if {[N uleshort [R [O -8]] 0 0 {} {} x {}]} {
										>
											emit %d
										<
									}
	
									if {[N uleshort [R [O -6]] 0 0 {} {} x {}]} {
										>
											emit {\b:%.2d}
										<
									}
	
									if {[N uleshort [R [O -4]] 0 0 {} {} x {}]} {
										>
											emit {\b:%.2d}
										<
									}
	
								<
							}
	
							if {[S string [R [O 424]] 0 {} {} > \0]} {
								>
									emit {- %-.40s}
								<
							}
	
							if {[N ubyte [R [O 424]] 0 0 {} {} > 0]} {
								>
									if {[N uleshort [R [O 40]] 0 0 / 100 x {}]} {
										>
											emit %d
										<
									}
	
									if {[N uleshort [R [O 40]] 0 0 % 100 x {}]} {
										>
											emit {\b.%d}
										<
									}
	
									if {[N ubyte [R [O 42]] 0 0 {} {} > 32]} {
										>
											emit {\b%c}
										<
									}
	
								<
							}
	
							if {[N ulelong [R [O 468]] 0 0 {} {} > 0]} {
								>
									emit {- keycolor 0x%8.8x}
								<
							}
	
							if {[N uleshort [R [O 474]] 0 0 {} {} > 0]} {
								>
									if {[N uleshort [R [O -4]] 0 0 {} {} > 0]} {
										>
											emit {- aspect %d}
										<
									}
	
									if {[N uleshort [R [O -2]] 0 0 {} {} x {}]} {
										>
											emit {\b/%d}
										<
									}
	
								<
							}
	
							if {[N uleshort [R [O 478]] 0 0 {} {} > 0]} {
								>
									if {[N uleshort [R [O -4]] 0 0 {} {} > 0]} {
										>
											emit {- gamma %d}
										<
									}
	
									if {[N uleshort [R [O -2]] 0 0 {} {} x {}]} {
										>
											emit {\b/%d}
										<
									}
	
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	} netpbm {if {[S regex [O 3] 0 s {} eq \[0-9\]\{1,50\}\ \[0-9\]\{1,50\}]} {
		>
			emit {Netpbm image data}
			if {[S regex [R [O 0]] 0 {} {} eq \[0-9\]\{1,50\}]} {
				>
					emit {\b, size = %s x}
					if {[S regex [R [O 0]] 0 {} {} eq \[0-9\]\{1,50\}]} {
						>
							emit {\b %s}
						<
					}
	
				<
			}
	
		<
	}
	} tiff_ifd {if {[N leshort [O 0] 0 0 {} {} x {}]} {
		>
			emit {\b, direntries=%d}
		<
	}
	
	U 111 tiff_entry [O 2]
	} tiff_entry {switch [Nv leshort [O 0] 0 {} {}] {
		-32104 {
			>
				if {[S string [O [I 8 ulelong 0 + 0 0]] 0 {} {} x {}]} {
					>
						emit {\b, copyright=%s}
					<
				}
	
				U 111 tiff_entry [O 12]
	
			<
		}
		-30871 {
			>
				U 111 tiff_entry [O 12]
	
			<
		}
		-30683 {
			>
				emit {\b, GPS-Data}
				U 111 tiff_entry [O 12]
	
			<
		}
		254 {
			>
				U 111 tiff_entry [O 12]
	
			<
		}
		256 {
			>
				if {[N lelong [O 4] 0 0 {} {} == 1]} {
					>
						U 111 tiff_entry [O 12]
	
						if {[N leshort [O 8] 0 0 {} {} x {}]} {
							>
								emit {\b, width=%d}
							<
						}
	
					<
				}
	
			<
		}
		257 {
			>
				if {[N lelong [O 4] 0 0 {} {} == 1]} {
					>
						if {[N leshort [O 8] 0 0 {} {} x {}]} {
							>
								emit {\b, height=%d}
							<
						}
	
						U 111 tiff_entry [O 12]
	
					<
				}
	
			<
		}
		258 {
			>
				if {[N leshort [O 8] 0 0 {} {} x {}]} {
					>
						emit {\b, bps=%d}
					<
				}
	
				U 111 tiff_entry [O 12]
	
			<
		}
		259 {
			>
				if {[N lelong [O 4] 0 0 {} {} == 1]} {
					>
						emit {\b, compression=}
						switch [Nv leshort [O 8] 0 {} {}] {
							-32763 {
								>
									emit {\bPackBits (Macintosh RLE)}
								<
							}
							-32727 {
								>
									emit {\bThunderscan RLE}
								<
							}
							-32641 {
								>
									emit {\bRasterPadding (CT or MP)}
								<
							}
							-32640 {
								>
									emit {\bRLE (Line Work)}
								<
							}
							-32639 {
								>
									emit {\bRLE (High-Res Cont-Tone)}
								<
							}
							-32638 {
								>
									emit {\bRLE (Binary Line Work)}
								<
							}
							-32590 {
								>
									emit {\bDeflate (PKZIP)}
								<
							}
							-32589 {
								>
									emit {\bKodak DCS}
								<
							}
							-30875 {
								>
									emit {\bJBIG}
								<
							}
							-30824 {
								>
									emit {\bJPEG2000}
								<
							}
							-30823 {
								>
									emit {\bNikon NEF Compressed}
								<
							}
							1 {
								>
									emit {\bnone}
								<
							}
							2 {
								>
									emit {\bhuffman}
								<
							}
							3 {
								>
									emit {\bbi-level group 3}
								<
							}
							4 {
								>
									emit {\bbi-level group 4}
								<
							}
							5 {
								>
									emit {\bLZW}
								<
							}
							6 {
								>
									emit {\bJPEG (old)}
								<
							}
							7 {
								>
									emit {\bJPEG}
								<
							}
							8 {
								>
									emit {\bdeflate}
								<
							}
							9 {
								>
									emit {\bJBIG, ITU-T T.85}
								<
							}
							10 {
								>
									emit {\bJBIG, ITU-T T.43}
								<
							}
							32766 {
								>
									emit {\bNeXT RLE 2-bit}
								<
							}
						}
	
						if {[D [O 8]]} {
							>
								if {[N leshort [O 8] 0 0 {} {} x {}]} {
									>
										emit {\b(unknown 0x%x)}
									<
								}
	
							<
						}
	
						U 111 tiff_entry [O 12]
	
					<
				}
	
			<
		}
		262 {
			>
				emit {\b, PhotometricIntepretation=}
				if {[S clear [O 8] 0 {} {} x {}]} {
					>
					<
				}
	
				switch [Nv leshort [O 8] 0 {} {}] {
					0 {
						>
							emit {\bWhiteIsZero}
						<
					}
					1 {
						>
							emit {\bBlackIsZero}
						<
					}
					2 {
						>
							emit {\bRGB}
						<
					}
					3 {
						>
							emit {\bRGB Palette}
						<
					}
					4 {
						>
							emit {\bTransparency Mask}
						<
					}
					5 {
						>
							emit {\bCMYK}
						<
					}
					6 {
						>
							emit {\bYCbCr}
						<
					}
					8 {
						>
							emit {\bCIELab}
						<
					}
				}
	
				if {[D [O 8]]} {
					>
						if {[N leshort [O 8] 0 0 {} {} x {}]} {
							>
								emit {\b(unknown=0x%x)}
							<
						}
	
					<
				}
	
				U 111 tiff_entry [O 12]
	
			<
		}
		266 {
			>
				if {[N lelong [O 4] 0 0 {} {} == 1]} {
					>
						U 111 tiff_entry [O 12]
	
					<
				}
	
			<
		}
		269 {
			>
				if {[S string [O [I 8 ulelong 0 + 0 0]] 0 {} {} x {}]} {
					>
						emit {\b, name=%s}
						U 111 tiff_entry [O 12]
	
					<
				}
	
			<
		}
		270 {
			>
				if {[S string [O [I 8 ulelong 0 + 0 0]] 0 {} {} x {}]} {
					>
						emit {\b, description=%s}
						U 111 tiff_entry [O 12]
	
					<
				}
	
			<
		}
		271 {
			>
				if {[S string [O [I 8 ulelong 0 + 0 0]] 0 {} {} x {}]} {
					>
						emit {\b, manufacturer=%s}
						U 111 tiff_entry [O 12]
	
					<
				}
	
			<
		}
		272 {
			>
				if {[S string [O [I 8 ulelong 0 + 0 0]] 0 {} {} x {}]} {
					>
						emit {\b, model=%s}
						U 111 tiff_entry [O 12]
	
					<
				}
	
			<
		}
		273 {
			>
				U 111 tiff_entry [O 12]
	
			<
		}
		274 {
			>
				emit {\b, orientation=}
				switch [Nv leshort [O 8] 0 {} {}] {
					1 {
						>
							emit {\bupper-left}
						<
					}
					3 {
						>
							emit {\blower-right}
						<
					}
					6 {
						>
							emit {\bupper-right}
						<
					}
					8 {
						>
							emit {\blower-left}
						<
					}
					9 {
						>
							emit {\bundefined}
						<
					}
				}
	
				if {[D [O 8]]} {
					>
						if {[N leshort [O 8] 0 0 {} {} x {}]} {
							>
								emit {\b[*%d*]}
							<
						}
	
					<
				}
	
				U 111 tiff_entry [O 12]
	
			<
		}
		282 {
			>
				if {[N lelong [O 8] 0 0 {} {} x {}]} {
					>
						emit {\b, xresolution=%d}
					<
				}
	
				U 111 tiff_entry [O 12]
	
			<
		}
		283 {
			>
				if {[N lelong [O 8] 0 0 {} {} x {}]} {
					>
						emit {\b, yresolution=%d}
					<
				}
	
				U 111 tiff_entry [O 12]
	
			<
		}
		296 {
			>
				if {[N leshort [O 8] 0 0 {} {} x {}]} {
					>
						emit {\b, resolutionunit=%d}
					<
				}
	
				U 111 tiff_entry [O 12]
	
			<
		}
		305 {
			>
				if {[S string [O [I 8 ulelong 0 + 0 0]] 0 {} {} x {}]} {
					>
						emit {\b, software=%s}
					<
				}
	
				U 111 tiff_entry [O 12]
	
			<
		}
		306 {
			>
				if {[S string [O [I 8 ulelong 0 + 0 0]] 0 {} {} x {}]} {
					>
						emit {\b, datetime=%s}
					<
				}
	
				U 111 tiff_entry [O 12]
	
			<
		}
		316 {
			>
				if {[S string [O [I 8 ulelong 0 + 0 0]] 0 {} {} x {}]} {
					>
						emit {\b, hostcomputer=%s}
					<
				}
	
				U 111 tiff_entry [O 12]
	
			<
		}
		318 {
			>
				U 111 tiff_entry [O 12]
	
			<
		}
		319 {
			>
				U 111 tiff_entry [O 12]
	
			<
		}
		529 {
			>
				U 111 tiff_entry [O 12]
	
			<
		}
		531 {
			>
				U 111 tiff_entry [O 12]
	
			<
		}
		532 {
			>
				U 111 tiff_entry [O 12]
	
			<
		}
	}
	} png-ihdr {if {[N belong [O 0] 0 0 {} {} x {}]} {
		>
			emit {\b, %d x}
		<
	}
	
	if {[N belong [O 4] 0 0 {} {} x {}]} {
		>
			emit %d,
		<
	}
	
	if {[N byte [O 8] 0 0 {} {} x {}]} {
		>
			emit %d-bit
		<
	}
	
	switch [Nv byte [O 9] 0 {} {}] {
		0 {
			>
				emit grayscale,
			<
		}
		2 {
			>
				emit {\b/color RGB,}
			<
		}
		3 {
			>
				emit colormap,
			<
		}
		4 {
			>
				emit gray+alpha,
			<
		}
		6 {
			>
				emit {\b/color RGBA,}
			<
		}
	}
	
	switch [Nv byte [O 12] 0 {} {}] {
		0 {
			>
				emit non-interlaced
			<
		}
		1 {
			>
				emit interlaced
			<
		}
	}
	} gem_info {if {[N beshort [O 0] 0 0 {} {} < 3]} {
		>
			emit GEM
			if {[N beshort [O 2] 0 0 {} {} > 9]} {
				>
					if {[S string [O 16] 0 {} {} eq STTT\0\x10]} {
						>
							emit STTT
						<
					}
	
					if {[S string [O 16] 0 {} {} eq TIMG\0]} {
						>
							emit TIMG
						<
					}
	
					if {[S string [O 16] 0 {} {} eq \0\x80]} {
						>
							if {[N beshort [O 2] 0 0 {} {} == 24]} {
								>
									emit NOSIG
								<
							}
	
							if {[N beshort [O 2] 0 0 {} {} != 24]} {
								>
									emit HYPERPAINT
								<
							}
	
						<
					}
	
					if {[D [O 16]]} {
						>
							if {[S string [O 16] 0 {} {} ne XIMG\0]} {
								>
									emit NOSIG
								<
							}
	
						<
					}
	
				<
			}
	
			if {[S string [O 16] 0 {} {} eq XIMG\0]} {
				>
					emit {XIMG Image data}
					ext img/ximg
				<
			}
	
			if {[S string [O 16] 0 {} {} ne XIMG\0]} {
				>
					emit {Image data}
					ext img
				<
			}
	
			if {[N beshort [O 2] 0 0 {} {} == 9]} {
				>
					emit (Ventura)
				<
			}
	
			if {[N beshort [O 12] 0 0 {} {} x {}]} {
				>
					emit {%d x}
				<
			}
	
			if {[N beshort [O 14] 0 0 {} {} x {}]} {
				>
					emit %d,
				<
			}
	
			if {[N beshort [O 4] 0 0 {} {} x {}]} {
				>
					emit {%d planes,}
				<
			}
	
			if {[N beshort [O 8] 0 0 {} {} x {}]} {
				>
					emit {%d x}
				<
			}
	
			if {[N beshort [O 10] 0 0 {} {} x {}]} {
				>
					emit {%d pixelsize}
				<
			}
	
			if {[N beshort [O 6] 0 0 {} {} != 2]} {
				>
					emit {\b, pattern size %d}
				<
			}
	
			mime image/x-gem
		<
	}
	} dpx_info {if {[N beshort [O 768] 0 0 {} {} < 4]} {
		>
			if {[N belong [O 772] 0 0 {} {} x {}]} {
				>
					emit %dx
				<
			}
	
			if {[N belong [O 776] 0 0 {} {} x {}]} {
				>
					emit {\b%d,}
				<
			}
	
		<
	}
	
	if {[N beshort [O 768] 0 0 {} {} > 3]} {
		>
			if {[N belong [O 776] 0 0 {} {} x {}]} {
				>
					emit %dx
				<
			}
	
			if {[N belong [O 772] 0 0 {} {} x {}]} {
				>
					emit {\b%d,}
				<
			}
	
		<
	}
	
	switch [Nv beshort [O 768] 0 {} {}] {
		0 {
			>
				emit {left to right/top to bottom}
			<
		}
		1 {
			>
				emit {right to left/top to bottom}
			<
		}
		2 {
			>
				emit {left to right/bottom to top}
			<
		}
		3 {
			>
				emit {right to left/bottom to top}
			<
		}
		4 {
			>
				emit {top to bottom/left to right}
			<
		}
		5 {
			>
				emit {top to bottom/right to left}
			<
		}
		6 {
			>
				emit {bottom to top/left to right}
			<
		}
		7 {
			>
				emit {bottom to top/right to left}
			<
		}
	}
	} ms-directdraw-surface {if {[N ulelong [O 16] 0 0 {} {} x {}]} {
		>
			emit {%u x}
		<
	}
	
	if {[N ulelong [O 12] 0 0 {} {} x {}]} {
		>
			emit %u
		<
	}
	
	if {[N ulelong [O 88] 0 0 {} {} > 0]} {
		>
			emit {\b, %u-bit color}
		<
	}
	
	if {[N ulelong [O 80] 0 0 & 4 == 4]} {
		>
			if {[S string [O 84] 0 {} {} x {}]} {
				>
					emit {\b, compressed using %.4s}
				<
			}
	
		<
	}
	
	if {[N ulelong [O 80] 0 0 & 2 == 2]} {
		>
			emit {\b, alpha only}
		<
	}
	
	if {[N ulelong [O 80] 0 0 & 512 == 512]} {
		>
			emit {\b, YUV}
		<
	}
	
	if {[N ulelong [O 80] 0 0 & 131072 == 131072]} {
		>
			emit {\b, luminance}
		<
	}
	
	if {[N ulelong [O 80] 0 0 & 64 == 64]} {
		>
			switch [Nv ulelong [O 88] 0 {} {}] {
				16 {
					>
						switch [Nv ulequad [O 92] 0 {} {}] {
							1030792151055 {
								>
									if {[N ulequad [O 100] 0 0 {} {} == 263882790670080]} {
										>
											emit {\b, ABGR4444}
										<
									}
	
								<
								>
									if {[N ulequad [O 100] 0 0 {} {} == 3840]} {
										>
											emit {\b, xBGR4444}
										<
									}
	
								<
							}
							1030792154880 {
								>
									if {[N ulequad [O 100] 0 0 {} {} == 263882790666255]} {
										>
											emit {\b, ARGB4444}
										<
									}
	
								<
								>
									if {[N ulequad [O 100] 0 0 {} {} == 15]} {
										>
											emit {\b, xRGB4444}
										<
									}
	
								<
							}
							4260607565568 {
								>
									if {[N ulequad [O 100] 0 0 {} {} == 124]} {
										>
											emit {\b, BGR555}
										<
									}
	
								<
								>
									if {[N ulequad [O 100] 0 0 {} {} == 140737488355452]} {
										>
											emit {\b, ABGR1555}
										<
									}
	
								<
							}
							4260607589376 {
								>
									if {[N ulequad [O 100] 0 0 {} {} == 31]} {
										>
											emit {\b, RGB555}
										<
									}
	
								<
								>
									if {[N ulequad [O 100] 0 0 {} {} == 140737488355359]} {
										>
											emit {\b, ARGB1555}
										<
									}
	
								<
							}
							8521215115326 {
								>
									if {[N ulequad [O 100] 0 0 {} {} == 4295030784]} {
										>
											emit {\b, BGRA5551}
										<
									}
	
								<
							}
							8521215178752 {
								>
									if {[N ulequad [O 100] 0 0 {} {} == 4294967358]} {
										>
											emit {\b, RGBA5551}
										<
									}
	
								<
							}
							8658654076672 {
								>
									if {[N ulequad [O 100] 0 0 {} {} == 248]} {
										>
											emit {\b, BGR565}
										<
									}
	
								<
							}
							8658654132224 {
								>
									if {[N ulequad [O 100] 0 0 {} {} == 31]} {
										>
											emit {\b, RGB565}
										<
									}
	
								<
							}
							16492674416880 {
								>
									if {[N ulequad [O 100] 0 0 {} {} == 64424570880]} {
										>
											emit {\b, BGRA4444}
										<
									}
	
								<
								>
									if {[N ulequad [O 100] 0 0 {} {} == 61440]} {
										>
											emit {\b, BGRx4444}
										<
									}
	
								<
							}
							16492674478080 {
								>
									if {[N ulequad [O 100] 0 0 {} {} == 64424509680]} {
										>
											emit {\b, RGBA4444}
										<
									}
	
								<
								>
									if {[N ulequad [O 100] 0 0 {} {} == 240]} {
										>
											emit {\b, RGBx4444}
										<
									}
	
								<
							}
						}
	
					<
				}
				24 {
					>
						switch [Nv ulequad [O 92] 0 {} {}] {
							280375465083135 {
								>
									if {[N ulequad [O 100] 0 0 {} {} == 16711680]} {
										>
											emit {\b, BGR888}
										<
									}
	
								<
							}
							280375481794560 {
								>
									if {[N ulequad [O 100] 0 0 {} {} == 255]} {
										>
											emit {\b, RGB888}
										<
									}
	
								<
							}
						}
	
					<
				}
				32 {
					>
						switch [Nv ulequad [O 92] 0 {} {}] {
							280375465083135 {
								>
									if {[N ulequad [O 100] 0 0 {} {} == 18374686479688335360]} {
										>
											emit {\b, ABGR8888}
										<
									}
	
								<
								>
									if {[N ulequad [O 100] 0 0 {} {} == 16711680]} {
										>
											emit {\b, xBGR8888}
										<
									}
	
								<
							}
							280375481794560 {
								>
									if {[N ulequad [O 100] 0 0 {} {} == 18374686479671623935]} {
										>
											emit {\b, ARGB8888}
										<
									}
	
								<
								>
									if {[N ulequad [O 100] 0 0 {} {} == 255]} {
										>
											emit {\b, xRGB8888}
										<
									}
	
								<
							}
							281474976645120 {
								>
									if {[N ulequad [O 100] 0 0 {} {} == 0]} {
										>
											emit {\b, R16G16}
										<
									}
	
								<
							}
							4499201580860415 {
								>
									if {[N ulequad [O 100] 0 0 {} {} == 13835058056354856960]} {
										>
											emit {\b, A2B10G10R10}
										<
									}
	
								<
							}
							4499202653552640 {
								>
									if {[N ulequad [O 100] 0 0 {} {} == 13835058055282164735]} {
										>
											emit {\b, A2R10G10B10}
										<
									}
	
								<
							}
							71776119061282560 {
								>
									if {[N ulequad [O 100] 0 0 {} {} == 1099494850560]} {
										>
											emit {\b, BGBA8888}
										<
									}
	
								<
								>
									if {[N ulequad [O 100] 0 0 {} {} == 4278190080]} {
										>
											emit {\b, BGBx8888}
										<
									}
	
								<
							}
							71776123339407360 {
								>
									if {[N ulequad [O 100] 0 0 {} {} == 1095216725760]} {
										>
											emit {\b, RGBA8888}
										<
									}
	
								<
								>
									if {[N ulequad [O 100] 0 0 {} {} == 65280]} {
										>
											emit {\b, RGBx8888}
										<
									}
	
								<
							}
							18446462598732906495 {
								>
									if {[N ulequad [O 100] 0 0 {} {} == 0]} {
										>
											emit {\b, G16R16}
										<
									}
	
								<
							}
						}
	
					<
				}
			}
	
		<
	}
	} sega-pvr-image-header {if {[N leshort [O 12] 0 0 {} {} x {}]} {
		>
			emit {%u x}
		<
	}
	
	if {[N leshort [O 14] 0 0 {} {} x {}]} {
		>
			emit %u
		<
	}
	
	switch [Nv byte [O 8] 0 {} {}] {
		0 {
			>
				emit {\b, ARGB1555}
			<
		}
		1 {
			>
				emit {\b, RGB565}
			<
		}
		2 {
			>
				emit {\b, ARGB4444}
			<
		}
		3 {
			>
				emit {\b, YUV442}
			<
		}
		4 {
			>
				emit {\b, Bump}
			<
		}
		5 {
			>
				emit {\b, 4bpp}
			<
		}
		6 {
			>
				emit {\b, 8bpp}
			<
		}
	}
	
	switch [Nv byte [O 9] 0 {} {}] {
		1 {
			>
				emit {\b, square twiddled}
			<
		}
		2 {
			>
				emit {\b, square twiddled & mipmap}
			<
		}
		3 {
			>
				emit {\b, VQ}
			<
		}
		4 {
			>
				emit {\b, VQ & mipmap}
			<
		}
		5 {
			>
				emit {\b, 8-bit CLUT twiddled}
			<
		}
		6 {
			>
				emit {\b, 4-bit CLUT twiddled}
			<
		}
		7 {
			>
				emit {\b, 8-bit direct twiddled}
			<
		}
		8 {
			>
				emit {\b, 4-bit direct twiddled}
			<
		}
		9 {
			>
				emit {\b, rectangle}
			<
		}
		11 {
			>
				emit {\b, rectangular stride}
			<
		}
		13 {
			>
				emit {\b, rectangular twiddled}
			<
		}
		16 {
			>
				emit {\b, small VQ}
			<
		}
		17 {
			>
				emit {\b, small VQ & mipmap}
			<
		}
		18 {
			>
				emit {\b, square twiddled & mipmap}
			<
		}
	}
	} sega-gvr-image-header {if {[N beshort [O 12] 0 0 {} {} x {}]} {
		>
			emit {%u x}
		<
	}
	
	if {[N beshort [O 14] 0 0 {} {} x {}]} {
		>
			emit %u
		<
	}
	
	switch [Nv byte [O 11] 0 {} {}] {
		0 {
			>
				emit {\b, I4}
			<
		}
		1 {
			>
				emit {\b, I8}
			<
		}
		2 {
			>
				emit {\b, IA4}
			<
		}
		3 {
			>
				emit {\b, IA8}
			<
		}
		4 {
			>
				emit {\b, RGB565}
			<
		}
		5 {
			>
				emit {\b, RGB5A3}
			<
		}
		6 {
			>
				emit {\b, ARGB8888}
			<
		}
		8 {
			>
				emit {\b, CI4}
			<
		}
		9 {
			>
				emit {\b, CI8}
			<
		}
		14 {
			>
				emit {\b, DXT1}
			<
		}
	}
	} khronos-ktx-glEnum {switch [Nv lelong [O 0] 0 {} {}] {
		6407 {
			>
				emit {\b, RGB}
			<
		}
		6408 {
			>
				emit {\b, RGBA}
			<
		}
		6409 {
			>
				emit {\b, LUMINANCE}
			<
		}
		6410 {
			>
				emit {\b, LUMINANCE_ALPHA}
			<
		}
		32993 {
			>
				emit {\b, BGR}
			<
		}
		32994 {
			>
				emit {\b, BGRA}
			<
		}
		33696 {
			>
				emit {\b, RGB_S3TC}
			<
		}
		33697 {
			>
				emit {\b, RGB4_S3TC}
			<
		}
		33698 {
			>
				emit {\b, RGBA_S3TC}
			<
		}
		33699 {
			>
				emit {\b, RGBA4_S3TC}
			<
		}
		33700 {
			>
				emit {\b, RGBA_DXT5_S3TC}
			<
		}
		33701 {
			>
				emit {\b, RGBA4_DXT5_S3TC}
			<
		}
		36196 {
			>
				emit {\b, ETC1_RGB8_OES}
			<
		}
		37488 {
			>
				emit {\b, COMPRESSED_R11_EAC}
			<
		}
		37489 {
			>
				emit {\b, COMPRESSED_SIGNED_R11_EAC}
			<
		}
		37490 {
			>
				emit {\b, COMPRESSED_RG11_EAC}
			<
		}
		37491 {
			>
				emit {\b, COMPRESSED_SIGNED_RG11_EAC}
			<
		}
		37492 {
			>
				emit {\b, COMPRESSED_RGB8_ETC2}
			<
		}
		37493 {
			>
				emit {\b, COMPRESSED_SRGB8_ETC2}
			<
		}
		37494 {
			>
				emit {\b, COMPRESSED_RGB8_PUNCHTHROUGH_ALPHA1_ETC2}
			<
		}
		37495 {
			>
				emit {\b, COMPRESSED_SRGB8_PUNCHTHROUGH_ALPHA1_ETC2}
			<
		}
		37496 {
			>
				emit {\b, COMPRESSED_RGBA2_ETC2_EAC}
			<
		}
		37497 {
			>
				emit {\b, COMPRESSED_SRGB8_ALPHA8_ETC2_EAC}
			<
		}
		37808 {
			>
				emit {\b, COMPRESSED_RGBA_ASTC_4x4_KHR}
			<
		}
		37809 {
			>
				emit {\b, COMPRESSED_RGBA_ASTC_5x4_KHR}
			<
		}
		37810 {
			>
				emit {\b, COMPRESSED_RGBA_ASTC_5x5_KHR}
			<
		}
		37811 {
			>
				emit {\b, COMPRESSED_RGBA_ASTC_6x5_KHR}
			<
		}
		37812 {
			>
				emit {\b, COMPRESSED_RGBA_ASTC_6x6_KHR}
			<
		}
		37813 {
			>
				emit {\b, COMPRESSED_RGBA_ASTC_8x5_KHR}
			<
		}
		37814 {
			>
				emit {\b, COMPRESSED_RGBA_ASTC_8x6_KHR}
			<
		}
		37815 {
			>
				emit {\b, COMPRESSED_RGBA_ASTC_8x8_KHR}
			<
		}
		37816 {
			>
				emit {\b, COMPRESSED_RGBA_ASTC_10x5_KHR}
			<
		}
		37817 {
			>
				emit {\b, COMPRESSED_RGBA_ASTC_10x6_KHR}
			<
		}
		37818 {
			>
				emit {\b, COMPRESSED_RGBA_ASTC_10x8_KHR}
			<
		}
		37819 {
			>
				emit {\b, COMPRESSED_RGBA_ASTC_10x10_KHR}
			<
		}
		37820 {
			>
				emit {\b, COMPRESSED_RGBA_ASTC_12x10_KHR}
			<
		}
		37821 {
			>
				emit {\b, COMPRESSED_RGBA_ASTC_12x12_KHR}
			<
		}
		37840 {
			>
				emit {\b, COMPRESSED_SRGB8_ALPHA8_ASTC_4x4_KHR}
			<
		}
		37841 {
			>
				emit {\b, COMPRESSED_SRGB8_ALPHA8_ASTC_5x4_KHR}
			<
		}
		37842 {
			>
				emit {\b, COMPRESSED_SRGB8_ALPHA8_ASTC_5x5_KHR}
			<
		}
		37843 {
			>
				emit {\b, COMPRESSED_SRGB8_ALPHA8_ASTC_6x5_KHR}
			<
		}
		37844 {
			>
				emit {\b, COMPRESSED_SRGB8_ALPHA8_ASTC_6x6_KHR}
			<
		}
		37845 {
			>
				emit {\b, COMPRESSED_SRGB8_ALPHA8_ASTC_8x5_KHR}
			<
		}
		37846 {
			>
				emit {\b, COMPRESSED_SRGB8_ALPHA8_ASTC_8x6_KHR}
			<
		}
		37847 {
			>
				emit {\b, COMPRESSED_SRGB8_ALPHA8_ASTC_8x8_KHR}
			<
		}
		37848 {
			>
				emit {\b, COMPRESSED_SRGB8_ALPHA8_ASTC_10x5_KHR}
			<
		}
		37849 {
			>
				emit {\b, COMPRESSED_SRGB8_ALPHA8_ASTC_10x6_KHR}
			<
		}
		37850 {
			>
				emit {\b, COMPRESSED_SRGB8_ALPHA8_ASTC_10x8_KHR}
			<
		}
		37851 {
			>
				emit {\b, COMPRESSED_SRGB8_ALPHA8_ASTC_10x10_KHR}
			<
		}
		37852 {
			>
				emit {\b, COMPRESSED_SRGB8_ALPHA8_ASTC_12x10_KHR}
			<
		}
		37853 {
			>
				emit {\b, COMPRESSED_SRGB8_ALPHA8_ASTC_12x12_KHR}
			<
		}
	}
	} khronos-ktx-endian-header {if {[N lelong [O 20] 0 0 {} {} x {}]} {
		>
			emit {\b, %u}
		<
	}
	
	if {[N lelong [O 24] 0 0 {} {} > 1]} {
		>
			emit {x %u}
		<
	}
	
	if {[N lelong [O 28] 0 0 {} {} > 1]} {
		>
			emit {x %u}
		<
	}
	
	if {[N lelong [O 8] 0 0 {} {} > 0]} {
		>
			U 111 khronos-ktx-glEnum [O 8]
	
		<
	}
	
	if {[N lelong [O 8] 0 0 {} {} == 0]} {
		>
			U 111 khronos-ktx-glEnum [O 12]
	
		<
	}
	} vtf-image-format {switch [Nv lelong [O 0] 0 {} {}] {
		0 {
			>
				emit RGBA8888
			<
		}
		1 {
			>
				emit ABGR8888
			<
		}
		2 {
			>
				emit RGB888
			<
		}
		3 {
			>
				emit BGR888
			<
		}
		4 {
			>
				emit RGB565
			<
		}
		5 {
			>
				emit I8
			<
		}
		6 {
			>
				emit IA88
			<
		}
		7 {
			>
				emit P8
			<
		}
		8 {
			>
				emit A8
			<
		}
		9 {
			>
				emit {RGB888 (bluescreen)}
			<
		}
		10 {
			>
				emit {BGR888 (bluescreen)}
			<
		}
		11 {
			>
				emit ARGB8888
			<
		}
		12 {
			>
				emit BGRA8888
			<
		}
		13 {
			>
				emit DXT1
			<
		}
		14 {
			>
				emit DXT3
			<
		}
		15 {
			>
				emit DXT5
			<
		}
		16 {
			>
				emit BGRx8888
			<
		}
		17 {
			>
				emit BGR565
			<
		}
		18 {
			>
				emit BGRx5551
			<
		}
		19 {
			>
				emit BGRA4444
			<
		}
		20 {
			>
				emit DXT1+A1
			<
		}
		21 {
			>
				emit BGRA5551
			<
		}
		22 {
			>
				emit UV88
			<
		}
		23 {
			>
				emit UVWQ8888
			<
		}
		24 {
			>
				emit RGBA16161616F
			<
		}
		25 {
			>
				emit RGBA16161616
			<
		}
		26 {
			>
				emit UVLX8888
			<
		}
	}
	}}
	120
		{jpeg_segment {switch [Nv beshort [O 0] 0 {} {}] {
		-64 {
			>
				U 120 jpeg_segment [O [I 2 ubeshort 0 + 0 2]]
	
				if {[N byte [O 4] 0 0 {} {} x {}]} {
					>
						emit {\b, baseline, precision %d}
					<
				}
	
				if {[N beshort [O 7] 0 0 {} {} x {}]} {
					>
						emit {\b, %dx}
					<
				}
	
				if {[N beshort [O 5] 0 0 {} {} x {}]} {
					>
						emit {\b%d}
					<
				}
	
				if {[N byte [O 9] 0 0 {} {} x {}]} {
					>
						emit {\b, frames %d}
					<
				}
	
			<
		}
		-63 {
			>
				U 120 jpeg_segment [O [I 2 ubeshort 0 + 0 2]]
	
				if {[N byte [O 4] 0 0 {} {} x {}]} {
					>
						emit {\b, extended sequential, precision %d}
					<
				}
	
				if {[N beshort [O 7] 0 0 {} {} x {}]} {
					>
						emit {\b, %dx}
					<
				}
	
				if {[N beshort [O 5] 0 0 {} {} x {}]} {
					>
						emit {\b%d}
					<
				}
	
				if {[N byte [O 9] 0 0 {} {} x {}]} {
					>
						emit {\b, frames %d}
					<
				}
	
			<
		}
		-62 {
			>
				U 120 jpeg_segment [O [I 2 ubeshort 0 + 0 2]]
	
				if {[N byte [O 4] 0 0 {} {} x {}]} {
					>
						emit {\b, progressive, precision %d}
					<
				}
	
				if {[N beshort [O 7] 0 0 {} {} x {}]} {
					>
						emit {\b, %dx}
					<
				}
	
				if {[N beshort [O 5] 0 0 {} {} x {}]} {
					>
						emit {\b%d}
					<
				}
	
				if {[N byte [O 9] 0 0 {} {} x {}]} {
					>
						emit {\b, frames %d}
					<
				}
	
			<
		}
		-60 {
			>
				U 120 jpeg_segment [O [I 2 ubeshort 0 + 0 2]]
	
			<
		}
		-31 {
			>
				if {[S string [O 4] 0 {} {} eq Exif]} {
					>
						emit {\b, Exif Standard: [}
						T [O 10] r
	
						if {[S string [O 10] 0 {} {} x {}]} {
							>
								emit {\b]}
							<
						}
	
					<
				}
	
			<
		}
		-2 {
			>
				if {[S pstring [O 2] 0 {H J} {} x {}]} {
					>
						emit {\b, comment: "%s"}
					<
				}
	
			<
		}
	}
	
	if {[N beshort [O 0] 0 0 & -32 == -32]} {
		>
			U 120 jpeg_segment [O [I 2 ubeshort 0 + 0 2]]
	
		<
	}
	
	if {[N beshort [O 0] 0 0 & -48 == -48]} {
		>
			if {[N beshort [O 0] 0 0 & -32 != -32]} {
				>
					U 120 jpeg_segment [O [I 2 ubeshort 0 + 0 2]]
	
				<
			}
	
		<
	}
	}}
	124
		{keytab_entry {if {[S pstring [O 4] 0 H {} x {}]} {
		>
			emit {\b, realm=%s}
			if {[S pstring [R [O 0]] 0 H {} x {}]} {
				>
					emit {\b, principal=%s/}
					if {[S pstring [R [O 0]] 0 H {} x {}]} {
						>
							emit {\b%s}
							if {[N belong [R [O 0]] 0 0 {} {} x {}]} {
								>
									emit {\b, type=%d}
									if {[N bedate [R [O 0]] 0 0 {} {} x {}]} {
										>
											emit {\b, date=%s}
											if {[N byte [R [O 0]] 0 0 {} {} x {}]} {
												>
													emit {\b, kvno=%u}
												<
											}
	
										<
									}
	
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	}}
	129
		{linuxraid {if {[N belong [O 16] 0 0 {} {} x {}]} {
		>
			emit UUID=%8x:
		<
	}
	
	if {[N belong [O 20] 0 0 {} {} x {}]} {
		>
			emit {\b%8x:}
		<
	}
	
	if {[N belong [O 24] 0 0 {} {} x {}]} {
		>
			emit {\b%8x:}
		<
	}
	
	if {[N belong [O 28] 0 0 {} {} x {}]} {
		>
			emit {\b%8x}
		<
	}
	
	if {[S string [O 32] 0 {} {} x {}]} {
		>
			emit name=%s
		<
	}
	
	if {[N lelong [O 72] 0 0 {} {} x {}]} {
		>
			emit level=%d
		<
	}
	
	if {[N lelong [O 92] 0 0 {} {} x {}]} {
		>
			emit disks=%d
		<
	}
	}}
	135
		{mach-o-cpu {switch [Nv belong [O 0] 0 & 16777216] {
		0 {
			>
				switch [Nv belong [O 0] 0 & 16777215] {
					1 {
						>
							switch [Nv belong [O 4] 0 & 16777215] {
								0 {
									>
										emit vax
									<
								}
								1 {
									>
										emit vax11/780
									<
								}
								2 {
									>
										emit vax11/785
									<
								}
								3 {
									>
										emit vax11/750
									<
								}
								4 {
									>
										emit vax11/730
									<
								}
								5 {
									>
										emit uvaxI
									<
								}
								6 {
									>
										emit uvaxII
									<
								}
								7 {
									>
										emit vax8200
									<
								}
								8 {
									>
										emit vax8500
									<
								}
								9 {
									>
										emit vax8600
									<
								}
								10 {
									>
										emit vax8650
									<
								}
								11 {
									>
										emit vax8800
									<
								}
								12 {
									>
										emit uvaxIII
									<
								}
							}
	
							if {[N belong [O 4] 0 0 & 16777215 > 12]} {
								>
									emit {vax subarchitecture=%d}
								<
							}
	
						<
					}
					2 {
						>
							emit romp
						<
					}
					3 {
						>
							emit architecture=3
						<
					}
					4 {
						>
							emit ns32032
						<
					}
					5 {
						>
							emit ns32332
						<
					}
					6 {
						>
							emit m68k
						<
					}
					7 {
						>
							switch [Nv belong [O 4] 0 & 15] {
								3 {
									>
										emit i386
									<
								}
								4 {
									>
										emit i486
										switch [Nv belong [O 4] 0 & 16777200] {
											0 {
												>
												<
											}
											128 {
												>
													emit {\bsx}
												<
											}
										}
	
									<
								}
								5 {
									>
										emit i586
									<
								}
								6 {
									>
										switch [Nv belong [O 4] 0 & 16777200] {
											0 {
												>
													emit p6
												<
											}
											16 {
												>
													emit pentium_pro
												<
											}
											32 {
												>
													emit pentium_2_m0x20
												<
											}
											48 {
												>
													emit pentium_2_m3
												<
											}
											64 {
												>
													emit pentium_2_m0x40
												<
											}
											80 {
												>
													emit pentium_2_m5
												<
											}
										}
	
										if {[N belong [O 4] 0 0 & 16777200 > 80]} {
											>
												emit pentium_2_m0x%x
											<
										}
	
									<
								}
								7 {
									>
										emit celeron
										switch [Nv belong [O 4] 0 & 16777200] {
											0 {
												>
													emit {\b_m0x%x}
												<
											}
											16 {
												>
													emit {\b_m0x%x}
												<
											}
											32 {
												>
													emit {\b_m0x%x}
												<
											}
											48 {
												>
													emit {\b_m0x%x}
												<
											}
											64 {
												>
													emit {\b_m0x%x}
												<
											}
											80 {
												>
													emit {\b_m0x%x}
												<
											}
											96 {
												>
												<
											}
											112 {
												>
													emit {\b_mobile}
												<
											}
										}
	
										if {[N belong [O 4] 0 0 & 16777200 > 112]} {
											>
												emit {\b_m0x%x}
											<
										}
	
									<
								}
								8 {
									>
										emit pentium_3
										switch [Nv belong [O 4] 0 & 16777200] {
											0 {
												>
												<
											}
											16 {
												>
													emit {\b_m}
												<
											}
											32 {
												>
													emit {\b_xeon}
												<
											}
										}
	
										if {[N belong [O 4] 0 0 & 16777200 > 32]} {
											>
												emit {\b_m0x%x}
											<
										}
	
									<
								}
								9 {
									>
										emit pentiumM
										if {[N belong [O 4] 0 0 & 16777200 == 0]} {
											>
											<
										}
	
										if {[N belong [O 4] 0 0 & 16777200 > 0]} {
											>
												emit {\b_m0x%x}
											<
										}
	
									<
								}
								10 {
									>
										emit pentium_4
										switch [Nv belong [O 4] 0 & 16777200] {
											0 {
												>
												<
											}
											16 {
												>
													emit {\b_m}
												<
											}
										}
	
										if {[N belong [O 4] 0 0 & 16777200 > 16]} {
											>
												emit {\b_m0x%x}
											<
										}
	
									<
								}
								11 {
									>
										emit itanium
										switch [Nv belong [O 4] 0 & 16777200] {
											0 {
												>
												<
											}
											16 {
												>
													emit {\b_2}
												<
											}
										}
	
										if {[N belong [O 4] 0 0 & 16777200 > 16]} {
											>
												emit {\b_m0x%x}
											<
										}
	
									<
								}
								12 {
									>
										emit xeon
										switch [Nv belong [O 4] 0 & 16777200] {
											0 {
												>
												<
											}
											16 {
												>
													emit {\b_mp}
												<
											}
										}
	
										if {[N belong [O 4] 0 0 & 16777200 > 16]} {
											>
												emit {\b_m0x%x}
											<
										}
	
									<
								}
							}
	
							if {[N belong [O 4] 0 0 & 15 > 12]} {
								>
									emit {ia32 family=%d}
									if {[N belong [O 4] 0 0 & 16777200 == 0]} {
										>
										<
									}
	
									if {[N belong [O 4] 0 0 & 16777200 > 0]} {
										>
											emit model=%x
										<
									}
	
								<
							}
	
						<
					}
					8 {
						>
							emit mips
							switch [Nv belong [O 4] 0 & 16777215] {
								1 {
									>
										emit R2300
									<
								}
								2 {
									>
										emit R2600
									<
								}
								3 {
									>
										emit R2800
									<
								}
								4 {
									>
										emit R2000a
									<
								}
								5 {
									>
										emit R2000
									<
								}
								6 {
									>
										emit R3000a
									<
								}
								7 {
									>
										emit R3000
									<
								}
							}
	
							if {[N belong [O 4] 0 0 & 16777215 > 7]} {
								>
									emit subarchitecture=%d
								<
							}
	
						<
					}
					9 {
						>
							emit ns32532
						<
					}
					10 {
						>
							emit mc98000
						<
					}
					11 {
						>
							emit hppa
							switch [Nv belong [O 4] 0 & 16777215] {
								0 {
									>
										emit 7100
									<
								}
								1 {
									>
										emit 7100LC
									<
								}
							}
	
							if {[N belong [O 4] 0 0 & 16777215 > 1]} {
								>
									emit subarchitecture=%d
								<
							}
	
						<
					}
					12 {
						>
							emit arm
							switch [Nv belong [O 4] 0 & 16777215] {
								0 {
									>
									<
								}
								1 {
									>
										emit subarchitecture=%d
									<
								}
								2 {
									>
										emit subarchitecture=%d
									<
								}
								3 {
									>
										emit subarchitecture=%d
									<
								}
								4 {
									>
										emit subarchitecture=%d
									<
								}
								5 {
									>
										emit {\bv4t}
									<
								}
								6 {
									>
										emit {\bv6}
									<
								}
								7 {
									>
										emit {\bv5tej}
									<
								}
								8 {
									>
										emit {\bxscale}
									<
								}
								9 {
									>
										emit {\bv7}
									<
								}
								10 {
									>
										emit {\bv7f}
									<
								}
								11 {
									>
										emit {\bv7s}
									<
								}
								12 {
									>
										emit {\bv7k}
									<
								}
								13 {
									>
										emit {\bv8}
									<
								}
								14 {
									>
										emit {\bv6m}
									<
								}
								15 {
									>
										emit {\bv7m}
									<
								}
								16 {
									>
										emit {\bv7em}
									<
								}
							}
	
							if {[N belong [O 4] 0 0 & 16777215 > 16]} {
								>
									emit subarchitecture=%d
								<
							}
	
						<
					}
					13 {
						>
							switch [Nv belong [O 4] 0 & 16777215] {
								0 {
									>
										emit mc88000
									<
								}
								1 {
									>
										emit mc88100
									<
								}
								2 {
									>
										emit mc88110
									<
								}
							}
	
							if {[N belong [O 4] 0 0 & 16777215 > 2]} {
								>
									emit {mc88000 subarchitecture=%d}
								<
							}
	
						<
					}
					14 {
						>
							emit SPARC
						<
					}
					15 {
						>
							emit i860g
						<
					}
					16 {
						>
							emit alpha
						<
					}
					17 {
						>
							emit rs6000
						<
					}
					18 {
						>
							emit ppc
							switch [Nv belong [O 4] 0 & 16777215] {
								0 {
									>
									<
								}
								1 {
									>
										emit {\b_601}
									<
								}
								2 {
									>
										emit {\b_602}
									<
								}
								3 {
									>
										emit {\b_603}
									<
								}
								4 {
									>
										emit {\b_603e}
									<
								}
								5 {
									>
										emit {\b_603ev}
									<
								}
								6 {
									>
										emit {\b_604}
									<
								}
								7 {
									>
										emit {\b_604e}
									<
								}
								8 {
									>
										emit {\b_620}
									<
								}
								9 {
									>
										emit {\b_650}
									<
								}
								10 {
									>
										emit {\b_7400}
									<
								}
								11 {
									>
										emit {\b_7450}
									<
								}
								100 {
									>
										emit {\b_970}
									<
								}
							}
	
							if {[N belong [O 4] 0 0 & 16777215 > 100]} {
								>
									emit subarchitecture=%d
								<
							}
	
						<
					}
				}
	
				if {[N belong [O 0] 0 0 & 16777215 > 18]} {
					>
						emit architecture=%d
					<
				}
	
			<
		}
		16777216 {
			>
				switch [Nv belong [O 0] 0 & 16777215] {
					0 {
						>
							emit {64-bit architecture=%d}
						<
					}
					1 {
						>
							emit {64-bit architecture=%d}
						<
					}
					2 {
						>
							emit {64-bit architecture=%d}
						<
					}
					3 {
						>
							emit {64-bit architecture=%d}
						<
					}
					4 {
						>
							emit {64-bit architecture=%d}
						<
					}
					5 {
						>
							emit {64-bit architecture=%d}
						<
					}
					6 {
						>
							emit {64-bit architecture=%d}
						<
					}
					7 {
						>
							emit x86_64
							switch [Nv belong [O 4] 0 & 16777215] {
								0 {
									>
										emit subarchitecture=%d
									<
								}
								1 {
									>
										emit subarchitecture=%d
									<
								}
								2 {
									>
										emit subarchitecture=%d
									<
								}
								3 {
									>
									<
								}
								4 {
									>
										emit {\b_arch1}
									<
								}
								8 {
									>
										emit {\b_haswell}
									<
								}
							}
	
							if {[N belong [O 4] 0 0 & 16777215 > 4]} {
								>
									emit subarchitecture=%d
								<
							}
	
						<
					}
					8 {
						>
							emit {64-bit architecture=%d}
						<
					}
					9 {
						>
							emit {64-bit architecture=%d}
						<
					}
					10 {
						>
							emit {64-bit architecture=%d}
						<
					}
					11 {
						>
							emit {64-bit architecture=%d}
						<
					}
					12 {
						>
							emit arm64
							switch [Nv belong [O 4] 0 & 16777215] {
								0 {
									>
									<
								}
								1 {
									>
										emit {\bv8}
									<
								}
							}
	
						<
					}
					13 {
						>
							emit {64-bit architecture=%d}
						<
					}
					14 {
						>
							emit {64-bit architecture=%d}
						<
					}
					15 {
						>
							emit {64-bit architecture=%d}
						<
					}
					16 {
						>
							emit {64-bit architecture=%d}
						<
					}
					17 {
						>
							emit {64-bit architecture=%d}
						<
					}
					18 {
						>
							emit ppc64
							switch [Nv belong [O 4] 0 & 16777215] {
								0 {
									>
									<
								}
								1 {
									>
										emit {\b_601}
									<
								}
								2 {
									>
										emit {\b_602}
									<
								}
								3 {
									>
										emit {\b_603}
									<
								}
								4 {
									>
										emit {\b_603e}
									<
								}
								5 {
									>
										emit {\b_603ev}
									<
								}
								6 {
									>
										emit {\b_604}
									<
								}
								7 {
									>
										emit {\b_604e}
									<
								}
								8 {
									>
										emit {\b_620}
									<
								}
								9 {
									>
										emit {\b_650}
									<
								}
								10 {
									>
										emit {\b_7400}
									<
								}
								11 {
									>
										emit {\b_7450}
									<
								}
								100 {
									>
										emit {\b_970}
									<
								}
							}
	
							if {[N belong [O 4] 0 0 & 16777215 > 100]} {
								>
									emit subarchitecture=%d
								<
							}
	
						<
					}
				}
	
				if {[N belong [O 0] 0 0 & 16777215 > 18]} {
					>
						emit {64-bit architecture=%d}
					<
				}
	
			<
		}
	}
	} mach-o-be {if {[N byte [O 0] 0 0 {} {} == -49]} {
		>
			emit 64-bit
		<
	}
	
	U 135 mach-o-cpu [O 4]
	
	switch [Nv belong [O 12] 0 {} {}] {
		1 {
			>
				emit object
			<
		}
		2 {
			>
				emit executable
			<
		}
		3 {
			>
				emit {fixed virtual memory shared library}
			<
		}
		4 {
			>
				emit core
			<
		}
		5 {
			>
				emit {preload executable}
			<
		}
		6 {
			>
				emit {dynamically linked shared library}
			<
		}
		7 {
			>
				emit {dynamic linker}
			<
		}
		8 {
			>
				emit bundle
			<
		}
		9 {
			>
				emit {dynamically linked shared library stub}
			<
		}
		10 {
			>
				emit {dSYM companion file}
			<
		}
		11 {
			>
				emit {kext bundle}
			<
		}
	}
	
	if {[N belong [O 12] 0 0 {} {} > 11]} {
		>
			if {[N belong [O 12] 0 0 {} {} x {}]} {
				>
					emit filetype=%d
				<
			}
	
		<
	}
	
	if {[N belong [O 24] 0 0 {} {} > 0]} {
		>
			emit {\b, flags:<}
			if {[N belong [O 24] 0 0 {} {} & 1]} {
				>
					emit {\bNOUNDEFS}
				<
			}
	
			if {[N belong [O 24] 0 0 {} {} & 2]} {
				>
					emit {\b|INCRLINK}
				<
			}
	
			if {[N belong [O 24] 0 0 {} {} & 4]} {
				>
					emit {\b|DYLDLINK}
				<
			}
	
			if {[N belong [O 24] 0 0 {} {} & 8]} {
				>
					emit {\b|BINDATLOAD}
				<
			}
	
			if {[N belong [O 24] 0 0 {} {} & 16]} {
				>
					emit {\b|PREBOUND}
				<
			}
	
			if {[N belong [O 24] 0 0 {} {} & 32]} {
				>
					emit {\b|SPLIT_SEGS}
				<
			}
	
			if {[N belong [O 24] 0 0 {} {} & 64]} {
				>
					emit {\b|LAZY_INIT}
				<
			}
	
			if {[N belong [O 24] 0 0 {} {} & 128]} {
				>
					emit {\b|TWOLEVEL}
				<
			}
	
			if {[N belong [O 24] 0 0 {} {} & 256]} {
				>
					emit {\b|FORCE_FLAT}
				<
			}
	
			if {[N belong [O 24] 0 0 {} {} & 512]} {
				>
					emit {\b|NOMULTIDEFS}
				<
			}
	
			if {[N belong [O 24] 0 0 {} {} & 1024]} {
				>
					emit {\b|NOFIXPREBINDING}
				<
			}
	
			if {[N belong [O 24] 0 0 {} {} & 2048]} {
				>
					emit {\b|PREBINDABLE}
				<
			}
	
			if {[N belong [O 24] 0 0 {} {} & 4096]} {
				>
					emit {\b|ALLMODSBOUND}
				<
			}
	
			if {[N belong [O 24] 0 0 {} {} & 8192]} {
				>
					emit {\b|SUBSECTIONS_VIA_SYMBOLS}
				<
			}
	
			if {[N belong [O 24] 0 0 {} {} & 16384]} {
				>
					emit {\b|CANONICAL}
				<
			}
	
			if {[N belong [O 24] 0 0 {} {} & 32768]} {
				>
					emit {\b|WEAK_DEFINES}
				<
			}
	
			if {[N belong [O 24] 0 0 {} {} & 65536]} {
				>
					emit {\b|BINDS_TO_WEAK}
				<
			}
	
			if {[N belong [O 24] 0 0 {} {} & 131072]} {
				>
					emit {\b|ALLOW_STACK_EXECUTION}
				<
			}
	
			if {[N belong [O 24] 0 0 {} {} & 262144]} {
				>
					emit {\b|ROOT_SAFE}
				<
			}
	
			if {[N belong [O 24] 0 0 {} {} & 524288]} {
				>
					emit {\b|SETUID_SAFE}
				<
			}
	
			if {[N belong [O 24] 0 0 {} {} & 1048576]} {
				>
					emit {\b|NO_REEXPORTED_DYLIBS}
				<
			}
	
			if {[N belong [O 24] 0 0 {} {} & 2097152]} {
				>
					emit {\b|PIE}
				<
			}
	
			if {[N belong [O 24] 0 0 {} {} & 4194304]} {
				>
					emit {\b|DEAD_STRIPPABLE_DYLIB}
				<
			}
	
			if {[N belong [O 24] 0 0 {} {} & 8388608]} {
				>
					emit {\b|HAS_TLV_DESCRIPTORS}
				<
			}
	
			if {[N belong [O 24] 0 0 {} {} & 16777216]} {
				>
					emit {\b|NO_HEAP_EXECUTION}
				<
			}
	
			if {[N belong [O 24] 0 0 {} {} & 33554432]} {
				>
					emit {\b|APP_EXTENSION_SAFE}
				<
			}
	
			if {[N belong [O 24] 0 0 {} {} x {}]} {
				>
					emit {\b>}
				<
			}
	
		<
	}
	}}
	136
		{mac-bin {if {[N ubyte [O 122] 0 0 {} {} x {}]} {
		>
			emit MacBinary
		<
	}
	
	switch [Nv ubyte [O 122] 0 {} {}] {
		129 {
			>
				emit II
			<
		}
		130 {
			>
				emit III
				if {[S string [O 102] 0 {} {} ne mBIN]} {
					>
						emit {with surprising version}
						mime application/x-macbinary
						ext bin/macbin
					<
				}
	
			<
		}
	}
	
	if {[N byte [O 73] 0 0 {} {} & 1]} {
		>
			emit {\b, inited}
		<
	}
	
	if {[N byte [O 73] 0 0 {} {} & 2]} {
		>
			emit {\b, changed}
		<
	}
	
	if {[N byte [O 73] 0 0 {} {} & 4]} {
		>
			emit {\b, busy}
		<
	}
	
	if {[N byte [O 73] 0 0 {} {} & 8]} {
		>
			emit {\b, bozo}
		<
	}
	
	if {[N byte [O 73] 0 0 {} {} & 16]} {
		>
			emit {\b, system}
		<
	}
	
	if {[N byte [O 73] 0 0 {} {} & 32]} {
		>
			emit {\b, bundle}
		<
	}
	
	if {[N byte [O 73] 0 0 {} {} & 64]} {
		>
			emit {\b, invisible}
		<
	}
	
	if {[N byte [O 73] 0 0 {} {} & -128]} {
		>
			emit {\b, locked}
		<
	}
	
	if {[N ubeshort [O 79] 0 0 {} {} != 0]} {
		>
			emit {\b, ID 0x%x}
		<
	}
	
	if {[N byte [O 81] 0 0 {} {} != 0]} {
		>
			emit {\b, protected 0x%x}
		<
	}
	
	if {[N ubeshort [O 99] 0 0 {} {} != 0]} {
		>
			emit {\b, comment length %u}
		<
	}
	
	if {[N ubyte [O 106] 0 0 {} {} != 0]} {
		>
			emit {\b, char. code 0x%x}
		<
	}
	
	if {[N ubyte [O 107] 0 0 {} {} != 0]} {
		>
			emit {\b, more flags 0x%x}
		<
	}
	
	if {[N ubelong [O 116] 0 0 {} {} != 0]} {
		>
			emit {\b, total length %u}
		<
	}
	
	if {[N ubeshort [O 120] 0 0 {} {} != 0]} {
		>
			emit {\b, 2nd header length %u}
		<
	}
	
	if {[N beldate [O 91] 0 0 - 2082844800 x {}]} {
		>
			emit {\b, %s}
		<
	}
	
	if {[N ubelong [O 91] 0 0 {} {} < 2082844800]} {
		>
			emit {INVALID date}
		<
	}
	
	if {[N beldate [O 95] 0 0 - 2082844800 x {}]} {
		>
			emit {\b, modified %s}
		<
	}
	
	if {[N ulong [O 69] 0 0 {} {} != 0]} {
		>
			emit {\b, creator}
			U 136 apple-creator [O 69]
	
		<
	}
	
	if {[N ulong [O 65] 0 0 {} {} != 0]} {
		>
			emit {\b, type}
			U 136 apple-type [O 65]
	
		<
	}
	
	if {[N ubelong [O 83] 0 0 {} {} != 0]} {
		>
			emit {\b, %u bytes}
		<
	}
	
	if {[S pstring [O 1] 0 {} {} x {}]} {
		>
			emit {"%s"}
		<
	}
	
	if {[N ubelong [O 83] 0 0 {} {} != 0]} {
		>
			emit {\b }
			T [O 128] {}
	
		<
	}
	
	if {[N ubelong [O 87] 0 0 {} {} != 0]} {
		>
			if {[N ubelong [O 83] 0 0 + 128 x {}]} {
				>
					emit {\b, at 0x%x}
				<
			}
	
			if {[N ubelong [O 87] 0 0 {} {} != 0]} {
				>
					emit {%u bytes}
				<
			}
	
			if {[N ubequad [O [I 83 ubeshort 0 + 0 128]] 0 0 {} {} x {}]} {
				>
					emit {resource }
					T [R [O -8]] {}
	
				<
			}
	
		<
	}
	} apple-type {if {[S string [O 0] 0 {} {} eq 8BIM]} {
		>
			emit PhotoShop
		<
	}
	
	if {[S string [O 0] 0 {} {} eq ALB3]} {
		>
			emit {PageMaker 3}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq ALB4]} {
		>
			emit {PageMaker 4}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq ALT3]} {
		>
			emit {PageMaker 3}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq APPL]} {
		>
			emit application
		<
	}
	
	if {[S string [O 0] 0 {} {} eq AWWP]} {
		>
			emit {AppleWorks word processor}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq CIRC]} {
		>
			emit {simulated circuit}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq DRWG]} {
		>
			emit MacDraw
		<
	}
	
	if {[S string [O 0] 0 {} {} eq EPSF]} {
		>
			emit {Encapsulated PostScript}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq FFIL]} {
		>
			emit {font suitcase}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq FKEY]} {
		>
			emit {function key}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq FNDR]} {
		>
			emit {Macintosh Finder}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq GIFf]} {
		>
			emit {GIF image}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq Gzip]} {
		>
			emit {GNU gzip}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq INIT]} {
		>
			emit {system extension}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq LIB\ ]} {
		>
			emit library
		<
	}
	
	if {[S string [O 0] 0 {} {} eq LWFN]} {
		>
			emit {PostScript font}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq MSBC]} {
		>
			emit {Microsoft BASIC}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq PACT]} {
		>
			emit {Compact Pro archive}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq PDF\ ]} {
		>
			emit {Portable Document Format}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq PICT]} {
		>
			emit picture
		<
	}
	
	if {[S string [O 0] 0 {} {} eq PNTG]} {
		>
			emit {MacPaint picture}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq PREF]} {
		>
			emit preferences
		<
	}
	
	if {[S string [O 0] 0 {} {} eq PROJ]} {
		>
			emit {Think C project}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq QPRJ]} {
		>
			emit {Think Pascal project}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq SCFL]} {
		>
			emit {Defender scores}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq SCRN]} {
		>
			emit {startup screen}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq SITD]} {
		>
			emit {StuffIt Deluxe}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq SPn3]} {
		>
			emit SuperPaint
		<
	}
	
	if {[S string [O 0] 0 {} {} eq STAK]} {
		>
			emit {HyperCard stack}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq Seg\ ]} {
		>
			emit {StuffIt segment}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq TARF]} {
		>
			emit {Unix tar archive}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq TEXT]} {
		>
			emit ASCII
		<
	}
	
	if {[S string [O 0] 0 {} {} eq TIFF]} {
		>
			emit {TIFF image}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq TOVF]} {
		>
			emit {Eudora table of contents}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq WDBN]} {
		>
			emit {Microsoft Word word processor}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq WORD]} {
		>
			emit {MacWrite word processor}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq XLS\ ]} {
		>
			emit {Microsoft Excel}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq ZIVM]} {
		>
			emit {compress (.Z)}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq ZSYS]} {
		>
			emit {Pre-System 7 system file}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq acf3]} {
		>
			emit {Aldus FreeHand}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq cdev]} {
		>
			emit {control panel}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq dfil]} {
		>
			emit {Desk Accessory suitcase}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq libr]} {
		>
			emit library
		<
	}
	
	if {[S string [O 0] 0 {} {} eq nX^d]} {
		>
			emit {WriteNow word processor}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq nX^w]} {
		>
			emit {WriteNow dictionary}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq rsrc]} {
		>
			emit resource
		<
	}
	
	if {[S string [O 0] 0 {} {} eq scbk]} {
		>
			emit Scrapbook
		<
	}
	
	if {[S string [O 0] 0 {} {} eq shlb]} {
		>
			emit {shared library}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq ttro]} {
		>
			emit {SimpleText read-only}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq zsys]} {
		>
			emit {system file}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq BINA]} {
		>
			emit {binary file}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq BMPp]} {
		>
			emit {BMP image}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq JPEG]} {
		>
			emit {JPEG image}
		<
	}
	
	if {[D [O 0]]} {
		>
			if {[S string [O 0] 0 {} {} x {}]} {
				>
					emit '%4.4s'
				<
			}
	
		<
	}
	} apple-creator {if {[S string [O 0] 0 {} {} eq 8BIM]} {
		>
			emit {Adobe Photoshop}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq ALD3]} {
		>
			emit {PageMaker 3}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq ALD4]} {
		>
			emit {PageMaker 4}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq ALFA]} {
		>
			emit {Alpha editor}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq APLS]} {
		>
			emit {Apple Scanner}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq APSC]} {
		>
			emit {Apple Scanner}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq BRKL]} {
		>
			emit Brickles
		<
	}
	
	if {[S string [O 0] 0 {} {} eq BTFT]} {
		>
			emit BitFont
		<
	}
	
	if {[S string [O 0] 0 {} {} eq CCL2]} {
		>
			emit {Common Lisp 2}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq CCL\ ]} {
		>
			emit {Common Lisp}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq CDmo]} {
		>
			emit {The Talking Moose}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq CPCT]} {
		>
			emit {Compact Pro}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq CSOm]} {
		>
			emit Eudora
		<
	}
	
	if {[S string [O 0] 0 {} {} eq DMOV]} {
		>
			emit {Font/DA Mover}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq DSIM]} {
		>
			emit DigSim
		<
	}
	
	if {[S string [O 0] 0 {} {} eq EDIT]} {
		>
			emit {Macintosh Edit}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq ERIK]} {
		>
			emit {Macintosh Finder}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq EXTR]} {
		>
			emit {self-extracting archive}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq Gzip]} {
		>
			emit {GNU gzip}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq KAHL]} {
		>
			emit {Think C}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq LWFU]} {
		>
			emit {LaserWriter Utility}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq LZIV]} {
		>
			emit compress
		<
	}
	
	if {[S string [O 0] 0 {} {} eq MACA]} {
		>
			emit MacWrite
		<
	}
	
	if {[S string [O 0] 0 {} {} eq MACS]} {
		>
			emit {Macintosh operating system}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq MAcK]} {
		>
			emit {MacKnowledge terminal emulator}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq MLND]} {
		>
			emit Defender
		<
	}
	
	if {[S string [O 0] 0 {} {} eq MPNT]} {
		>
			emit MacPaint
		<
	}
	
	if {[S string [O 0] 0 {} {} eq MSBB]} {
		>
			emit {Microsoft BASIC (binary)}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq MSWD]} {
		>
			emit {Microsoft Word}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq NCSA]} {
		>
			emit {NCSA Telnet}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq PJMM]} {
		>
			emit {Think Pascal}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq PSAL]} {
		>
			emit {Hunt the Wumpus}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq R*ch]} {
		>
			emit BBEdit
		<
	}
	
	if {[S string [O 0] 0 {} {} eq RMKR]} {
		>
			emit {Resource Maker}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq RSED]} {
		>
			emit {Resource Editor}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq Rich]} {
		>
			emit BBEdit
		<
	}
	
	if {[S string [O 0] 0 {} {} eq SIT!]} {
		>
			emit StuffIt
		<
	}
	
	if {[S string [O 0] 0 {} {} eq SPNT]} {
		>
			emit SuperPaint
		<
	}
	
	if {[S string [O 0] 0 {} {} eq Unix]} {
		>
			emit {NeXT Mac filesystem}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq VIM!]} {
		>
			emit {Vim editor}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq WILD]} {
		>
			emit HyperCard
		<
	}
	
	if {[S string [O 0] 0 {} {} eq XCEL]} {
		>
			emit {Microsoft Excel}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq aCa2]} {
		>
			emit Fontographer
		<
	}
	
	if {[S string [O 0] 0 {} {} eq aca3]} {
		>
			emit {Aldus FreeHand}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq dosa]} {
		>
			emit {Macintosh MS-DOS file system}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq movr]} {
		>
			emit {Font/DA Mover}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq nX^n]} {
		>
			emit WriteNow
		<
	}
	
	if {[S string [O 0] 0 {} {} eq pdos]} {
		>
			emit {Apple ProDOS file system}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq scbk]} {
		>
			emit Scrapbook
		<
	}
	
	if {[S string [O 0] 0 {} {} eq ttxt]} {
		>
			emit SimpleText
		<
	}
	
	if {[S string [O 0] 0 {} {} eq ufox]} {
		>
			emit {Foreign File Access}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq BOBO]} {
		>
			emit {Apple Works}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq PSPT]} {
		>
			emit {Apple File Exchange}
		<
	}
	
	if {[S string [O 0] 0 {} {} eq STi0]} {
		>
			emit stuffit
		<
	}
	
	if {[S string [O 0] 0 {} {} eq oneb]} {
		>
			emit {Disk Copy Self Mounting}
		<
	}
	
	if {[D [O 0]]} {
		>
			if {[S string [O 0] 0 {} {} x {}]} {
				>
					emit '%4.4s'
				<
			}
	
		<
	}
	}}
	148
		{diy-thermocam-parser {if {[N beshort [O 0] 0 0 {} {} x {}]} {
		>
			emit {scale %d-}
		<
	}
	
	if {[N beshort [O 2] 0 0 {} {} x {}]} {
		>
			emit {\b%d,}
		<
	}
	
	if {[N lefloat [O 4] 0 0 {} {} x {}]} {
		>
			emit {spot sensor temperature %f,}
		<
	}
	
	switch [Nv ubyte [O 9] 0 {} {}] {
		0 {
			>
				emit {unit celsius,}
			<
		}
		1 {
			>
				emit {unit fahrenheit,}
			<
		}
	}
	
	if {[N ubyte [O 8] 0 0 {} {} x {}]} {
		>
			emit {color scheme %d}
		<
	}
	
	if {[N ubyte [O 10] 0 0 {} {} == 1]} {
		>
			emit {\b, show spot sensor}
		<
	}
	
	if {[N ubyte [O 11] 0 0 {} {} == 1]} {
		>
			emit {\b, show scale bar}
		<
	}
	
	if {[N ubyte [O 12] 0 0 {} {} & 1]} {
		>
			emit {\b, minimum point enabled}
		<
	}
	
	if {[N ubyte [O 12] 0 0 {} {} & 2]} {
		>
			emit {\b, maximum point enabled}
		<
	}
	
	if {[N lefloat [O 13] 0 0 {} {} x {}]} {
		>
			emit {\b, calibration: offset %f,}
		<
	}
	
	if {[N lefloat [O 17] 0 0 {} {} x {}]} {
		>
			emit {slope %f}
		<
	}
	} diy-thermocam-checker {if {[N ubyte [O 9] 0 0 {} {} < 2]} {
		>
			if {[N ubyte [O 10] 0 0 {} {} < 2]} {
				>
					if {[N ubyte [O 11] 0 0 {} {} < 2]} {
						>
							if {[N ubyte [O 12] 0 0 {} {} < 4]} {
								>
									if {[N lefloat [O 17] 0 0 {} {} > 9.999999747378752e-5]} {
										>
											emit {DIY-Thermocam raw data}
										<
									}
	
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	}}
	163
		{msdos-driver {if {[S search [O 40] 0 {} 7 eq UPX!]} {
		>
			emit {\bUPX compressed}
		<
	}
	
	switch [Nv uleshort [O 4] 0 & 32768] {
		0 {
			>
				emit {\bblock device driver}
			<
			>
				if {[N uleshort [O 4] 0 0 & 2 == 2]} {
					>
						emit {\b,32-bit sector-}
					<
				}
	
			<
			>
				if {[N uleshort [O 4] 0 0 & 18498 > 0]} {
					>
						emit {\bsupport}
					<
				}
	
			<
		}
		32768 {
			>
				emit {\b}
				if {[N uleshort [O 4] 0 0 & 8 == 8]} {
					>
						emit {\bclock}
					<
				}
	
				if {[N uleshort [O 4] 0 0 & 16 == 16]} {
					>
						emit {\bfast}
					<
				}
	
				if {[N uleshort [O 4] 0 0 & 3 > 0]} {
					>
						emit {\bstandard}
						if {[N uleshort [O 4] 0 0 & 1 == 1]} {
							>
								emit {\binput}
							<
						}
	
						if {[N uleshort [O 4] 0 0 & 3 == 3]} {
							>
								emit {\b/}
							<
						}
	
						if {[N uleshort [O 4] 0 0 & 2 == 2]} {
							>
								emit {\boutput}
							<
						}
	
					<
				}
	
				if {[N uleshort [O 4] 0 0 & 32768 == 32768]} {
					>
						emit {\bcharacter device driver}
					<
				}
	
			<
			>
				if {[N uleshort [O 4] 0 0 & 8192 == 8192]} {
					>
						emit {\b,until busy-}
					<
				}
	
			<
			>
				if {[N uleshort [O 4] 0 0 & 26688 > 0]} {
					>
						emit {\bsupport}
					<
				}
	
			<
		}
	}
	
	if {[N ubyte [O 0] 0 0 {} {} x {}]} {
		>
			if {[S search [O 40] 0 {} 7 eq UPX!]} {
				>
				<
			}
	
			if {[D [O 40]]} {
				>
					if {[N ubyte [O 12] 0 0 {} {} > 46]} {
						>
							emit {\b}
							if {[N ubyte [O 10] 0 0 {} {} > 32]} {
								>
									if {[N ubyte [O 10] 0 0 {} {} != 46]} {
										>
											if {[N ubyte [O 10] 0 0 {} {} != 42]} {
												>
													emit {\b%c}
												<
											}
	
										<
									}
	
								<
							}
	
							if {[N ubyte [O 11] 0 0 {} {} > 32]} {
								>
									if {[N ubyte [O 11] 0 0 {} {} != 46]} {
										>
											emit {\b%c}
										<
									}
	
								<
							}
	
							if {[N ubyte [O 12] 0 0 {} {} > 32]} {
								>
									if {[N ubyte [O 12] 0 0 {} {} != 57]} {
										>
											if {[N ubyte [O 12] 0 0 {} {} != 46]} {
												>
													emit {\b%c}
												<
											}
	
										<
									}
	
								<
							}
	
						<
					}
	
					if {[N ubyte [O 13] 0 0 {} {} > 32]} {
						>
							if {[N ubyte [O 13] 0 0 {} {} != 46]} {
								>
									emit {\b%c}
								<
							}
	
							if {[N ubyte [O 14] 0 0 {} {} > 32]} {
								>
									if {[N ubyte [O 14] 0 0 {} {} != 46]} {
										>
											emit {\b%c}
										<
									}
	
								<
							}
	
							if {[N ubyte [O 15] 0 0 {} {} > 32]} {
								>
									if {[N ubyte [O 15] 0 0 {} {} != 46]} {
										>
											emit {\b%c}
										<
									}
	
								<
							}
	
							if {[N ubyte [O 16] 0 0 {} {} > 32]} {
								>
									if {[N ubyte [O 16] 0 0 {} {} != 46]} {
										>
											if {[N ubyte [O 16] 0 0 {} {} < 203]} {
												>
													emit {\b%c}
												<
											}
	
										<
									}
	
								<
							}
	
							if {[N ubyte [O 17] 0 0 {} {} > 32]} {
								>
									if {[N ubyte [O 17] 0 0 {} {} != 46]} {
										>
											if {[N ubyte [O 17] 0 0 {} {} < 144]} {
												>
													emit {\b%c}
												<
											}
	
										<
									}
	
								<
							}
	
						<
					}
	
					if {[N ubyte [O 12] 0 0 {} {} < 47]} {
						>
							if {[S string [O 22] 0 {} {} > \056]} {
								>
									emit %-.6s
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[N uleshort [O 4] 0 0 & 64 == 64]} {
		>
			emit {\b,IOCTL-}
		<
	}
	
	if {[N uleshort [O 4] 0 0 & 2048 == 2048]} {
		>
			emit {\b,close media-}
		<
	}
	
	if {[N uleshort [O 4] 0 0 & 16384 == 16384]} {
		>
			emit {\b,control strings-}
		<
	}
	
	if {[N ubyte [O 0] 0 0 {} {} x {}]} {
		>
			emit {\b)}
		<
	}
	} msdos-com {if {[N byte [O 0] 0 0 {} {} x {}]} {
		>
			emit {DOS executable (COM)}
		<
	}
	
	if {[S string [O 6] 0 {} {} eq SFX\ of\ LHarc]} {
		>
			emit {\b, %s}
		<
	}
	
	if {[N leshort [O 510] 0 0 {} {} == -21931]} {
		>
			emit {\b, boot code}
		<
	}
	
	if {[S string [O 85] 0 {} {} eq UPX]} {
		>
			emit {\b, UPX compressed}
		<
	}
	
	if {[S string [O 4] 0 {} {} eq \ \$ARX]} {
		>
			emit {\b, ARX self-extracting archive}
		<
	}
	
	if {[S string [O 4] 0 {} {} eq \ \$LHarc]} {
		>
			emit {\b, LHarc self-extracting archive}
		<
	}
	
	if {[S string [O 526] 0 {} {} eq SFX\ by\ LARC]} {
		>
			emit {\b, LARC self-extracting archive}
		<
	}
	} lotus-cells {if {[N ubelong [O 0] 0 0 {} {} == 100665344]} {
		>
			emit {\b, cell range}
			if {[N ulong [O 4] 0 0 {} {} != 0]} {
				>
					if {[N uleshort [O 4] 0 0 {} {} x {}]} {
						>
							emit {\b%d,}
						<
					}
	
					if {[N uleshort [O 6] 0 0 {} {} x {}]} {
						>
							emit {\b%d-}
						<
					}
	
				<
			}
	
			if {[N uleshort [O 8] 0 0 {} {} x {}]} {
				>
					emit {\b%d,}
				<
			}
	
			if {[N uleshort [O 10] 0 0 {} {} x {}]} {
				>
					emit {\b%d}
				<
			}
	
		<
	}
	} cur-ico-dir {if {[N ulelong [O 18] 0 0 {} {} & 6]} {
		>
			if {[N ulelong [O [I 18 ulelong 0 + 0 0]] 0 0 {} {} x {}]} {
				>
					emit {MS Windows}
					switch [Nv ubelong [O 0] 0 {} {}] {
						256 {
							>
								emit {icon resource}
								mime image/x-icon
								ext ico
								if {[N uleshort [O 4] 0 0 {} {} x {}]} {
									>
										emit {- %d icon}
									<
								}
	
								if {[N uleshort [O 4] 0 0 {} {} > 1]} {
									>
										emit {\bs}
									<
								}
	
								U 163 ico-entry [O 6]
	
								if {[N uleshort [O 4] 0 0 {} {} > 1]} {
									>
										U 163 ico-entry [O 22]
	
									<
								}
	
							<
						}
						512 {
							>
								emit {cursor resource}
								mime image/x-win-bitmap
								ext cur
								if {[N uleshort [O 4] 0 0 {} {} x {}]} {
									>
										emit {- %d icon}
									<
								}
	
								if {[N uleshort [O 4] 0 0 {} {} > 1]} {
									>
										emit {\bs}
									<
								}
	
								U 163 cur-entry [O 6]
	
							<
						}
					}
	
				<
			}
	
		<
	}
	} cur-entry {U 163 cur-ico-entry [O 0]
	
	if {[N uleshort [O 4] 0 0 {} {} x {}]} {
		>
			emit {\b, hotspot @%dx}
		<
	}
	
	if {[N uleshort [O 6] 0 0 {} {} x {}]} {
		>
			emit {\b%d}
		<
	}
	} ico-entry {U 163 cur-ico-entry [O 0]
	
	if {[N uleshort [O 4] 0 0 {} {} > 1]} {
		>
			emit {\b, %d planes}
		<
	}
	
	if {[N uleshort [O 6] 0 0 {} {} > 1]} {
		>
			emit {\b, %d bits/pixel}
		<
	}
	} cur-ico-entry {if {[N byte [O 0] 0 0 {} {} == 0]} {
		>
			emit {\b, 256x}
		<
	}
	
	if {[N byte [O 0] 0 0 {} {} != 0]} {
		>
			emit {\b, %dx}
		<
	}
	
	if {[N byte [O 1] 0 0 {} {} == 0]} {
		>
			emit {\b256}
		<
	}
	
	if {[N byte [O 1] 0 0 {} {} != 0]} {
		>
			emit {\b%d}
		<
	}
	
	if {[N ubyte [O 2] 0 0 {} {} != 0]} {
		>
			emit {\b, %d colors}
		<
	}
	
	if {[N ubelong [O [I 12 ulelong 0 + 0 0]] 0 0 {} {} == 2303741511]} {
		>
			emit {\b with}
			T [R [O -4]] {}
	
		<
	}
	
	if {[N ubelong [O [I 12 ulelong 0 + 0 0]] 0 0 {} {} != 2303741511]} {
		>
		<
	}
	} cab-anchor {if {[S string [R [O 0]] 0 {} {} x {}]} {
		>
			emit %s
			if {[S string [R [O 1]] 0 {} {} x {}]} {
				>
					emit {disk %s}
				<
			}
	
		<
	}
	} cab-folder {if {[N uleshort [O 4] 0 0 {} {} x {}]} {
		>
			emit {\b, %u datablock}
		<
	}
	
	if {[N uleshort [O 4] 0 0 {} {} > 1]} {
		>
			emit {\bs}
		<
	}
	
	if {[N uleshort [O 6] 0 0 {} {} x {}]} {
		>
			emit {\b, 0x%x compression}
		<
	}
	} cab-file {if {[N uleshort [O 8] 0 0 {} {} > 0]} {
		>
			emit {\b, iFolder 0x%x}
		<
	}
	
	if {[N uleshort [O 14] 0 0 {} {} > 0]} {
		>
			emit +
			if {[N uleshort [O 14] 0 0 {} {} & 1]} {
				>
					emit {\bR}
				<
			}
	
			if {[N uleshort [O 14] 0 0 {} {} & 2]} {
				>
					emit {\bH}
				<
			}
	
			if {[N uleshort [O 14] 0 0 {} {} & 4]} {
				>
					emit {\bS}
				<
			}
	
			if {[N uleshort [O 14] 0 0 {} {} & 32]} {
				>
					emit {\bA}
				<
			}
	
			if {[N uleshort [O 14] 0 0 {} {} & 64]} {
				>
					emit {\bX}
				<
			}
	
			if {[N uleshort [O 14] 0 0 {} {} & 128]} {
				>
					emit {\bUtf}
				<
			}
	
			if {[N uleshort [O 14] 0 0 {} {} & 256]} {
				>
					emit {\b?}
				<
			}
	
		<
	}
	
	if {[S string [O 16] 0 {} {} x {}]} {
		>
			emit {"%s"}
		<
	}
	}}
	164
		{msooxml {if {[S string [O 0] 0 {} {} eq word/]} {
		>
			emit {Microsoft Word 2007+}
			mime application/vnd.openxmlformats-officedocument.wordprocessingml.document
		<
	}
	
	if {[S string [O 0] 0 {} {} eq ppt/]} {
		>
			emit {Microsoft PowerPoint 2007+}
			mime application/vnd.openxmlformats-officedocument.presentationml.presentation
		<
	}
	
	if {[S string [O 0] 0 {} {} eq xl/]} {
		>
			emit {Microsoft Excel 2007+}
			mime application/vnd.openxmlformats-officedocument.spreadsheetml.sheet
		<
	}
	}}
	173
		{ktrace {if {[N leshort [O 4] 0 0 {} {} == 7]} {
		>
			if {[N leshort [O 6] 0 0 {} {} < 3]} {
				>
					emit {NetBSD ktrace file version %d}
					if {[S string [O 12] 0 {} {} x {}]} {
						>
							emit {from %s}
						<
					}
	
					if {[S string [O 56] 0 {} {} x {}]} {
						>
							emit {\b, emulation %s}
						<
					}
	
					if {[N lelong [O 8] 0 0 {} {} < 65536]} {
						>
							emit {\b, pid=%d}
						<
					}
	
				<
			}
	
		<
	}
	}}
	187
		{aportisdoc {if {[N beshort [O [I 78 ubelong 0 + 0 0]] 0 0 {} {} == 1]} {
		>
			emit {\b, uncompressed}
		<
	}
	
	if {[N beshort [O [I 78 ubelong 0 + 0 0]] 0 0 {} {} > 1]} {
		>
			if {[N belong [O [I 78 ubelong 0 + 0 4]] 0 0 {} {} x {}]} {
				>
					emit {\b, %d bytes uncompressed}
				<
			}
	
		<
	}
	}}
	199
		{pgp {switch [Nv byte [O 0] 0 {} {}] {
		48 {
			>
				switch [Nv byte [O 1] 0 & -64] {
					-128 {
						>
							emit {Sym. Encrypted and Integrity Protected Data}
						<
					}
					-64 {
						>
							emit {Modification Detection Code}
						<
					}
					0 {
						>
							emit {Unused [0%x]}
						<
					}
					64 {
						>
							emit {User Attribute}
						<
					}
				}
	
			<
		}
		103 {
			>
				emit {Reserved (old)}
			<
		}
		104 {
			>
				emit {Public-Key Encrypted Session Key (old)}
			<
		}
		105 {
			>
				emit {Signature (old)}
			<
		}
		106 {
			>
				emit {Symmetric-Key Encrypted Session Key (old)}
			<
		}
		107 {
			>
				emit {One-Pass Signature (old)}
			<
		}
		108 {
			>
				emit {Secret-Key (old)}
			<
		}
		109 {
			>
				emit {Public-Key (old)}
			<
		}
		110 {
			>
				emit {Secret-Subkey (old)}
			<
		}
		111 {
			>
				emit {Compressed Data (old)}
			<
		}
		112 {
			>
				emit {Symmetrically Encrypted Data (old)}
			<
		}
		113 {
			>
				emit {Marker (old)}
			<
		}
		114 {
			>
				emit {Literal Data (old)}
			<
		}
		115 {
			>
				emit {Trust (old)}
			<
		}
		116 {
			>
				emit {User ID (old)}
			<
		}
		117 {
			>
				emit {Public-Subkey (old)}
			<
		}
		118 {
			>
				emit {Unused (old)}
			<
		}
		119 {
			>
				switch [Nv byte [O 1] 0 & -64] {
					-128 {
						>
							emit Signature
						<
					}
					-64 {
						>
							emit {Symmetric-Key Encrypted Session Key}
						<
					}
					0 {
						>
							emit Reserved
						<
					}
					64 {
						>
							emit {Public-Key Encrypted Session Key}
						<
					}
				}
	
			<
		}
		120 {
			>
				switch [Nv byte [O 1] 0 & -64] {
					-128 {
						>
							emit Public-Key
						<
					}
					-64 {
						>
							emit Secret-Subkey
						<
					}
					0 {
						>
							emit {One-Pass Signature}
						<
					}
					64 {
						>
							emit Secret-Key
						<
					}
				}
	
			<
		}
		121 {
			>
				switch [Nv byte [O 1] 0 & -64] {
					-128 {
						>
							emit Marker
						<
					}
					-64 {
						>
							emit {Literal Data}
						<
					}
					0 {
						>
							emit {Compressed Data}
						<
					}
					64 {
						>
							emit {Symmetrically Encrypted Data}
						<
					}
				}
	
			<
		}
		122 {
			>
				switch [Nv byte [O 1] 0 & -64] {
					-128 {
						>
							emit Public-Subkey
						<
					}
					-64 {
						>
							emit {Unused [z%x]}
						<
					}
					0 {
						>
							emit Trust
						<
					}
					64 {
						>
							emit {User ID}
						<
					}
				}
	
			<
		}
	}
	} crypto {switch [Nv byte [O 0] 0 {} {}] {
		0 {
			>
				emit {Plaintext or unencrypted data}
			<
		}
		1 {
			>
				emit IDEA
			<
		}
		2 {
			>
				emit TripleDES
			<
		}
		3 {
			>
				emit {CAST5 (128 bit key)}
			<
		}
		4 {
			>
				emit {Blowfish (128 bit key, 16 rounds)}
			<
		}
		7 {
			>
				emit {AES with 128-bit key}
			<
		}
		8 {
			>
				emit {AES with 192-bit key}
			<
		}
		9 {
			>
				emit {AES with 256-bit key}
			<
		}
		10 {
			>
				emit {Twofish with 256-bit key}
			<
		}
	}
	} hash {switch [Nv byte [O 0] 0 {} {}] {
		1 {
			>
				emit MD5
			<
		}
		2 {
			>
				emit SHA-1
			<
		}
		3 {
			>
				emit RIPE-MD/160
			<
		}
		8 {
			>
				emit SHA256
			<
		}
		9 {
			>
				emit SHA384
			<
		}
		10 {
			>
				emit SHA512
			<
		}
		11 {
			>
				emit SHA224
			<
		}
	}
	} key_algo {switch [Nv byte [O 0] 0 {} {}] {
		1 {
			>
				emit {RSA (Encrypt or Sign)}
			<
		}
		2 {
			>
				emit {RSA Encrypt-Only}
			<
		}
		3 {
			>
				emit {RSA (Sign-Only)}
			<
		}
		16 {
			>
				emit {ElGamal (Encrypt-Only)}
			<
		}
		17 {
			>
				emit DSA
			<
		}
		18 {
			>
				emit {Elliptic Curve}
			<
		}
		19 {
			>
				emit ECDSA
			<
		}
		20 {
			>
				emit {ElGamal (Encrypt or Sign)}
			<
		}
		21 {
			>
				emit Diffie-Hellman
			<
		}
	}
	
	if {[D [O 0]]} {
		>
			if {[N ubyte [O 0] 0 0 {} {} < 22]} {
				>
					emit {unknown (pub %d)}
				<
			}
	
			if {[N ubyte [O 0] 0 0 {} {} > 21]} {
				>
					emit {invalid (%d)}
				<
			}
	
		<
	}
	} chkcrypto {U 199 crypto [O 0]
	
	switch [Nv byte [O 1] 0 {} {}] {
		0 {
			>
				emit {Simple S2K}
			<
		}
		1 {
			>
				emit {Salted S2K}
			<
		}
		3 {
			>
				emit {Salted&Iterated S2K}
			<
		}
	}
	
	U 199 hash [O 2]
	} keyprolog {if {[N byte [O 0] 0 0 {} {} == 4]} {
		>
		<
	}
	
	if {[N beldate [O 1] 0 0 {} {} x {}]} {
		>
			emit {created on %s -}
		<
	}
	
	switch [Nv byte [O 5] 0 {} {}] {
		1 {
			>
				emit {RSA (Encrypt or Sign)}
			<
		}
		2 {
			>
				emit {RSA Encrypt-Only}
			<
		}
	}
	} keyend {if {[S string [O 0] 0 {} {} eq \x00\x11\x01\x00\x01]} {
		>
			emit e=65537
		<
	}
	
	U 199 crypto [O 5]
	
	switch [Nv byte [O 5] 0 {} {}] {
		-2 {
			>
				emit hashed
				U 199 chkcrypto [O 6]
	
			<
		}
		-1 {
			>
				emit checksummed
				U 199 chkcrypto [O 6]
	
			<
		}
	}
	} x1024 {U 199 keyprolog [O 0]
	
	if {[S string [O 6] 0 {} {} eq \x03\xfe]} {
		>
		<
	}
	
	if {[S string [O 6] 0 {} {} eq \x03\xff]} {
		>
		<
	}
	
	if {[S string [O 6] 0 {} {} eq \x04\x00]} {
		>
		<
	}
	
	U 199 keyend [O 136]
	} x2048 {U 199 keyprolog [O 0]
	
	if {[S string [O 6] 0 {} {} eq \x80\x00]} {
		>
		<
	}
	
	if {[S string [O 6] 0 {} {} eq \x07\xfe]} {
		>
		<
	}
	
	if {[S string [O 6] 0 {} {} eq \x07\xff]} {
		>
		<
	}
	
	U 199 keyend [O 264]
	} x3072 {U 199 keyprolog [O 0]
	
	if {[S string [O 6] 0 {} {} eq \x0b\xfe]} {
		>
		<
	}
	
	if {[S string [O 6] 0 {} {} eq \x0b\xff]} {
		>
		<
	}
	
	if {[S string [O 6] 0 {} {} eq \x0c\x00]} {
		>
		<
	}
	
	U 199 keyend [O 392]
	} x4096 {U 199 keyprolog [O 0]
	
	if {[S string [O 6] 0 {} {} eq \x10\x00]} {
		>
		<
	}
	
	if {[S string [O 6] 0 {} {} eq \x0f\xfe]} {
		>
		<
	}
	
	if {[S string [O 6] 0 {} {} eq \x0f\xff]} {
		>
		<
	}
	
	U 199 keyend [O 520]
	} pgpkey {} x8192 {U 199 keyprolog [O 0]
	
	if {[S string [O 6] 0 {} {} eq \x20\x00]} {
		>
		<
	}
	
	if {[S string [O 6] 0 {} {} eq \x1f\xfe]} {
		>
		<
	}
	
	if {[S string [O 6] 0 {} {} eq \x1f\xff]} {
		>
		<
	}
	
	U 199 keyend [O 1032]
	
	
	if {[S string [O 0] 0 {} {} eq \x01\xd8]} {
		>
			emit 1024b
			U 199 x1024 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x01\xeb]} {
		>
			emit 1024b
			U 199 x1024 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x01\xfb]} {
		>
			emit 1024b
			U 199 x1024 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x01\xfd]} {
		>
			emit 1024b
			U 199 x1024 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x01\xf3]} {
		>
			emit 1024b
			U 199 x1024 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x01\xee]} {
		>
			emit 1024b
			U 199 x1024 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x01\xfe]} {
		>
			emit 1024b
			U 199 x1024 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x01\xf4]} {
		>
			emit 1024b
			U 199 x1024 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x02\x0d]} {
		>
			emit 1024b
			U 199 x1024 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x02\x03]} {
		>
			emit 1024b
			U 199 x1024 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x02\x05]} {
		>
			emit 1024b
			U 199 x1024 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x02\x15]} {
		>
			emit 1024b
			U 199 x1024 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x02\x00]} {
		>
			emit 1024b
			U 199 x1024 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x02\x10]} {
		>
			emit 1024b
			U 199 x1024 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x02\x04]} {
		>
			emit 1024b
			U 199 x1024 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x02\x06]} {
		>
			emit 1024b
			U 199 x1024 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x02\x16]} {
		>
			emit 1024b
			U 199 x1024 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x03\x98]} {
		>
			emit 2048b
			U 199 x2048 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x03\xab]} {
		>
			emit 2048b
			U 199 x2048 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x03\xbb]} {
		>
			emit 2048b
			U 199 x2048 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x03\xbd]} {
		>
			emit 2048b
			U 199 x2048 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x03\xcd]} {
		>
			emit 2048b
			U 199 x2048 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x03\xb3]} {
		>
			emit 2048b
			U 199 x2048 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x03\xc3]} {
		>
			emit 2048b
			U 199 x2048 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x03\xc5]} {
		>
			emit 2048b
			U 199 x2048 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x03\xd5]} {
		>
			emit 2048b
			U 199 x2048 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x03\xae]} {
		>
			emit 2048b
			U 199 x2048 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x03\xbe]} {
		>
			emit 2048b
			U 199 x2048 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x03\xc0]} {
		>
			emit 2048b
			U 199 x2048 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x03\xd0]} {
		>
			emit 2048b
			U 199 x2048 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x03\xb4]} {
		>
			emit 2048b
			U 199 x2048 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x03\xc4]} {
		>
			emit 2048b
			U 199 x2048 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x03\xc6]} {
		>
			emit 2048b
			U 199 x2048 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x03\xd6]} {
		>
			emit 2048b
			U 199 x2048 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x05X]} {
		>
			emit 3072b
			U 199 x3072 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x05k]} {
		>
			emit 3072b
			U 199 x3072 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x05\{]} {
		>
			emit 3072b
			U 199 x3072 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x05\}]} {
		>
			emit 3072b
			U 199 x3072 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x05\x8d]} {
		>
			emit 3072b
			U 199 x3072 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x05s]} {
		>
			emit 3072b
			U 199 x3072 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x05\x83]} {
		>
			emit 3072b
			U 199 x3072 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x05\x85]} {
		>
			emit 3072b
			U 199 x3072 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x05\x95]} {
		>
			emit 3072b
			U 199 x3072 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x05n]} {
		>
			emit 3072b
			U 199 x3072 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x05\x7e]} {
		>
			emit 3072b
			U 199 x3072 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x05\x80]} {
		>
			emit 3072b
			U 199 x3072 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x05\x90]} {
		>
			emit 3072b
			U 199 x3072 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x05t]} {
		>
			emit 3072b
			U 199 x3072 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x05\x84]} {
		>
			emit 3072b
			U 199 x3072 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x05\x86]} {
		>
			emit 3072b
			U 199 x3072 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x05\x96]} {
		>
			emit 3072b
			U 199 x3072 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x07\[]} {
		>
			emit 4096b
			U 199 x4096 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x07\x18]} {
		>
			emit 4096b
			U 199 x4096 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x07+]} {
		>
			emit 4096b
			U 199 x4096 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x07\;]} {
		>
			emit 4096b
			U 199 x4096 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x07=]} {
		>
			emit 4096b
			U 199 x4096 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x07M]} {
		>
			emit 4096b
			U 199 x4096 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x073]} {
		>
			emit 4096b
			U 199 x4096 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x07C]} {
		>
			emit 4096b
			U 199 x4096 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x07E]} {
		>
			emit 4096b
			U 199 x4096 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x07U]} {
		>
			emit 4096b
			U 199 x4096 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x07.]} {
		>
			emit 4096b
			U 199 x4096 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x07>]} {
		>
			emit 4096b
			U 199 x4096 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x07@]} {
		>
			emit 4096b
			U 199 x4096 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x07P]} {
		>
			emit 4096b
			U 199 x4096 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x074]} {
		>
			emit 4096b
			U 199 x4096 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x07D]} {
		>
			emit 4096b
			U 199 x4096 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x07F]} {
		>
			emit 4096b
			U 199 x4096 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x07V]} {
		>
			emit 4096b
			U 199 x4096 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x0e\[]} {
		>
			emit 8192b
			U 199 x8192 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x0e\x18]} {
		>
			emit 8192b
			U 199 x8192 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x0e+]} {
		>
			emit 8192b
			U 199 x8192 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x0e\;]} {
		>
			emit 8192b
			U 199 x8192 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x0e=]} {
		>
			emit 8192b
			U 199 x8192 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x0eM]} {
		>
			emit 8192b
			U 199 x8192 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x0e3]} {
		>
			emit 8192b
			U 199 x8192 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x0eC]} {
		>
			emit 8192b
			U 199 x8192 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x0eE]} {
		>
			emit 8192b
			U 199 x8192 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x0eU]} {
		>
			emit 8192b
			U 199 x8192 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x0e.]} {
		>
			emit 8192b
			U 199 x8192 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x0e>]} {
		>
			emit 8192b
			U 199 x8192 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x0e@]} {
		>
			emit 8192b
			U 199 x8192 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x0eP]} {
		>
			emit 8192b
			U 199 x8192 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x0e4]} {
		>
			emit 8192b
			U 199 x8192 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x0eD]} {
		>
			emit 8192b
			U 199 x8192 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x0eF]} {
		>
			emit 8192b
			U 199 x8192 [O 2]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq \x0eV]} {
		>
			emit 8192b
			U 199 x8192 [O 2]
	
		<
	}
	}}
	214
		{riff-wave {switch [Nv leshort [O 0] 0 {} {}] {
		1 {
			>
				emit {\b, Microsoft PCM}
				if {[N leshort [O 14] 0 0 {} {} > 0]} {
					>
						if {[N leshort [O 14] 0 0 {} {} < 1024]} {
							>
								emit {\b, %d bit}
							<
						}
	
					<
				}
	
			<
		}
		2 {
			>
				emit {\b, Microsoft ADPCM}
			<
		}
		6 {
			>
				emit {\b, ITU G.711 A-law}
			<
		}
		7 {
			>
				emit {\b, ITU G.711 mu-law}
			<
		}
		8 {
			>
				emit {\b, Microsoft DTS}
			<
		}
		17 {
			>
				emit {\b, IMA ADPCM}
			<
		}
		20 {
			>
				emit {\b, ITU G.723 ADPCM (Yamaha)}
			<
		}
		49 {
			>
				emit {\b, GSM 6.10}
			<
		}
		64 {
			>
				emit {\b, ITU G.721 ADPCM}
			<
		}
		80 {
			>
				emit {\b, MPEG}
			<
		}
		85 {
			>
				emit {\b, MPEG Layer 3}
			<
		}
		8193 {
			>
				emit {\b, DTS}
			<
		}
	}
	
	switch [Nv leshort [O 2] 0 {} {}] {
		1 {
			>
				emit {\b, mono}
			<
		}
		2 {
			>
				emit {\b, stereo}
			<
		}
	}
	
	if {[N leshort [O 2] 0 0 {} {} > 2]} {
		>
			if {[N leshort [O 2] 0 0 {} {} < 128]} {
				>
					emit {\b, %d channels}
				<
			}
	
		<
	}
	
	if {[N lelong [O 4] 0 0 {} {} > 0]} {
		>
			if {[N lelong [O 4] 0 0 {} {} < 1000000]} {
				>
					emit {%d Hz}
				<
			}
	
		<
	}
	} riff-walk {if {[S string [O 0] 0 {} {} eq fmt\x20]} {
		>
			if {[N lelong [O 4] 0 0 {} {} < 128]} {
				>
					U 214 riff-wave [O 8]
	
				<
			}
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq LIST]} {
		>
			U 214 riff-walk [R [O [I 4 ulelong 0 + 0 4]]]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq DISP]} {
		>
			U 214 riff-walk [R [O [I 4 ulelong 0 + 0 4]]]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq bext]} {
		>
			U 214 riff-walk [R [O [I 4 ulelong 0 + 0 4]]]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq Fake]} {
		>
			U 214 riff-walk [R [O [I 4 ulelong 0 + 0 4]]]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq fact]} {
		>
			U 214 riff-walk [R [O [I 4 ulelong 0 + 0 4]]]
	
		<
	}
	
	if {[S string [O 0] 0 {} {} eq VP8]} {
		>
			if {[N byte [O 11] 0 0 {} {} == -99]} {
				>
					if {[N byte [O 12] 0 0 {} {} == 1]} {
						>
							if {[N byte [O 13] 0 0 {} {} == 42]} {
								>
									emit {\b, VP8 encoding}
									if {[N leshort [O 14] 0 0 & 16383 x {}]} {
										>
											emit {\b, %d}
										<
									}
	
									if {[N leshort [O 16] 0 0 & 16383 x {}]} {
										>
											emit {\bx%d, Scaling:}
										<
									}
	
									switch [Nv leshort [O 14] 0 & -16384] {
										0 {
											>
												emit {\b [none]}
											<
											>
												emit {\bx[none]}
											<
										}
										4096 {
											>
												emit {\b [5/4]}
											<
											>
												emit {\bx[5/4]}
											<
										}
										8192 {
											>
												emit {\b [5/3]}
											<
											>
												emit {\bx[5/3]}
											<
										}
										12288 {
											>
												emit {\b [2]}
											<
											>
												emit {\bx[2]}
											<
										}
									}
	
									switch [Nv byte [O 15] 0 & -128] {
										-128 {
											>
												emit {\b, bad color specification}
											<
										}
										0 {
											>
												emit {\b, YUV color}
											<
										}
									}
	
									switch [Nv byte [O 15] 0 & 64] {
										0 {
											>
												emit {\b, decoders should clamp}
											<
										}
										64 {
											>
												emit {\b, no clamping required}
											<
										}
									}
	
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	}}
	226
		{sereal {if {[N byte [O 4] 0 0 & 15 x {}]} {
		>
			emit {(version %d,}
		<
	}
	
	switch [Nv byte [O 4] 0 & -16] {
		0 {
			>
				emit uncompressed)
			<
		}
		16 {
			>
				emit {compressed with non-incremental Snappy)}
			<
		}
		32 {
			>
				emit {compressed with incremental Snappy)}
			<
		}
	}
	
	if {[N byte [O 4] 0 0 & -16 > 32]} {
		>
			emit {unknown subformat, flag: %d>>4)}
		<
	}
	}}
	235
		{pcap-be {if {[N beshort [O 4] 0 0 {} {} x {}]} {
		>
			emit {- version %d}
		<
	}
	
	if {[N beshort [O 6] 0 0 {} {} x {}]} {
		>
			emit {\b.%d}
		<
	}
	
	switch [Nv belong [O 20] 0 {} {}] {
		0 {
			>
				emit {(No link-layer encapsulation}
			<
		}
		1 {
			>
				emit (Ethernet
			<
		}
		2 {
			>
				emit {(3Mb Ethernet}
			<
		}
		3 {
			>
				emit (AX.25
			<
		}
		4 {
			>
				emit (ProNET
			<
		}
		5 {
			>
				emit (CHAOS
			<
		}
		6 {
			>
				emit {(Token Ring}
			<
		}
		7 {
			>
				emit {(BSD ARCNET}
			<
		}
		8 {
			>
				emit (SLIP
			<
		}
		9 {
			>
				emit (PPP
			<
		}
		10 {
			>
				emit (FDDI
			<
		}
		11 {
			>
				emit {(RFC 1483 ATM}
			<
		}
		12 {
			>
				emit {(raw IP}
			<
		}
		13 {
			>
				emit {(BSD/OS SLIP}
			<
		}
		14 {
			>
				emit {(BSD/OS PPP}
			<
		}
		19 {
			>
				emit {(Linux ATM Classical IP}
			<
		}
		50 {
			>
				emit {(PPP or Cisco HDLC}
			<
		}
		51 {
			>
				emit (PPP-over-Ethernet
			<
		}
		99 {
			>
				emit {(Symantec Enterprise Firewall}
			<
		}
		100 {
			>
				emit {(RFC 1483 ATM}
			<
		}
		101 {
			>
				emit {(raw IP}
			<
		}
		102 {
			>
				emit {(BSD/OS SLIP}
			<
		}
		103 {
			>
				emit {(BSD/OS PPP}
			<
		}
		104 {
			>
				emit {(BSD/OS Cisco HDLC}
			<
		}
		105 {
			>
				emit (802.11
			<
		}
		106 {
			>
				emit {(Linux Classical IP over ATM}
			<
		}
		107 {
			>
				emit {(Frame Relay}
			<
		}
		108 {
			>
				emit {(OpenBSD loopback}
			<
		}
		109 {
			>
				emit {(OpenBSD IPsec encrypted}
			<
		}
		112 {
			>
				emit {(Cisco HDLC}
			<
		}
		113 {
			>
				emit {(Linux "cooked"}
			<
		}
		114 {
			>
				emit (LocalTalk
			<
		}
		117 {
			>
				emit {(OpenBSD PFLOG}
			<
		}
		119 {
			>
				emit {(802.11 with Prism header}
			<
		}
		122 {
			>
				emit {(RFC 2625 IP over Fibre Channel}
			<
		}
		123 {
			>
				emit (SunATM
			<
		}
		127 {
			>
				emit {(802.11 with radiotap header}
			<
		}
		129 {
			>
				emit {(Linux ARCNET}
			<
		}
		138 {
			>
				emit {(Apple IP over IEEE 1394}
			<
		}
		139 {
			>
				emit {(MTP2 with pseudo-header}
			<
		}
		140 {
			>
				emit (MTP2
			<
		}
		141 {
			>
				emit (MTP3
			<
		}
		142 {
			>
				emit (SCCP
			<
		}
		143 {
			>
				emit (DOCSIS
			<
		}
		144 {
			>
				emit (IrDA
			<
		}
		147 {
			>
				emit {(Private use 0}
			<
		}
		148 {
			>
				emit {(Private use 1}
			<
		}
		149 {
			>
				emit {(Private use 2}
			<
		}
		150 {
			>
				emit {(Private use 3}
			<
		}
		151 {
			>
				emit {(Private use 4}
			<
		}
		152 {
			>
				emit {(Private use 5}
			<
		}
		153 {
			>
				emit {(Private use 6}
			<
		}
		154 {
			>
				emit {(Private use 7}
			<
		}
		155 {
			>
				emit {(Private use 8}
			<
		}
		156 {
			>
				emit {(Private use 9}
			<
		}
		157 {
			>
				emit {(Private use 10}
			<
		}
		158 {
			>
				emit {(Private use 11}
			<
		}
		159 {
			>
				emit {(Private use 12}
			<
		}
		160 {
			>
				emit {(Private use 13}
			<
		}
		161 {
			>
				emit {(Private use 14}
			<
		}
		162 {
			>
				emit {(Private use 15}
			<
		}
		163 {
			>
				emit {(802.11 with AVS header}
			<
		}
		165 {
			>
				emit {(BACnet MS/TP}
			<
		}
		166 {
			>
				emit (PPPD
			<
		}
		169 {
			>
				emit {(GPRS LLC}
			<
		}
		177 {
			>
				emit {(Linux LAPD}
			<
		}
		187 {
			>
				emit {(Bluetooth HCI H4}
			<
		}
		189 {
			>
				emit {(Linux USB}
			<
		}
		192 {
			>
				emit (PPI
			<
		}
		195 {
			>
				emit (802.15.4
			<
		}
		196 {
			>
				emit (SITA
			<
		}
		197 {
			>
				emit {(Endace ERF}
			<
		}
		201 {
			>
				emit {(Bluetooth HCI H4 with pseudo-header}
			<
		}
		202 {
			>
				emit {(AX.25 with KISS header}
			<
		}
		203 {
			>
				emit (LAPD
			<
		}
		204 {
			>
				emit {(PPP with direction pseudo-header}
			<
		}
		205 {
			>
				emit {(Cisco HDLC with direction pseudo-header}
			<
		}
		206 {
			>
				emit {(Frame Relay with direction pseudo-header}
			<
		}
		209 {
			>
				emit {(Linux IPMB}
			<
		}
		215 {
			>
				emit {(802.15.4 with non-ASK PHY header}
			<
		}
		220 {
			>
				emit {(Memory-mapped Linux USB}
			<
		}
		224 {
			>
				emit {(Fibre Channel FC-2}
			<
		}
		225 {
			>
				emit {(Fibre Channel FC-2 with frame delimiters}
			<
		}
		226 {
			>
				emit {(Solaris IPNET}
			<
		}
		227 {
			>
				emit (SocketCAN
			<
		}
		228 {
			>
				emit {(Raw IPv4}
			<
		}
		229 {
			>
				emit {(Raw IPv6}
			<
		}
		230 {
			>
				emit {(802.15.4 without FCS}
			<
		}
		231 {
			>
				emit {(D-Bus messages}
			<
		}
		235 {
			>
				emit (DVB-CI
			<
		}
		236 {
			>
				emit (MUX27010
			<
		}
		237 {
			>
				emit {(STANAG 5066 D_PDUs}
			<
		}
		239 {
			>
				emit {(Linux netlink NFLOG messages}
			<
		}
		240 {
			>
				emit {(Hilscher netAnalyzer}
			<
		}
		241 {
			>
				emit {(Hilscher netAnalyzer with delimiters}
			<
		}
		242 {
			>
				emit (IP-over-Infiniband
			<
		}
		243 {
			>
				emit {(MPEG-2 Transport Stream packets}
			<
		}
		244 {
			>
				emit {(ng4t ng40}
			<
		}
		245 {
			>
				emit {(NFC LLCP}
			<
		}
		247 {
			>
				emit (Infiniband
			<
		}
		248 {
			>
				emit (SCTP
			<
		}
	}
	
	if {[N belong [O 16] 0 0 {} {} x {}]} {
		>
			emit {\b, capture length %d)}
		<
	}
	}}
	252
		{firmware-tplink {if {[N ubyte [O 0] 0 0 {} {} x {}]} {
		>
			emit firmware
			mime application/x-tplink-bin
			ext bin
		<
	}
	
	if {[N ubeshort [O 64] 0 0 {} {} x {}]} {
		>
			emit %x
		<
	}
	
	if {[N ubeshort [O 66] 0 0 {} {} x {}]} {
		>
			emit v%x
		<
	}
	
	if {[N ubelong [O 68] 0 0 {} {} != 1]} {
		>
			emit {(revision %u)}
		<
	}
	
	if {[S string [O 4] 0 {} {} x {}]} {
		>
			emit %.24s
		<
	}
	
	if {[S string [O 28] 0 {} {} x {}]} {
		>
			emit %.36s
		<
	}
	
	if {[N ubyte [O 0] 0 0 {} {} != 1]} {
		>
			emit V%X
		<
	}
	
	if {[N long [O 152] 0 0 {} {} != 0]} {
		>
			emit {\b, version}
			if {[N ubeshort [O 152] 0 0 {} {} x {}]} {
				>
					emit %u
				<
			}
	
			if {[N ubeshort [O 154] 0 0 {} {} x {}]} {
				>
					emit {\b.%u}
				<
			}
	
			if {[N ubeshort [O 156] 0 0 {} {} x {}]} {
				>
					emit {\b.%u}
				<
			}
	
		<
	}
	
	if {[N ubelong [O 72] 0 0 {} {} x {}]} {
		>
			if {[N ubelong [O 72] 0 0 {} {} == 1]} {
				>
					emit (US)
				<
			}
	
			if {[N ubelong [O 72] 0 0 {} {} > 1]} {
				>
					emit {(region %u)}
				<
			}
	
		<
	}
	
	if {[N ubelong [O 124] 0 0 {} {} x {}]} {
		>
			emit {\b, %u bytes or less}
		<
	}
	
	if {[N ubelong [O 72] 0 0 {} {} != 0]} {
		>
			emit {\b, UNKNOWN1 0x%x}
		<
	}
	
	if {[N ubelong [O 92] 0 0 {} {} != 0]} {
		>
			emit {\b, UNKNOWN2 0x%x}
		<
	}
	
	if {[N ubelong [O 112] 0 0 {} {} != 0]} {
		>
			emit {\b, UNKNOWN3 0x%x}
		<
	}
	
	if {[N ubelong [O 128] 0 0 {} {} x {}]} {
		>
			emit {\b, at 0x%x}
		<
	}
	
	if {[N ubelong [O 132] 0 0 {} {} x {}]} {
		>
			emit {%u bytes }
		<
	}
	
	T [O [I 128 ubelong 0 + 0 0]] {}
	
	if {[N ubelong [O 136] 0 0 {} {} x {}]} {
		>
			emit {\b, at 0x%x}
		<
	}
	
	if {[N ubelong [O 140] 0 0 {} {} x {}]} {
		>
			emit {%u bytes }
		<
	}
	
	T [O [I 136 ubelong 0 + 0 0]] {}
	
	if {[N ubelong [O 144] 0 0 {} {} != 0]} {
		>
			emit {\b, at 0x%x}
			if {[N ubelong [O 148] 0 0 {} {} != 0]} {
				>
					emit {%u bytes}
				<
			}
	
		<
	}
	}}
	275
		{help-ver-date {if {[N leshort [O 0] 0 0 {} {} == 876]} {
		>
			if {[N leshort [O 4] 0 0 {} {} == 1]} {
				>
					emit Windows
					switch [Nv leshort [O 2] 0 {} {}] {
						15 {
							>
								emit 3.x
							<
						}
						21 {
							>
								emit 3.0
							<
						}
						33 {
							>
								emit 3.1
							<
						}
						39 {
							>
								emit x.y
							<
						}
						51 {
							>
								emit 95
							<
						}
					}
	
					if {[D [O 2]]} {
						>
							emit y.z
							if {[N leshort [O 2] 0 0 {} {} x {}]} {
								>
									emit 0x%x
								<
							}
	
						<
					}
	
					if {[N leshort [O 2] 0 0 {} {} x {}]} {
						>
							emit help
						<
					}
	
					if {[N ldate [O 6] 0 0 {} {} x {}]} {
						>
							emit {\b, %s}
						<
					}
	
					mime application/winhelp
					ext hlp
				<
			}
	
		<
	}
	} cnt-name {if {[S string [O 0] 0 {} {} eq \040]} {
		>
			if {[S regex [O 1] 0 c {} eq ^(\[^\xd>\]*|.*.hlp)]} {
				>
					emit {MS Windows help file Content, based "%s"}
					mime text/plain
					ext cnt
				<
			}
	
		<
	}
	} ini-file {if {[S search [O 0] 0 {} 8192 eq \[]} {
		>
			if {[S regex [R [O 0]] 0 c {} eq ^(autorun)]} {
				>
					if {[S string [R [O 0]] 0 {} {} eq \]\r\n\[]} {
						>
							emit {Total commander directory treeinfo.wc}
							mime text/plain
							ext wc
						<
					}
	
					if {[S string [R [O 0]] 0 {} {} ne \]\r\n\[]} {
						>
							emit {Microsoft Windows Autorun file}
							mime application/x-setupscript
							ext inf
						<
					}
	
				<
			}
	
			if {[S regex [R [O 0]] 0 c {} eq ^(version|strings)\]]} {
				>
					emit {Windows setup INFormation}
					mime application/x-setupscript
					ext inf
				<
			}
	
			if {[S regex [R [O 0]] 0 c {} eq ^(WinsockCRCList|OEMCPL)\]]} {
				>
					emit {Windows setup INFormation}
					mime application/x-setupscript
					ext inf
				<
			}
	
			if {[S regex [R [O 0]] 0 c {} eq ^(.ShellClassInfo|DeleteOnCopy|LocalizedFileNames)\]]} {
				>
					emit {Windows desktop.ini}
					mime application/x-wine-extension-ini
				<
			}
	
			if {[S regex [R [O 0]] 0 c {} eq ^(don't\ load)\]]} {
				>
					emit {Windows CONTROL.INI}
					mime application/x-wine-extension-ini
					ext ini
				<
			}
	
			if {[S regex [R [O 0]] 0 c {} eq ^(ndishlp\\\$|protman\\\$|NETBEUI\\\$)\]]} {
				>
					emit {Windows PROTOCOL.INI}
					mime application/x-wine-extension-ini
					ext ini
				<
			}
	
			if {[S regex [R [O 0]] 0 c {} eq ^(windows|Compatibility|embedding)\]]} {
				>
					emit {Windows WIN.INI}
					mime application/x-wine-extension-ini
					ext ini
				<
			}
	
			if {[S regex [R [O 0]] 0 c {} eq ^(boot|386enh|drivers)\]]} {
				>
					emit {Windows SYSTEM.INI}
					mime application/x-wine-extension-ini
					ext ini
				<
			}
	
			if {[S regex [R [O 0]] 0 c {} eq ^(SafeList)\]]} {
				>
					emit {Windows IOS.INI}
					mime application/x-wine-extension-ini
					ext ini
				<
			}
	
			if {[S regex [R [O 0]] 0 c {} eq ^(boot\x20loader)\]]} {
				>
					emit {Windows boot.ini}
					mime application/x-wine-extension-ini
					ext ini
				<
			}
	
			if {[S regex [R [O 0]] 0 c {} eq ^(menu)\]]} {
				>
					emit {MS-DOS CONFIG.SYS}
					ext sys/dos/w40
				<
			}
	
			if {[S regex [R [O 0]] 0 c {} eq ^(Paths)\]\r\n]} {
				>
					emit {MS-DOS MSDOS.SYS}
					ext sys/dos
				<
			}
	
			if {[S regex [R [O 0]] 0 c {} eq ^(options)\]\r\n]} {
				>
					emit {Microsoft HTML Help Project}
					mime text/plain
					ext hhp
				<
			}
	
			if {[D [R [O 0]]]} {
				>
					if {[S search [R [O 0]] 0 {} 8192 eq \[]} {
						>
							if {[S string [R [O 0]] 0 c {} eq version]} {
								>
									emit {Windows setup INFormation}
									mime application/x-setupscript
									ext inf
								<
							}
	
							if {[D [R [O 0]]]} {
								>
									if {[N ubyte [R [O 0]] 0 0 {} {} x {}]} {
										>
											if {[S regex [R [O -1]] 0 {} {} eq ^(\[A-Za-z0-9_()\ \]+)\]\r]} {
												>
													emit {Generic INItialization configuration [%-.40s}
													mime application/x-wine-extension-ini
													ext ini/inf
												<
											}
	
										<
									}
	
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	}}
	288
		{zipcd {if {[S string [O 0] 0 {} {} eq PK\001\002]} {
		>
			if {[N leshort [O 4] 0 0 {} {} x {}]} {
				>
					emit {\b, made by}
				<
			}
	
			U 288 zipversion [O 4]
	
			if {[N leshort [O 6] 0 0 {} {} x {}]} {
				>
					emit {\b, extract using at least}
				<
			}
	
			U 288 zipversion [O 6]
	
			if {[N ledate [O 12] 0 0 {} {} x {}]} {
				>
					emit {\b, last modified %s}
				<
			}
	
			if {[N lelong [O 24] 0 0 {} {} > 0]} {
				>
					emit {\b, uncompressed size %d}
				<
			}
	
			if {[N leshort [O 10] 0 0 {} {} x {}]} {
				>
					emit {\b, method=}
				<
			}
	
			U 288 zipcompression [O 10]
	
		<
	}
	} zipcompression {switch [Nv leshort [O 0] 0 {} {}] {
		0 {
			>
				emit {\bstore}
			<
		}
		8 {
			>
				emit {\bdeflate}
			<
		}
		9 {
			>
				emit {\bdeflate64}
			<
		}
		12 {
			>
				emit {\bbzip2}
			<
		}
		14 {
			>
				emit {\blzma}
			<
		}
		94 {
			>
				emit {\bMP3}
			<
		}
		95 {
			>
				emit {\bxz}
			<
		}
		96 {
			>
				emit {\bJpeg}
			<
		}
		97 {
			>
				emit {\bWavPack}
			<
		}
		98 {
			>
				emit {\bPPMd}
			<
		}
		99 {
			>
				emit {\bAES Encrypted}
			<
		}
	}
	
	if {[D [O 0]]} {
		>
			if {[N leshort [O 0] 0 0 {} {} x {}]} {
				>
					emit {\b[%#x]}
				<
			}
	
		<
	}
	} zipversion {switch [Nv leshort [O 0] 0 {} {}] {
		9 {
			>
				emit v0.9
			<
		}
		10 {
			>
				emit v1.0
			<
		}
		11 {
			>
				emit v1.1
			<
		}
		20 {
			>
				emit v2.0
			<
		}
		21 {
			>
				emit v2.1
			<
		}
		25 {
			>
				emit v2.5
			<
		}
		27 {
			>
				emit v2.7
			<
		}
		45 {
			>
				emit v4.5
			<
		}
		46 {
			>
				emit v4.6
			<
		}
		50 {
			>
				emit v5.0
			<
		}
		51 {
			>
				emit v5.1
			<
		}
		52 {
			>
				emit v5.2
			<
		}
		61 {
			>
				emit v6.1
			<
		}
		62 {
			>
				emit v6.2
			<
		}
		63 {
			>
				emit v6.3
			<
		}
	}
	
	if {[D [O 0]]} {
		>
			if {[N leshort [O 0] 0 0 {} {} x {}]} {
				>
					emit {v?[%#x]}
				<
			}
	
		<
	}
	}}

}
proc analyze {} {
	switch [Nv leshort 0 0 {} {}] {
		-13230 {
			>
				emit {RLE image data,}
				if {[N leshort 6 0 0 {} {} x {}]} {
					>
						emit {%d x}
					<
				}
	
				if {[N leshort 8 0 0 {} {} x {}]} {
					>
						emit %d
					<
				}
	
				if {[N leshort 2 0 0 {} {} > 0]} {
					>
						emit {\b, lower left corner: %d}
					<
				}
	
				if {[N leshort 4 0 0 {} {} > 0]} {
					>
						emit {\b, lower right corner: %d}
					<
				}
	
				if {[N byte 10 0 0 & 1 == 1]} {
					>
						emit {\b, clear first}
					<
				}
	
				if {[N byte 10 0 0 & 2 == 2]} {
					>
						emit {\b, no background}
					<
				}
	
				if {[N byte 10 0 0 & 4 == 4]} {
					>
						emit {\b, alpha channel}
					<
				}
	
				if {[N byte 10 0 0 & 8 == 8]} {
					>
						emit {\b, comment}
					<
				}
	
				if {[N byte 11 0 0 {} {} > 0]} {
					>
						emit {\b, %d color channels}
					<
				}
	
				if {[N byte 12 0 0 {} {} > 0]} {
					>
						emit {\b, %d bits per pixel}
					<
				}
	
				if {[N byte 13 0 0 {} {} > 0]} {
					>
						emit {\b, %d color map channels}
					<
				}
	
			<
		}
		-5536 {
			>
				emit {ARJ archive data}
				mime application/x-arj
				if {[N byte 5 0 0 {} {} x {}]} {
					>
						emit {\b, v%d,}
					<
				}
	
				if {[N byte 8 0 0 {} {} & 4]} {
					>
						emit multi-volume,
					<
				}
	
				if {[N byte 8 0 0 {} {} & 16]} {
					>
						emit slash-switched,
					<
				}
	
				if {[N byte 8 0 0 {} {} & 32]} {
					>
						emit backup,
					<
				}
	
				if {[S string 34 0 {} {} x {}]} {
					>
						emit {original name: %s,}
					<
				}
	
				switch [Nv byte 7 0 {} {}] {
					0 {
						>
							emit {os: MS-DOS}
						<
					}
					1 {
						>
							emit {os: PRIMOS}
						<
					}
					2 {
						>
							emit {os: Unix}
						<
					}
					3 {
						>
							emit {os: Amiga}
						<
					}
					4 {
						>
							emit {os: Macintosh}
						<
					}
					5 {
						>
							emit {os: OS/2}
						<
					}
					6 {
						>
							emit {os: Apple ][ GS}
						<
					}
					7 {
						>
							emit {os: Atari ST}
						<
					}
					8 {
						>
							emit {os: NeXT}
						<
					}
					9 {
						>
							emit {os: VAX/VMS}
						<
					}
				}
	
				if {[N byte 3 0 0 {} {} > 0]} {
					>
						emit %d\]
					<
				}
	
			<
		}
		-5247 {
			>
				emit {PRCS packaged project}
			<
		}
		-155 {
			>
				emit {old 16-bit-int little-endian archive}
				if {[S string 2 0 {} {} eq __.SYMDEF]} {
					>
						emit {random library}
					<
				}
	
			<
			>
				emit x.out
				if {[S string 2 0 {} {} eq __.SYMDEF]} {
					>
						emit randomized
					<
				}
	
				if {[N byte 0 0 0 {} {} x {}]} {
					>
						emit archive
					<
				}
	
			<
		}
		-147 {
			>
				emit {very old 16-bit-int little-endian archive}
			<
		}
		257 {
			>
				if {[N ulelong 68 0 0 {} {} != 88]} {
					>
						emit {PDP-11 UNIX/RT ldp}
					<
				}
	
			<
		}
		261 {
			>
				emit {PDP-11 old overlay}
			<
		}
		263 {
			>
				emit {PDP-11 executable}
				if {[N leshort 8 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				if {[N byte 15 0 0 {} {} > 0]} {
					>
						emit {- version %d}
					<
				}
	
			<
		}
		264 {
			>
				emit {PDP-11 pure executable}
				if {[N leshort 8 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				if {[N byte 15 0 0 {} {} > 0]} {
					>
						emit {- version %d}
					<
				}
	
			<
		}
		265 {
			>
				emit {PDP-11 separate I&D executable}
				if {[N leshort 8 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				if {[N byte 15 0 0 {} {} > 0]} {
					>
						emit {- version %d}
					<
				}
	
			<
		}
		267 {
			>
				emit {PDP-11 demand-paged pure executable}
				if {[N leshort 8 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		280 {
			>
				emit {PDP-11 overlaid pure executable}
				if {[N leshort 8 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		281 {
			>
				emit {PDP-11 overlaid separate executable}
				if {[N leshort 8 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		283 {
			>
				emit {SVr2 curses screen image, little-endian}
			<
		}
		284 {
			>
				emit {SVr3 curses screen image, little-endian}
			<
		}
		285 {
			>
				emit {SVr4 curses screen image, little-endian}
			<
		}
		287 {
			>
				emit {PDP-11 kernel overlay}
			<
		}
		320 {
			>
				emit {old Microsoft 8086 x.out}
				if {[N byte 3 0 0 {} {} & 4]} {
					>
						emit separate
					<
				}
	
				if {[N byte 3 0 0 {} {} & 2]} {
					>
						emit pure
					<
				}
	
				if {[N byte 0 0 0 {} {} & 1]} {
					>
						emit executable
					<
				}
	
				if {[N byte 0 0 0 {} {} ^ 1]} {
					>
						emit relocatable
					<
				}
	
				if {[N lelong 20 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		322 {
			>
				emit {basic-16 executable}
				if {[N lelong 12 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		323 {
			>
				emit {basic-16 executable (TV)}
				if {[N lelong 12 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		328 {
			>
				emit {x86 executable}
				if {[N lelong 12 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		329 {
			>
				emit {x86 executable (TV)}
				if {[N lelong 12 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		330 {
			>
				emit {iAPX 286 executable small model (COFF)}
				if {[N lelong 12 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		332 {
			>
				U 113 display-coff 0
	
			<
		}
		338 {
			>
				emit {iAPX 286 executable large model (COFF)}
				if {[N lelong 12 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		358 {
			>
				emit {MS Windows COFF MIPS R4000 object file}
			<
		}
		376 {
			>
				emit {VAX COFF executable}
				if {[N lelong 12 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				if {[N leshort 22 0 0 {} {} > 0]} {
					>
						emit {- version %d}
					<
				}
	
			<
		}
		381 {
			>
				emit {VAX COFF pure executable}
				if {[N lelong 12 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				if {[N leshort 22 0 0 {} {} > 0]} {
					>
						emit {- version %d}
					<
				}
	
			<
		}
		387 {
			>
				switch [Nv leshort 24 0 {} {}] {
					263 {
						>
							emit {COFF format alpha object}
							if {[N leshort 22 0 0 & 12288 == 8192]} {
								>
									emit {shared library}
								<
							}
	
							if {[N byte 27 0 0 {} {} x {}]} {
								>
									emit {- version %d}
								<
							}
	
							if {[N byte 26 0 0 {} {} x {}]} {
								>
									emit {\b.%d}
								<
							}
	
							if {[N byte 28 0 0 {} {} x {}]} {
								>
									emit {\b-%d}
								<
							}
	
						<
					}
					264 {
						>
							emit {COFF format alpha pure}
						<
					}
					267 {
						>
							emit {COFF format alpha demand paged}
							if {[N leshort 22 0 0 & 12288 != 8192]} {
								>
									emit executable
								<
							}
	
							if {[N leshort 22 0 0 & 8192 != 0]} {
								>
									emit {dynamically linked}
								<
							}
	
							if {[N lelong 16 0 0 {} {} != 0]} {
								>
									emit {not stripped}
								<
							}
	
							if {[N lelong 16 0 0 {} {} == 0]} {
								>
									emit stripped
								<
							}
	
							if {[N byte 27 0 0 {} {} x {}]} {
								>
									emit {- version %d}
								<
							}
	
							if {[N byte 26 0 0 {} {} x {}]} {
								>
									emit {\b.%d}
								<
							}
	
							if {[N byte 28 0 0 {} {} x {}]} {
								>
									emit {\b-%d}
								<
							}
	
						<
					}
				}
	
			<
		}
		388 {
			>
				emit {MS Windows COFF Alpha object file}
			<
		}
		392 {
			>
				emit {Alpha compressed COFF}
			<
		}
		399 {
			>
				emit {Alpha u-code object}
			<
		}
		443 {
			>
				if {[N leshort 2 0 0 {} {} == 256]} {
					>
						emit {Brooktrout 301 fax image,}
						if {[N leshort 9 0 0 {} {} x {}]} {
							>
								emit {%d x}
							<
						}
	
						if {[N leshort 45 0 0 {} {} x {}]} {
							>
								emit %d
							<
						}
	
						switch [Nv leshort 6 0 {} {}] {
							100 {
								>
									emit {\b, normal resolution}
								<
							}
							200 {
								>
									emit {\b, fine resolution}
								<
							}
						}
	
						switch [Nv byte 11 0 {} {}] {
							1 {
								>
									emit {\b, G3 compression}
								<
							}
							2 {
								>
									emit {\b, G32D compression}
								<
							}
						}
	
					<
				}
	
			<
		}
		496 {
			>
				emit {MS Windows COFF PowerPC object file}
			<
		}
		518 {
			>
				emit {Microsoft a.out}
				if {[N leshort 8 0 0 {} {} == 1]} {
					>
						emit {Middle model}
					<
				}
	
				if {[N leshort 30 0 0 {} {} & 16]} {
					>
						emit overlay
					<
				}
	
				if {[N leshort 30 0 0 {} {} & 2]} {
					>
						emit separate
					<
				}
	
				if {[N leshort 30 0 0 {} {} & 4]} {
					>
						emit pure
					<
				}
	
				if {[N leshort 30 0 0 {} {} & 2048]} {
					>
						emit segmented
					<
				}
	
				if {[N leshort 30 0 0 {} {} & 1024]} {
					>
						emit standalone
					<
				}
	
				if {[N leshort 30 0 0 {} {} & 8]} {
					>
						emit fixed-stack
					<
				}
	
				if {[N byte 28 0 0 {} {} & -128]} {
					>
						emit byte-swapped
					<
				}
	
				if {[N byte 28 0 0 {} {} & 64]} {
					>
						emit word-swapped
					<
				}
	
				if {[N lelong 16 0 0 {} {} > 0]} {
					>
						emit not-stripped
					<
				}
	
				if {[N leshort 30 0 0 {} {} ^ -16384]} {
					>
						emit pre-SysV
					<
				}
	
				if {[N leshort 30 0 0 {} {} & 16384]} {
					>
						emit V2.3
					<
				}
	
				if {[N leshort 30 0 0 {} {} & -32768]} {
					>
						emit V3.0
					<
				}
	
				if {[N byte 28 0 0 {} {} & 4]} {
					>
						emit 86
					<
				}
	
				if {[N byte 28 0 0 {} {} & 11]} {
					>
						emit 186
					<
				}
	
				if {[N byte 28 0 0 {} {} & 9]} {
					>
						emit 286
					<
				}
	
				if {[N byte 28 0 0 {} {} & 10]} {
					>
						emit 386
					<
				}
	
				if {[N byte 31 0 0 {} {} < 64]} {
					>
						emit {small model}
					<
				}
	
				switch [Nv byte 31 0 {} {}] {
					72 {
						>
							emit {large model}
						<
					}
					73 {
						>
							emit {huge model}
						<
					}
				}
	
				if {[N leshort 30 0 0 {} {} & 1]} {
					>
						emit executable
					<
				}
	
				if {[N leshort 30 0 0 {} {} ^ 1]} {
					>
						emit {object file}
					<
				}
	
				if {[N leshort 30 0 0 {} {} & 64]} {
					>
						emit {Large Text}
					<
				}
	
				if {[N leshort 30 0 0 {} {} & 32]} {
					>
						emit {Large Data}
					<
				}
	
				if {[N leshort 30 0 0 {} {} & 288]} {
					>
						emit {Huge Objects Enabled}
					<
				}
	
				if {[N lelong 16 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		616 {
			>
				emit {MS Windows COFF Motorola 68000 object file}
			<
		}
		656 {
			>
				emit {MS Windows COFF PA-RISC object file}
			<
		}
		662 {
			>
				emit {Atari ATR image}
			<
		}
		1078 {
			>
				emit {Linux/i386 PC Screen Font v1 data,}
				if {[N byte 2 0 0 & 1 == 0]} {
					>
						emit {256 characters,}
					<
				}
	
				if {[N byte 2 0 0 & 1 != 0]} {
					>
						emit {512 characters,}
					<
				}
	
				if {[N byte 2 0 0 & 2 == 0]} {
					>
						emit {no directory,}
					<
				}
	
				if {[N byte 2 0 0 & 2 != 0]} {
					>
						emit {Unicode directory,}
					<
				}
	
				if {[N byte 3 0 0 {} {} > 0]} {
					>
						emit 8x%d
					<
				}
	
			<
		}
		1360 {
			>
				if {[N uleshort 18 0 0 & 36480 == 0]} {
					>
						U 104 display-coff 0
	
					<
				}
	
			<
		}
		1408 {
			>
				emit {XENIX 8086 relocatable or 80286 small model}
			<
		}
		3468 {
			>
				if {[N leshort 4 0 0 {} {} == 515]} {
					>
						switch [Nv leshort 2 0 {} {}] {
							516 {
								>
									emit {GPG symmetrically encrypted data (3DES cipher)}
								<
							}
							772 {
								>
									emit {GPG symmetrically encrypted data (CAST5 cipher)}
								<
							}
							1028 {
								>
									emit {GPG symmetrically encrypted data (BLOWFISH cipher)}
								<
							}
							1796 {
								>
									emit {GPG symmetrically encrypted data (AES cipher)}
								<
							}
							2052 {
								>
									emit {GPG symmetrically encrypted data (AES192 cipher)}
								<
							}
							2308 {
								>
									emit {GPG symmetrically encrypted data (AES256 cipher)}
								<
							}
							2564 {
								>
									emit {GPG symmetrically encrypted data (TWOFISH cipher)}
								<
							}
							2820 {
								>
									emit {GPG symmetrically encrypted data (CAMELLIA128 cipher)}
								<
							}
							3076 {
								>
									emit {GPG symmetrically encrypted data (CAMELLIA192 cipher)}
								<
							}
							3332 {
								>
									emit {GPG symmetrically encrypted data (CAMELLIA256 cipher)}
								<
							}
						}
	
					<
				}
	
			<
		}
		4097 {
			>
				emit {LANalyzer capture file}
			<
		}
		4103 {
			>
				emit {LANalyzer capture file}
			<
		}
		4843 {
			>
				emit {SYMMETRY i386 .o}
				if {[N lelong 16 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				if {[N lelong 124 0 0 {} {} > 0]} {
					>
						emit {version %d}
					<
				}
	
			<
		}
		6532 {
			>
				emit {Linux old jffs2 filesystem data little endian}
			<
		}
		6533 {
			>
				emit {Linux jffs2 filesystem data little endian}
			<
		}
		8939 {
			>
				emit {SYMMETRY i386 executable (0 @ 0)}
				if {[N lelong 16 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				if {[N lelong 124 0 0 {} {} > 0]} {
					>
						emit {version %d}
					<
				}
	
			<
		}
		13035 {
			>
				emit {SYMMETRY i386 executable (invalid @ 0)}
				if {[N lelong 16 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				if {[N lelong 124 0 0 {} {} > 0]} {
					>
						emit {version %d}
					<
				}
	
			<
		}
		13123 {
			>
				emit {Clarion Developer (v2 and above) data file}
				if {[N leshort 2 0 0 {} {} & 1]} {
					>
						emit {\b, locked}
					<
				}
	
				if {[N leshort 2 0 0 {} {} & 4]} {
					>
						emit {\b, encrypted}
					<
				}
	
				if {[N leshort 2 0 0 {} {} & 8]} {
					>
						emit {\b, memo file exists}
					<
				}
	
				if {[N leshort 2 0 0 {} {} & 16]} {
					>
						emit {\b, compressed}
					<
				}
	
				if {[N leshort 2 0 0 {} {} & 64]} {
					>
						emit {\b, read only}
					<
				}
	
				if {[N lelong 5 0 0 {} {} x {}]} {
					>
						emit {\b, %d records}
					<
				}
	
			<
		}
		13133 {
			>
				emit {Clarion Developer (v2 and above) memo data}
			<
		}
		16728 {
			>
				emit {Sony PlayStation Audio}
			<
		}
		17131 {
			>
				if {[N lelong 124 0 0 {} {} > -1]} {
					>
						if {[N lelong 124 0 0 {} {} != 28867614]} {
							>
								emit {SYMMETRY i386 standalone executable}
								if {[N lelong 16 0 0 {} {} > 0]} {
									>
										emit {not stripped}
									<
								}
	
								if {[N lelong 124 0 0 {} {} > 0]} {
									>
										emit {version %d}
									<
								}
	
							<
						}
	
					<
				}
	
			<
		}
		18912 {
			>
				emit {Clarion Developer (v2 and above) help data}
			<
		}
		19789 {
			>
				if {[N leshort 6 0 0 {} {} == 2]} {
					>
						if {[N lelong 8 0 0 {} {} == 10]} {
							>
								if {[N leshort 16 0 0 {} {} == 15677]} {
									>
										emit {3D Studio model}
										mime image/x-3ds
										ext 3ds
									<
								}
	
							<
						}
	
					<
				}
	
			<
		}
		21020 {
			>
				emit {COFF DSP21k}
				if {[N lelong 18 0 0 {} {} & 2]} {
					>
						emit executable,
					<
				}
	
				if {[N lelong 18 0 0 {} {} ^ 2]} {
					>
						if {[N lelong 18 0 0 {} {} & 1]} {
							>
								emit {static object,}
							<
						}
	
						if {[N lelong 18 0 0 {} {} ^ 1]} {
							>
								emit {relocatable object,}
							<
						}
	
					<
				}
	
				if {[N lelong 18 0 0 {} {} & 8]} {
					>
						emit stripped
					<
				}
	
				if {[N lelong 18 0 0 {} {} ^ 8]} {
					>
						emit {not stripped}
					<
				}
	
			<
			>
				emit {SHARC COFF binary}
				if {[N leshort 2 0 0 {} {} > 1]} {
					>
						emit {, %d sections}
						if {[N lelong 12 0 0 {} {} > 0]} {
							>
								emit {, not stripped}
							<
						}
	
					<
				}
	
			<
		}
	}
	
	switch [Nv beshort 0 0 {} {}] {
		-32768 {
			>
				if {[S string [I 2 ubeshort 0 - 0 2] 0 {} {} eq (c)CRI]} {
					>
						emit {CRI ADX ADPCM audio}
						if {[N byte 18 0 0 {} {} x {}]} {
							>
								emit v%u
							<
						}
	
						switch [Nv byte 4 0 {} {}] {
							2 {
								>
									emit {\b, pre-set prediction coefficients}
								<
							}
							3 {
								>
									emit {\b, standard ADX}
								<
							}
							4 {
								>
									emit {\b, exponential scale}
								<
							}
							5 {
								>
									emit {\b, AHX}
								<
							}
						}
	
						if {[N belong 8 0 0 {} {} x {}]} {
							>
								emit {\b, %u Hz}
							<
						}
	
						switch [Nv byte 18 0 {} {}] {
							3 {
								>
									if {[N beshort 2 0 0 {} {} > 43]} {
										>
											if {[N belong 24 0 0 {} {} != 0]} {
												>
													emit {\b, looping}
												<
											}
	
										<
									}
	
								<
							}
							4 {
								>
									if {[N beshort 2 0 0 {} {} > 55]} {
										>
											if {[N belong 36 0 0 {} {} != 0]} {
												>
													emit {\b, looping}
												<
											}
	
										<
									}
	
								<
							}
						}
	
						if {[N byte 19 0 0 & 8 == 8]} {
							>
								emit {\b, encrypted}
							<
						}
	
					<
				}
	
			<
			>
				emit {lif file}
			<
		}
		-32760 {
			>
				if {[S string 6 0 {} {} eq BS93]} {
					>
						emit {Lynx homebrew cartridge}
						if {[N beshort 2 0 0 {} {} x {}]} {
							>
								emit {\b, RAM start $%04x}
							<
						}
	
						mime application/x-atari-lynx-rom
					<
				}
	
				if {[S string 6 0 {} {} eq LYNX]} {
					>
						emit {Lynx cartridge}
						if {[N beshort 2 0 0 {} {} x {}]} {
							>
								emit {\b, RAM start $%04x}
							<
						}
	
						mime application/x-atari-lynx-rom
					<
				}
	
			<
		}
		-31486 {
			>
				emit {GPG encrypted data}
				mime {text/PGP # encoding: data}
			<
		}
		-30875 {
			>
				emit {disk quotas file}
			<
		}
		-30771 {
			>
				emit {OS9/6809 module:}
				switch [Nv byte 6 0 & 15] {
					0 {
						>
							emit non-executable
						<
					}
					1 {
						>
							emit {machine language}
						<
					}
					2 {
						>
							emit {BASIC I-code}
						<
					}
					3 {
						>
							emit {Pascal P-code}
						<
					}
					4 {
						>
							emit {C I-code}
						<
					}
					5 {
						>
							emit {COBOL I-code}
						<
					}
					6 {
						>
							emit {Fortran I-code}
						<
					}
				}
	
				switch [Nv byte 6 0 & -16] {
					-64 {
						>
							emit {system module}
						<
					}
					-48 {
						>
							emit {file manager}
						<
					}
					-32 {
						>
							emit {device driver}
						<
					}
					-16 {
						>
							emit {device descriptor}
						<
					}
					16 {
						>
							emit {program executable}
						<
					}
					32 {
						>
							emit subroutine
						<
					}
					48 {
						>
							emit multi-module
						<
					}
					64 {
						>
							emit {data module}
						<
					}
				}
	
			<
		}
		-27392 {
			>
				emit {PGP key security ring}
				mime application/x-pgp-keyring
			<
		}
		-27391 {
			>
				emit {PGP key security ring}
				mime application/x-pgp-keyring
			<
		}
		-26110 {
			>
				emit {Zebra Metafile graphic}
				switch [Nv leshort 2 0 {} {}] {
					1 {
						>
							emit {(version 1.x)}
						<
					}
					2 {
						>
							emit {(version 1.1x or 1.2x)}
						<
					}
					3 {
						>
							emit {(version 1.49)}
						<
					}
					4 {
						>
							emit {(version 1.50)}
						<
					}
				}
	
				if {[S string 4 0 {} {} x {}]} {
					>
						emit {(comment = %s)}
					<
				}
	
			<
		}
		-23040 {
			>
				emit {PGP encrypted data}
				mime {text/PGP # encoding: armored data}
			<
		}
		-21928 {
			>
				emit {floppy image data (IBM SaveDskF, old)}
			<
		}
		-21927 {
			>
				emit {floppy image data (IBM SaveDskF)}
			<
		}
		-21926 {
			>
				emit {floppy image data (IBM SaveDskF, compressed)}
			<
		}
		-21267 {
			>
				emit {Java serialization data}
				if {[N beshort 2 0 0 {} {} > 4]} {
					>
						emit {\b, version %d}
					<
				}
	
			<
		}
		-8185 {
			>
				emit {amd 29k coff archive}
			<
		}
		-7408 {
			>
				emit {Amiga Workbench}
				if {[N beshort 2 0 0 {} {} == 1]} {
					>
						switch [Nv byte 48 0 {} {}] {
							1 {
								>
									emit {disk icon}
								<
							}
							2 {
								>
									emit {drawer icon}
								<
							}
							3 {
								>
									emit {tool icon}
								<
							}
							4 {
								>
									emit {project icon}
								<
							}
							5 {
								>
									emit {garbage icon}
								<
							}
							6 {
								>
									emit {device icon}
								<
							}
							7 {
								>
									emit {kickstart icon}
								<
							}
							8 {
								>
									emit {workbench application icon}
								<
							}
						}
	
					<
				}
	
				if {[N beshort 2 0 0 {} {} > 1]} {
					>
						emit {icon, vers. %d}
					<
				}
	
			<
		}
		-1279 {
			>
				emit {QDOS object}
				if {[S pstring 2 0 {} {} x {}]} {
					>
						emit '%s'
					<
				}
	
			<
		}
		-511 {
			>
				emit {MySQL table definition file}
				if {[N byte 2 0 0 {} {} x {}]} {
					>
						emit {Version %d}
					<
				}
	
				switch [Nv byte 3 0 {} {}] {
					0 {
						>
							emit {\b, type UNKNOWN}
						<
					}
					1 {
						>
							emit {\b, type DIAM_ISAM}
						<
					}
					2 {
						>
							emit {\b, type HASH}
						<
					}
					3 {
						>
							emit {\b, type MISAM}
						<
					}
					4 {
						>
							emit {\b, type PISAM}
						<
					}
					5 {
						>
							emit {\b, type RMS_ISAM}
						<
					}
					6 {
						>
							emit {\b, type HEAP}
						<
					}
					7 {
						>
							emit {\b, type ISAM}
						<
					}
					8 {
						>
							emit {\b, type MRG_ISAM}
						<
					}
					9 {
						>
							emit {\b, type MYISAM}
						<
					}
					10 {
						>
							emit {\b, type MRG_MYISAM}
						<
					}
					11 {
						>
							emit {\b, type BERKELEY_DB}
						<
					}
					12 {
						>
							emit {\b, type INNODB}
						<
					}
					13 {
						>
							emit {\b, type GEMINI}
						<
					}
					14 {
						>
							emit {\b, type NDBCLUSTER}
						<
					}
					15 {
						>
							emit {\b, type EXAMPLE_DB}
						<
					}
					16 {
						>
							emit {\b, type CSV_DB}
						<
					}
					17 {
						>
							emit {\b, type FEDERATED_DB}
						<
					}
					18 {
						>
							emit {\b, type BLACKHOLE_DB}
						<
					}
					19 {
						>
							emit {\b, type PARTITION_DB}
						<
					}
					20 {
						>
							emit {\b, type BINLOG}
						<
					}
					21 {
						>
							emit {\b, type SOLID}
						<
					}
					22 {
						>
							emit {\b, type PBXT}
						<
					}
					23 {
						>
							emit {\b, type TABLE_FUNCTION}
						<
					}
					24 {
						>
							emit {\b, type MEMCACHE}
						<
					}
					25 {
						>
							emit {\b, type FALCON}
						<
					}
					26 {
						>
							emit {\b, type MARIA}
						<
					}
					27 {
						>
							emit {\b, type PERFORMANCE_SCHEMA}
						<
					}
					127 {
						>
							emit {\b, type DEFAULT}
						<
					}
				}
	
				if {[N ulong 51 0 0 {} {} x {}]} {
					>
						emit {\b, MySQL version %d}
					<
				}
	
			<
		}
		-508 {
			>
				emit {structured file}
			<
		}
		-155 {
			>
				emit {old 16-bit-int big-endian archive}
				if {[S string 2 0 {} {} eq __.SYMDEF]} {
					>
						emit {random library}
					<
				}
	
			<
		}
		-147 {
			>
				emit {very old 16-bit-int big-endian archive}
			<
		}
		-40 {
			>
				emit {JPEG image data}
				mime image/jpeg
				ext jpeg/jpg/jpe/jfif
				if {[S string 6 0 {} {} eq JFIF]} {
					>
						emit {\b, JFIF standard}
						if {[N byte 11 0 0 {} {} x {}]} {
							>
								emit {\b %d.}
							<
						}
	
						if {[N byte 12 0 0 {} {} x {}]} {
							>
								emit {\b%02d}
							<
						}
	
						switch [Nv byte 13 0 {} {}] {
							0 {
								>
									emit {\b, aspect ratio}
								<
							}
							1 {
								>
									emit {\b, resolution (DPI)}
								<
							}
							2 {
								>
									emit {\b, resolution (DPCM)}
								<
							}
						}
	
						if {[N beshort 14 0 0 {} {} x {}]} {
							>
								emit {\b, density %dx}
							<
						}
	
						if {[N beshort 16 0 0 {} {} x {}]} {
							>
								emit {\b%d}
							<
						}
	
						if {[N beshort 4 0 0 {} {} x {}]} {
							>
								emit {\b, segment length %d}
							<
						}
	
						if {[N byte 18 0 0 {} {} != 0]} {
							>
								emit {\b, thumbnail %dx}
								if {[N byte 19 0 0 {} {} x {}]} {
									>
										emit {\b%d}
									<
								}
	
							<
						}
	
					<
				}
	
				if {[S string 6 0 {} {} eq Exif]} {
					>
						emit {\b, Exif standard: [}
						T 12 r
	
						if {[S string 12 0 {} {} x {}]} {
							>
								emit {\b]}
							<
						}
	
					<
				}
	
				U 120 jpeg_segment [I 4 ubeshort 0 + 0 4]
	
			<
		}
		1 {
			>
				switch [Nv beshort 2 0 {} {}] {
					8 {
						>
							U 111 gem_info 0
	
						<
					}
					9 {
						>
							U 111 gem_info 0
	
						<
					}
					24 {
						>
							U 111 gem_info 0
	
						<
					}
					25 {
						>
							U 111 gem_info 0
	
						<
					}
				}
	
			<
		}
		9 {
			>
				if {[N belong 2 0 0 {} {} == 267390960]} {
					>
						if {[N belong [R 0] 0 0 {} {} == 267390960]} {
							>
								if {[N byte [R 0] 0 0 {} {} == 0]} {
									>
									<
								}
	
								if {[N beshort [R 1] 0 0 {} {} == 1]} {
									>
									<
								}
	
								if {[S string [R 3] 0 {} {} eq a]} {
									>
										emit {Xilinx BIT data}
										if {[S pstring [R 0] 0 H {} x {}]} {
											>
												emit {- from %s}
												if {[S string [R 1] 0 {} {} eq b]} {
													>
														if {[S pstring [R 0] 0 H {} x {}]} {
															>
																emit {- for %s}
																if {[S string [R 1] 0 {} {} eq c]} {
																	>
																		if {[S pstring [R 0] 0 H {} x {}]} {
																			>
																				emit {- built %s}
																				if {[S string [R 1] 0 {} {} eq d]} {
																					>
																						if {[S pstring [R 0] 0 H {} x {}]} {
																							>
																								emit {\b(%s)}
																								if {[S string [R 1] 0 {} {} eq e]} {
																									>
																										if {[N belong [R 0] 0 0 {} {} x {}]} {
																											>
																												emit {- data length 0x%x}
																											<
																										}
	
																									<
																								}
	
																							<
																						}
	
																					<
																				}
	
																			<
																		}
	
																	<
																}
	
															<
														}
	
													<
												}
	
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
			<
		}
		100 {
			>
				emit {Atari 68xxx CPX file}
				if {[N beshort 8 0 0 {} {} x {}]} {
					>
						emit {(version %04x)}
					<
				}
	
			<
		}
		200 {
			>
				emit {hp200 (68010) BSD}
				switch [Nv beshort 2 0 {} {}] {
					263 {
						>
							emit {impure binary}
						<
					}
					264 {
						>
							emit {read-only binary}
						<
					}
					267 {
						>
							emit {demand paged binary}
						<
					}
				}
	
			<
		}
		260 {
			>
				emit {shared library}
			<
		}
		261 {
			>
				emit {ctab data}
			<
		}
		283 {
			>
				emit {SVr2 curses screen image, big-endian}
			<
		}
		284 {
			>
				emit {SVr3 curses screen image, big-endian}
			<
		}
		285 {
			>
				emit {SVr4 curses screen image, big-endian}
			<
		}
		300 {
			>
				emit {hp300 (68020+68881) BSD}
				switch [Nv beshort 2 0 {} {}] {
					263 {
						>
							emit {impure binary}
						<
					}
					264 {
						>
							emit {read-only binary}
						<
					}
					267 {
						>
							emit {demand paged binary}
						<
					}
				}
	
			<
		}
		312 {
			>
				emit {interLaced eXtensible Trace (LXT) file}
				if {[N beshort 2 0 0 {} {} > 0]} {
					>
						emit {(Version %u)}
					<
				}
	
			<
		}
		320 {
			>
				emit {MIPSEB MIPS-III ECOFF executable}
				switch [Nv beshort 20 0 {} {}] {
					263 {
						>
							emit (impure)
						<
					}
					264 {
						>
							emit (swapped)
						<
					}
					267 {
						>
							emit (paged)
						<
					}
				}
	
				if {[N belong 8 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				if {[N belong 8 0 0 {} {} == 0]} {
					>
						emit stripped
					<
				}
	
				if {[N byte 22 0 0 {} {} x {}]} {
					>
						emit {- version %d}
					<
				}
	
				if {[N byte 23 0 0 {} {} x {}]} {
					>
						emit {\b.%d}
					<
				}
	
			<
		}
		322 {
			>
				emit {MIPSEL-BE MIPS-III ECOFF executable}
				switch [Nv beshort 20 0 {} {}] {
					263 {
						>
							emit (impure)
						<
					}
					264 {
						>
							emit (swapped)
						<
					}
					267 {
						>
							emit (paged)
						<
					}
				}
	
				if {[N belong 8 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				if {[N belong 8 0 0 {} {} == 0]} {
					>
						emit stripped
					<
				}
	
				if {[N byte 22 0 0 {} {} x {}]} {
					>
						emit {- version %d}
					<
				}
	
				if {[N byte 23 0 0 {} {} x {}]} {
					>
						emit {\b.%d}
					<
				}
	
			<
		}
		336 {
			>
				emit {mc68k COFF}
				if {[N beshort 18 0 0 {} {} ^ 16]} {
					>
						emit object
					<
				}
	
				if {[N beshort 18 0 0 {} {} & 16]} {
					>
						emit executable
					<
				}
	
				if {[N belong 12 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				if {[S string 168 0 {} {} eq .lowmem]} {
					>
						emit {Apple toolbox}
					<
				}
	
				switch [Nv beshort 20 0 {} {}] {
					263 {
						>
							emit (impure)
						<
					}
					264 {
						>
							emit (pure)
						<
					}
					267 {
						>
							emit {(demand paged)}
						<
					}
					273 {
						>
							emit (standalone)
						<
					}
				}
	
			<
		}
		337 {
			>
				emit {mc68k executable (shared)}
				if {[N belong 12 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		338 {
			>
				emit {mc68k executable (shared demand paged)}
				if {[N belong 12 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		344 {
			>
				emit {SVR2 pure executable (USS/370)}
				if {[N belong 12 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				if {[N belong 24 0 0 {} {} > 0]} {
					>
						emit {- version %d}
					<
				}
	
			<
		}
		345 {
			>
				emit {SVR2 executable (Amdahl-UTS)}
				if {[N belong 12 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				if {[N belong 24 0 0 {} {} > 0]} {
					>
						emit {- version %d}
					<
				}
	
			<
		}
		346 {
			>
				emit {370 XA sysV pure executable}
				if {[N belong 12 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				if {[N beshort 22 0 0 {} {} > 0]} {
					>
						emit {- version %d}
					<
				}
	
				if {[N belong 30 0 0 {} {} > 0]} {
					>
						emit {- 5.2 format}
					<
				}
	
			<
		}
		348 {
			>
				emit {SVR2 pure executable (Amdahl-UTS)}
				if {[N belong 12 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				if {[N belong 24 0 0 {} {} > 0]} {
					>
						emit {- version %d}
					<
				}
	
			<
		}
		349 {
			>
				emit {SVR2 executable (USS/370)}
				if {[N belong 12 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				if {[N belong 24 0 0 {} {} > 0]} {
					>
						emit {- version %d}
					<
				}
	
			<
		}
		351 {
			>
				emit {370 XA sysV executable}
				if {[N belong 12 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				if {[N beshort 22 0 0 {} {} > 0]} {
					>
						emit {- version %d}
					<
				}
	
				if {[N belong 30 0 0 {} {} > 0]} {
					>
						emit {- 5.2 format}
					<
				}
	
			<
		}
		352 {
			>
				emit {MIPSEB ECOFF executable}
				switch [Nv beshort 20 0 {} {}] {
					263 {
						>
							emit (impure)
						<
					}
					264 {
						>
							emit (swapped)
						<
					}
					267 {
						>
							emit (paged)
						<
					}
				}
	
				if {[N belong 8 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				if {[N belong 8 0 0 {} {} == 0]} {
					>
						emit stripped
					<
				}
	
				if {[N byte 22 0 0 {} {} x {}]} {
					>
						emit {- version %d}
					<
				}
	
				if {[N byte 23 0 0 {} {} x {}]} {
					>
						emit {\b.%d}
					<
				}
	
			<
		}
		354 {
			>
				emit {MIPSEL-BE ECOFF executable}
				switch [Nv beshort 20 0 {} {}] {
					263 {
						>
							emit (impure)
						<
					}
					264 {
						>
							emit (swapped)
						<
					}
					267 {
						>
							emit (paged)
						<
					}
				}
	
				if {[N belong 8 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				if {[N belong 8 0 0 {} {} == 0]} {
					>
						emit stripped
					<
				}
	
				if {[N byte 23 0 0 {} {} x {}]} {
					>
						emit {- version %d}
					<
				}
	
				if {[N byte 22 0 0 {} {} x {}]} {
					>
						emit {\b.%d}
					<
				}
	
			<
		}
		355 {
			>
				emit {MIPSEB MIPS-II ECOFF executable}
				switch [Nv beshort 20 0 {} {}] {
					263 {
						>
							emit (impure)
						<
					}
					264 {
						>
							emit (swapped)
						<
					}
					267 {
						>
							emit (paged)
						<
					}
				}
	
				if {[N belong 8 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				if {[N belong 8 0 0 {} {} == 0]} {
					>
						emit stripped
					<
				}
	
				if {[N byte 22 0 0 {} {} x {}]} {
					>
						emit {- version %d}
					<
				}
	
				if {[N byte 23 0 0 {} {} x {}]} {
					>
						emit {\b.%d}
					<
				}
	
			<
		}
		358 {
			>
				emit {MIPSEL-BE MIPS-II ECOFF executable}
				switch [Nv beshort 20 0 {} {}] {
					263 {
						>
							emit (impure)
						<
					}
					264 {
						>
							emit (swapped)
						<
					}
					267 {
						>
							emit (paged)
						<
					}
				}
	
				if {[N belong 8 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				if {[N belong 8 0 0 {} {} == 0]} {
					>
						emit stripped
					<
				}
	
				if {[N byte 22 0 0 {} {} x {}]} {
					>
						emit {- version %d}
					<
				}
	
				if {[N byte 23 0 0 {} {} x {}]} {
					>
						emit {\b.%d}
					<
				}
	
			<
		}
		364 {
			>
				emit {68K BCS executable}
			<
		}
		365 {
			>
				emit {88K BCS executable}
			<
		}
		368 {
			>
				emit {WE32000 COFF}
				if {[N beshort 18 0 0 {} {} ^ 16]} {
					>
						emit object
					<
				}
	
				if {[N beshort 18 0 0 {} {} & 16]} {
					>
						emit executable
					<
				}
	
				if {[N belong 12 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				if {[N beshort 18 0 0 {} {} ^ 4096]} {
					>
						emit {N/A on 3b2/300 w/paging}
					<
				}
	
				if {[N beshort 18 0 0 {} {} & 8192]} {
					>
						emit {32100 required}
					<
				}
	
				if {[N beshort 18 0 0 {} {} & 16384]} {
					>
						emit {and MAU hardware required}
					<
				}
	
				switch [Nv beshort 20 0 {} {}] {
					263 {
						>
							emit (impure)
						<
					}
					264 {
						>
							emit (pure)
						<
					}
					267 {
						>
							emit {(demand paged)}
						<
					}
					291 {
						>
							emit {(target shared library)}
						<
					}
				}
	
				if {[N beshort 22 0 0 {} {} > 0]} {
					>
						emit {- version %d}
					<
				}
	
			<
		}
		369 {
			>
				emit {WE32000 COFF executable (TV)}
				if {[N belong 12 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		378 {
			>
				emit {amd 29k coff noprebar executable}
			<
		}
		384 {
			>
				emit {MIPSEB Ucode}
			<
		}
		386 {
			>
				emit {MIPSEL-BE Ucode}
			<
		}
		392 {
			>
				emit {Tower/XP rel 2 object}
				if {[N belong 12 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				switch [Nv beshort 20 0 {} {}] {
					263 {
						>
							emit executable
						<
					}
					264 {
						>
							emit {pure executable}
						<
					}
				}
	
				if {[N beshort 22 0 0 {} {} > 0]} {
					>
						emit {- version %d}
					<
				}
	
			<
		}
		397 {
			>
				emit {Tower/XP rel 2 object}
				if {[N belong 12 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				switch [Nv beshort 20 0 {} {}] {
					263 {
						>
							emit executable
						<
					}
					264 {
						>
							emit {pure executable}
						<
					}
				}
	
				if {[N beshort 22 0 0 {} {} > 0]} {
					>
						emit {- version %d}
					<
				}
	
			<
		}
		400 {
			>
				emit {Tower/XP rel 3 object}
				if {[N belong 12 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				switch [Nv beshort 20 0 {} {}] {
					263 {
						>
							emit executable
						<
					}
					264 {
						>
							emit {pure executable}
						<
					}
				}
	
				if {[N beshort 22 0 0 {} {} > 0]} {
					>
						emit {- version %d}
					<
				}
	
			<
		}
		404 {
			>
				emit {apollo a88k COFF executable}
				if {[N beshort 18 0 0 {} {} ^ 16384]} {
					>
						emit {not stripped}
					<
				}
	
				if {[N beshort 22 0 0 {} {} > 0]} {
					>
						emit {- version %d}
					<
				}
	
			<
		}
		405 {
			>
				emit {Tower/XP rel 3 object}
				if {[N belong 12 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				switch [Nv beshort 20 0 {} {}] {
					263 {
						>
							emit executable
						<
					}
					264 {
						>
							emit {pure executable}
						<
					}
				}
	
				if {[N beshort 22 0 0 {} {} > 0]} {
					>
						emit {- version %d}
					<
				}
	
			<
		}
		407 {
			>
				emit {Apollo m68k COFF executable}
				if {[N beshort 18 0 0 {} {} ^ 16384]} {
					>
						emit {not stripped}
					<
				}
	
				if {[N beshort 22 0 0 {} {} > 0]} {
					>
						emit {- version %d}
					<
				}
	
			<
		}
		408 {
			>
				emit {Tower32/600/400 68020 object}
				if {[N belong 12 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				switch [Nv beshort 20 0 {} {}] {
					263 {
						>
							emit executable
						<
					}
					264 {
						>
							emit {pure executable}
						<
					}
				}
	
				if {[N beshort 22 0 0 {} {} > 0]} {
					>
						emit {- version %d}
					<
				}
	
			<
		}
		416 {
			>
				emit {Tower32/800 68020}
				if {[N beshort 18 0 0 {} {} & 8192]} {
					>
						emit {w/68881 object}
					<
				}
	
				if {[N beshort 18 0 0 {} {} & 16384]} {
					>
						emit {compatible object}
					<
				}
	
				if {[N beshort 18 0 0 {} {} & 24576]} {
					>
						emit object
					<
				}
	
				switch [Nv beshort 20 0 {} {}] {
					263 {
						>
							emit executable
						<
					}
					267 {
						>
							emit {pure executable}
						<
					}
				}
	
				if {[N belong 12 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				if {[N beshort 22 0 0 {} {} > 0]} {
					>
						emit {- version %d}
					<
				}
	
			<
		}
		421 {
			>
				emit {Tower32/800 68010}
				if {[N beshort 18 0 0 {} {} & 16384]} {
					>
						emit {compatible object}
					<
				}
	
				if {[N beshort 18 0 0 {} {} & 24576]} {
					>
						emit object
					<
				}
	
				switch [Nv beshort 20 0 {} {}] {
					263 {
						>
							emit executable
						<
					}
					267 {
						>
							emit {pure executable}
						<
					}
				}
	
				if {[N belong 12 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				if {[N beshort 22 0 0 {} {} > 0]} {
					>
						emit {- version %d}
					<
				}
	
			<
		}
		474 {
			>
				emit {SGI image data}
				if {[N byte 2 0 0 {} {} == 1]} {
					>
						emit {\b, RLE}
					<
				}
	
				if {[N byte 3 0 0 {} {} == 2]} {
					>
						emit {\b, high precision}
					<
				}
	
				if {[N beshort 4 0 0 {} {} x {}]} {
					>
						emit {\b, %d-D}
					<
				}
	
				if {[N beshort 6 0 0 {} {} x {}]} {
					>
						emit {\b, %d x}
					<
				}
	
				if {[N beshort 8 0 0 {} {} x {}]} {
					>
						emit %d
					<
				}
	
				if {[N beshort 10 0 0 {} {} x {}]} {
					>
						emit {\b, %d channel}
					<
				}
	
				if {[N beshort 10 0 0 {} {} != 1]} {
					>
						emit {\bs}
					<
				}
	
				if {[S string 80 0 {} {} > 0]} {
					>
						emit {\b, "%s"}
					<
				}
	
			<
		}
		479 {
			>
				emit {executable (RISC System/6000 V3.1) or obj module}
				if {[N belong 12 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		503 {
			>
				emit {64-bit XCOFF executable or object module}
				if {[N belong 20 0 0 {} {} == 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		518 {
			>
				emit {ALAN game data}
				if {[N byte 2 0 0 {} {} < 10]} {
					>
						emit {version 2.6%d}
					<
				}
	
			<
		}
		550 {
			>
				emit {IRIS Showcase template}
				if {[N byte 2 0 0 {} {} == 99]} {
					>
						emit -
					<
				}
	
				if {[N byte 3 0 0 {} {} x {}]} {
					>
						emit {- version %d}
					<
				}
	
			<
		}
		890 {
			>
				emit {amd 29k coff prebar executable}
			<
		}
		1280 {
			>
				if {[N ubeshort 18 0 0 & 36480 == 0]} {
					>
						U 104 display-coff 0
	
					<
				}
	
			<
		}
		1286 {
			>
				emit {IRIS Showcase file}
				if {[N byte 2 0 0 {} {} == 73]} {
					>
						emit -
					<
				}
	
				if {[N byte 3 0 0 {} {} x {}]} {
					>
						emit {- version %d}
					<
				}
	
			<
		}
		2057 {
			>
				emit {Bentley/Intergraph MicroStation}
				if {[N byte 2 0 0 {} {} == -2]} {
					>
						if {[N beshort 4 0 0 {} {} == 6144]} {
							>
								emit {CIT raster CAD}
							<
						}
	
					<
				}
	
			<
		}
		2935 {
			>
				emit {ATSC A/52 aka AC-3 aka Dolby Digital stream,}
				mime audio/vnd.dolby.dd-raw
				switch [Nv byte 4 0 & -64] {
					-128 {
						>
							emit {32 kHz,}
						<
					}
					-64 {
						>
							emit {reserved frequency,}
						<
					}
					0 {
						>
							emit {48 kHz,}
						<
					}
					64 {
						>
							emit {44.1 kHz,}
						<
					}
				}
	
				switch [Nv byte 5 0 & 7] {
					0 {
						>
							emit {\b, complete main (CM)}
						<
					}
					1 {
						>
							emit {\b, music and effects (ME)}
						<
					}
					2 {
						>
							emit {\b, visually impaired (VI)}
						<
					}
					3 {
						>
							emit {\b, hearing impaired (HI)}
						<
					}
					4 {
						>
							emit {\b, dialogue (D)}
						<
					}
					5 {
						>
							emit {\b, commentary (C)}
						<
					}
					6 {
						>
							emit {\b, emergency (E)}
						<
					}
				}
	
				if {[N beshort 5 0 0 & 2016 == 1824]} {
					>
						emit {\b, voiceover (VO)}
					<
				}
	
				if {[N beshort 5 0 0 & 2016 > 1824]} {
					>
						emit {\b, karaoke}
					<
				}
	
				switch [Nv byte 6 0 & -32] {
					-128 {
						>
							emit {2 front/1 rear,}
							if {[N byte 6 0 0 & 4 == 4]} {
								>
									emit {LFE on,}
								<
							}
	
						<
					}
					-96 {
						>
							emit {3 front/1 rear,}
							if {[N byte 6 0 0 & 1 == 1]} {
								>
									emit {LFE on,}
								<
							}
	
						<
					}
					-64 {
						>
							emit {2 front/2 rear,}
							if {[N byte 6 0 0 & 4 == 4]} {
								>
									emit {LFE on,}
								<
							}
	
						<
					}
					-32 {
						>
							emit {3 front/2 rear,}
							if {[N byte 6 0 0 & 1 == 1]} {
								>
									emit {LFE on,}
								<
							}
	
						<
					}
					0 {
						>
							emit {1+1 front,}
							if {[N byte 6 0 0 & 16 == 16]} {
								>
									emit {LFE on,}
								<
							}
	
						<
					}
					32 {
						>
							emit {1 front/0 rear,}
							if {[N byte 6 0 0 & 16 == 16]} {
								>
									emit {LFE on,}
								<
							}
	
						<
					}
					64 {
						>
							emit {2 front/0 rear,}
							switch [Nv byte 6 0 & 24] {
								0 {
									>
										emit {Dolby Surround not indicated}
									<
								}
								8 {
									>
										emit {not Dolby Surround encoded}
									<
								}
								16 {
									>
										emit {Dolby Surround encoded}
									<
								}
								24 {
									>
										emit {reserved Dolby Surround mode}
									<
								}
							}
	
							if {[N byte 6 0 0 & 4 == 4]} {
								>
									emit {LFE on,}
								<
							}
	
						<
					}
					96 {
						>
							emit {3 front/0 rear,}
							if {[N byte 6 0 0 & 4 == 4]} {
								>
									emit {LFE on,}
								<
							}
	
						<
					}
				}
	
				switch [Nv byte 4 0 & 62] {
					0 {
						>
							emit {\b, 32 kbit/s}
						<
					}
					2 {
						>
							emit {\b, 40 kbit/s}
						<
					}
					4 {
						>
							emit {\b, 48 kbit/s}
						<
					}
					6 {
						>
							emit {\b, 56 kbit/s}
						<
					}
					8 {
						>
							emit {\b, 64 kbit/s}
						<
					}
					10 {
						>
							emit {\b, 80 kbit/s}
						<
					}
					12 {
						>
							emit {\b, 96 kbit/s}
						<
					}
					14 {
						>
							emit {\b, 112 kbit/s}
						<
					}
					16 {
						>
							emit {\b, 128 kbit/s}
						<
					}
					18 {
						>
							emit {\b, 160 kbit/s}
						<
					}
					20 {
						>
							emit {\b, 192 kbit/s}
						<
					}
					22 {
						>
							emit {\b, 224 kbit/s}
						<
					}
					24 {
						>
							emit {\b, 256 kbit/s}
						<
					}
					26 {
						>
							emit {\b, 320 kbit/s}
						<
					}
					28 {
						>
							emit {\b, 384 kbit/s}
						<
					}
					30 {
						>
							emit {\b, 448 kbit/s}
						<
					}
					32 {
						>
							emit {\b, 512 kbit/s}
						<
					}
					34 {
						>
							emit {\b, 576 kbit/s}
						<
					}
					36 {
						>
							emit {\b, 640 kbit/s}
						<
					}
				}
	
			<
		}
		3599 {
			>
				emit {Atari MSA archive data}
				if {[N beshort 2 0 0 {} {} x {}]} {
					>
						emit {\b, %d sectors per track}
					<
				}
	
				switch [Nv beshort 4 0 {} {}] {
					0 {
						>
							emit {\b, 1 sided}
						<
					}
					1 {
						>
							emit {\b, 2 sided}
						<
					}
				}
	
				if {[N beshort 6 0 0 {} {} x {}]} {
					>
						emit {\b, starting track: %d}
					<
				}
	
				if {[N beshort 8 0 0 {} {} x {}]} {
					>
						emit {\b, ending track: %d}
					<
				}
	
			<
		}
		3840 {
			>
				emit {AmigaOS bitmap font}
			<
		}
		3843 {
			>
				emit {AmigaOS outline font}
			<
		}
		4112 {
			>
				emit {PEX Binary Archive}
			<
		}
		5493 {
			>
				emit {fsav macro virus signatures}
				if {[N leshort 8 0 0 {} {} > 0]} {
					>
						emit (%d-
					<
				}
	
				if {[N byte 11 0 0 {} {} > 0]} {
					>
						emit {\b%02d-}
					<
				}
	
				if {[N byte 10 0 0 {} {} > 0]} {
					>
						emit {\b%02d)}
					<
				}
	
			<
		}
		14541 {
			>
				emit {C64 PCLink Image}
			<
		}
		16385 {
			>
				emit {MIPSEB-LE MIPS-III ECOFF executable}
				switch [Nv beshort 20 0 {} {}] {
					1793 {
						>
							emit (impure)
						<
					}
					2049 {
						>
							emit (swapped)
						<
					}
					2817 {
						>
							emit (paged)
						<
					}
				}
	
				if {[N belong 8 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				if {[N belong 8 0 0 {} {} == 0]} {
					>
						emit stripped
					<
				}
	
				if {[N byte 23 0 0 {} {} x {}]} {
					>
						emit {- version %d}
					<
				}
	
				if {[N byte 22 0 0 {} {} x {}]} {
					>
						emit {\b.%d}
					<
				}
	
			<
		}
		16897 {
			>
				emit {MIPSEL MIPS-III ECOFF executable}
				switch [Nv beshort 20 0 {} {}] {
					1793 {
						>
							emit (impure)
						<
					}
					2049 {
						>
							emit (swapped)
						<
					}
					2817 {
						>
							emit (paged)
						<
					}
				}
	
				if {[N belong 8 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				if {[N belong 8 0 0 {} {} == 0]} {
					>
						emit stripped
					<
				}
	
				if {[N byte 23 0 0 {} {} x {}]} {
					>
						emit {- version %d}
					<
				}
	
				if {[N byte 22 0 0 {} {} x {}]} {
					>
						emit {\b.%d}
					<
				}
	
			<
		}
		17746 {
			>
				if {[N ubeshort 2 0 0 & 61951 == 0]} {
					>
						emit {Apple Driver Map}
						if {[N beshort 2 0 0 {} {} x {}]} {
							>
								emit {\b, blocksize %d}
							<
						}
	
						if {[N ubelong 4 0 0 {} {} x {}]} {
							>
								emit {\b, blockcount %u}
							<
						}
	
						if {[N ubeshort 8 0 0 {} {} x {}]} {
							>
								emit {\b, devtype %u}
							<
						}
	
						if {[N ubeshort 10 0 0 {} {} x {}]} {
							>
								emit {\b, devid %u}
							<
						}
	
						if {[N ubelong 12 0 0 {} {} > 0]} {
							>
								if {[N ubelong 12 0 0 {} {} x {}]} {
									>
										emit {\b, driver data %u}
									<
								}
	
							<
						}
	
						if {[N ubeshort 16 0 0 {} {} x {}]} {
							>
								emit {\b, driver count %u}
							<
						}
	
						if {[N ubelong 516 0 0 {} {} > 0]} {
							>
								emit {\b, contains[@0x200]:}
								U 12 apple-apm 512
	
							<
						}
	
						if {[N ubelong 516 0 0 {} {} > 1]} {
							>
								emit {\b, contains[@0x400]:}
								U 12 apple-apm 1024
	
							<
						}
	
						if {[N ubelong 516 0 0 {} {} > 2]} {
							>
								emit {\b, contains[@0x600]:}
								U 12 apple-apm 1536
	
							<
						}
	
						if {[N ubelong 516 0 0 {} {} > 3]} {
							>
								emit {\b, contains[@0x800]:}
								U 12 apple-apm 2048
	
							<
						}
	
						if {[N ubelong 516 0 0 {} {} > 4]} {
							>
								emit {\b, contains[@0xA00]:}
								U 12 apple-apm 2560
	
							<
						}
	
						if {[N ubelong 516 0 0 {} {} > 5]} {
							>
								emit {\b, contains[@0xC00]:}
								U 12 apple-apm 3072
	
							<
						}
	
						if {[N ubelong 516 0 0 {} {} > 6]} {
							>
								emit {\b, contains[@0xE00]:}
								U 12 apple-apm 3584
	
							<
						}
	
						if {[N ubelong 516 0 0 {} {} > 7]} {
							>
								emit {\b, contains[@0x1000]:}
								U 12 apple-apm 4096
	
							<
						}
	
						mime application/x-apple-diskimage
						ext dmg/iso
					<
				}
	
			<
		}
		19196 {
			>
				emit {OS9/68K module:}
				if {[N byte 20 0 0 & -128 == -128]} {
					>
						emit re-entrant
					<
				}
	
				if {[N byte 20 0 0 & 64 == 64]} {
					>
						emit ghost
					<
				}
	
				if {[N byte 20 0 0 & 32 == 32]} {
					>
						emit system-state
					<
				}
	
				switch [Nv byte 19 0 {} {}] {
					1 {
						>
							emit {machine language}
						<
					}
					2 {
						>
							emit {BASIC I-code}
						<
					}
					3 {
						>
							emit {Pascal P-code}
						<
					}
					4 {
						>
							emit {C I-code}
						<
					}
					5 {
						>
							emit {COBOL I-code}
						<
					}
					6 {
						>
							emit {Fortran I-code}
						<
					}
				}
	
				switch [Nv byte 18 0 {} {}] {
					1 {
						>
							emit {program executable}
						<
					}
					2 {
						>
							emit subroutine
						<
					}
					3 {
						>
							emit multi-module
						<
					}
					4 {
						>
							emit {data module}
						<
					}
					11 {
						>
							emit {trap library}
						<
					}
					12 {
						>
							emit {system module}
						<
					}
					13 {
						>
							emit {file manager}
						<
					}
					14 {
						>
							emit {device driver}
						<
					}
					15 {
						>
							emit {device descriptor}
						<
					}
				}
	
			<
		}
		21930 {
			>
				emit {BIOS (ia32) ROM Ext.}
				mime application/octet-stream
				ext rom/bin
				if {[S string 5 0 {} {} eq USB]} {
					>
						emit USB
					<
				}
	
				if {[S string 7 0 {} {} eq LDR]} {
					>
						emit {UNDI image}
					<
				}
	
				if {[S string 30 0 {} {} eq IBM]} {
					>
						emit {IBM comp. Video}
					<
				}
	
				if {[S string 26 0 {} {} eq Adaptec]} {
					>
						emit Adaptec
					<
				}
	
				if {[S string 28 0 {} {} eq Adaptec]} {
					>
						emit Adaptec
					<
				}
	
				if {[S string 42 0 {} {} eq PROMISE]} {
					>
						emit Promise
					<
				}
	
				if {[N byte 2 0 0 {} {} x {}]} {
					>
						emit (%d*512)
					<
				}
	
			<
		}
		22529 {
			>
				emit {370 sysV pure executable}
				if {[N belong 12 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		23041 {
			>
				emit {370 XA sysV pure executable}
				if {[N belong 12 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		23809 {
			>
				emit {370 sysV executable}
				if {[N belong 12 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		24321 {
			>
				emit {370 XA sysV executable}
				if {[N belong 12 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		24577 {
			>
				emit {MIPSEB-LE ECOFF executable}
				switch [Nv beshort 20 0 {} {}] {
					1793 {
						>
							emit (impure)
						<
					}
					2049 {
						>
							emit (swapped)
						<
					}
					2817 {
						>
							emit (paged)
						<
					}
				}
	
				if {[N belong 8 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				if {[N belong 8 0 0 {} {} == 0]} {
					>
						emit stripped
					<
				}
	
				if {[N byte 23 0 0 {} {} x {}]} {
					>
						emit {- version %d}
					<
				}
	
				if {[N byte 22 0 0 {} {} x {}]} {
					>
						emit {\b.%d}
					<
				}
	
			<
		}
		24602 {
			>
				emit {Atari 68xxx executable,}
				if {[N belong 2 0 0 {} {} x {}]} {
					>
						emit {text len %u,}
					<
				}
	
				if {[N belong 6 0 0 {} {} x {}]} {
					>
						emit {data len %u,}
					<
				}
	
				if {[N belong 10 0 0 {} {} x {}]} {
					>
						emit {BSS len %u,}
					<
				}
	
				if {[N belong 14 0 0 {} {} x {}]} {
					>
						emit {symboltab len %u,}
					<
				}
	
				if {[N belong 18 0 0 {} {} == 0]} {
					>
					<
				}
	
				if {[N belong 22 0 0 {} {} & 1]} {
					>
						emit {fastload flag,}
					<
				}
	
				if {[N belong 22 0 0 {} {} & 2]} {
					>
						emit {may be loaded to alternate RAM,}
					<
				}
	
				if {[N belong 22 0 0 {} {} & 4]} {
					>
						emit {malloc may be from alternate RAM,}
					<
				}
	
				if {[N belong 22 0 0 {} {} x {}]} {
					>
						emit {flags: 0x%X,}
					<
				}
	
				if {[N beshort 26 0 0 {} {} == 0]} {
					>
						emit {no relocation tab}
					<
				}
	
				if {[N beshort 26 0 0 {} {} != 0]} {
					>
						emit {+ relocation tab}
					<
				}
	
				if {[S string 30 0 {} {} eq SFX]} {
					>
						emit {[Self-Extracting LZH SFX archive]}
					<
				}
	
				if {[S string 38 0 {} {} eq SFX]} {
					>
						emit {[Self-Extracting LZH SFX archive]}
					<
				}
	
				if {[S string 44 0 {} {} eq ZIP!]} {
					>
						emit {[Self-Extracting ZIP SFX archive]}
					<
				}
	
			<
		}
		25089 {
			>
				emit {MIPSEL ECOFF executable}
				switch [Nv beshort 20 0 {} {}] {
					1793 {
						>
							emit (impure)
						<
					}
					2049 {
						>
							emit (swapped)
						<
					}
					2817 {
						>
							emit (paged)
						<
					}
				}
	
				if {[N belong 8 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				if {[N belong 8 0 0 {} {} == 0]} {
					>
						emit stripped
					<
				}
	
				if {[N byte 23 0 0 {} {} x {}]} {
					>
						emit {- version %d}
					<
				}
	
				if {[N byte 22 0 0 {} {} x {}]} {
					>
						emit {\b.%d}
					<
				}
	
			<
		}
		25345 {
			>
				emit {MIPSEB-LE MIPS-II ECOFF executable}
				switch [Nv beshort 20 0 {} {}] {
					1793 {
						>
							emit (impure)
						<
					}
					2049 {
						>
							emit (swapped)
						<
					}
					2817 {
						>
							emit (paged)
						<
					}
				}
	
				if {[N belong 8 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				if {[N belong 8 0 0 {} {} == 0]} {
					>
						emit stripped
					<
				}
	
				if {[N byte 23 0 0 {} {} x {}]} {
					>
						emit {- version %d}
					<
				}
	
				if {[N byte 22 0 0 {} {} x {}]} {
					>
						emit {\b.%d}
					<
				}
	
			<
		}
		26113 {
			>
				emit {MIPSEL MIPS-II ECOFF executable}
				switch [Nv beshort 20 0 {} {}] {
					1793 {
						>
							emit (impure)
						<
					}
					2049 {
						>
							emit (swapped)
						<
					}
					2817 {
						>
							emit (paged)
						<
					}
				}
	
				if {[N belong 8 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				if {[N belong 8 0 0 {} {} == 0]} {
					>
						emit stripped
					<
				}
	
				if {[N byte 23 0 0 {} {} x {}]} {
					>
						emit {- version %d}
					<
				}
	
				if {[N byte 22 0 0 {} {} x {}]} {
					>
						emit {\b.%d}
					<
				}
	
			<
		}
		30461 {
			>
				emit {LZH compressed data,}
				if {[S string 2 0 {} {} x {}]} {
					>
						emit {original name %s}
					<
				}
	
			<
		}
		30462 {
			>
				emit {crunched data,}
				if {[S string 2 0 {} {} x {}]} {
					>
						emit {original name %s}
					<
				}
	
			<
		}
		30463 {
			>
				emit {squeezed data,}
				if {[S string 4 0 {} {} x {}]} {
					>
						emit {original name %s}
					<
				}
	
			<
		}
		32639 {
			>
				emit {RDI Acoustic Doppler Current Profiler (ADCP)}
			<
		}
	}
	
	if {[N ubyte 0 0 0 {} {} > 0]} {
		>
			if {[N ubyte 0 0 0 {} {} < 9]} {
				>
					if {[N belong 16 0 0 & -33492752 == 12336]} {
						>
							if {[N ubyte 0 0 0 {} {} < 10]} {
								>
									if {[N ubeshort 2 0 0 {} {} x {}]} {
										>
											if {[S regex 18 0 {} {} eq \[0-9\]\[0-9\]\[0-9\]\[0-9\]\[0-9\]\[0-9\]]} {
												>
													if {[N ubyte 0 0 0 {} {} < 10]} {
														>
															emit {Infocom (Z-machine %d}
															if {[N ubeshort 2 0 0 {} {} x {}]} {
																>
																	emit {\b, Release %d}
																	if {[S string 18 0 {} {} > \0]} {
																		>
																			emit {\b, Serial %.6s}
																		<
																	}
	
																	if {[S string 18 0 {} {} x {}]} {
																		>
																			emit {\b)}
																			mime application/x-zmachine
																			strength {+ 40}
																		<
																	}
	
																<
															}
	
														<
													}
	
												<
											}
	
										<
									}
	
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq Glul]} {
		>
			emit {Glulx game data}
			if {[N beshort 4 0 0 {} {} x {}]} {
				>
					emit {(Version %d}
					if {[N byte 6 0 0 {} {} x {}]} {
						>
							emit {\b.%d}
						<
					}
	
					if {[N byte 8 0 0 {} {} x {}]} {
						>
							emit {\b.%d)}
						<
					}
	
				<
			}
	
			if {[S string 36 0 {} {} eq Info]} {
				>
					emit {Compiled by Inform}
					mime application/x-glulx
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq TADS2\ bin]} {
		>
			emit TADS
			if {[N belong 9 0 0 {} {} != 168630784]} {
				>
					emit {game data, CORRUPTED}
				<
			}
	
			if {[N belong 9 0 0 {} {} == 168630784]} {
				>
					if {[S string 13 0 {} {} > \0]} {
						>
							emit {%s game data}
							mime application/x-tads
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq TADS2\ rsc]} {
		>
			emit TADS
			if {[N belong 9 0 0 {} {} != 168630784]} {
				>
					emit {resource data, CORRUPTED}
				<
			}
	
			if {[N belong 9 0 0 {} {} == 168630784]} {
				>
					if {[S string 13 0 {} {} > \0]} {
						>
							emit {%s resource data}
							mime application/x-tads
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq TADS2\ save/g]} {
		>
			emit TADS
			if {[N belong 12 0 0 {} {} != 168630784]} {
				>
					emit {saved game data, CORRUPTED}
				<
			}
	
			if {[N belong 12 0 0 {} {} == 168630784]} {
				>
					if {[S string [I 16 uleshort 0 + 0 32] 0 {} {} > \0]} {
						>
							emit {%s saved game data}
							mime application/x-tads
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq TADS2\ save]} {
		>
			emit TADS
			if {[N belong 10 0 0 {} {} != 168630784]} {
				>
					emit {saved game data, CORRUPTED}
				<
			}
	
			if {[N belong 10 0 0 {} {} == 168630784]} {
				>
					if {[S string 14 0 {} {} > \0]} {
						>
							emit {%s saved game data}
							mime application/x-tads
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq T3-image\015\012\032]} {
		>
			if {[N leshort 11 0 0 {} {} x {}]} {
				>
					emit {TADS 3 game data (format version %d)}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq T3-state-v]} {
		>
			if {[S string 14 0 {} {} eq \015\012\032]} {
				>
					emit {TADS 3 saved game data (format version}
					if {[N byte 10 0 0 {} {} x {}]} {
						>
							emit %c
						<
					}
	
					if {[N byte 11 0 0 {} {} x {}]} {
						>
							emit {\b%c}
						<
					}
	
					if {[N byte 12 0 0 {} {} x {}]} {
						>
							emit {\b%c}
						<
					}
	
					if {[N byte 13 0 0 {} {} x {}]} {
						>
							emit {\b%c)}
							mime application/x-t3vm-image
						<
					}
	
				<
			}
	
		<
	}
	
	switch [Nv belong 0 0 {} {}] {
		-2147479551 {
			>
				emit {AmigaOS outline tag}
			<
		}
		-2017063670 {
			>
				emit {python 2.0 byte-compiled}
			<
		}
		-1991489968 {
			>
				if {[N belong 4 0 0 {} {} == 218765834]} {
					>
					<
				}
	
				if {[N belong 12 0 0 {} {} == 0]} {
					>
						emit {Lytro Light Field Picture}
					<
				}
	
				if {[N belong 8 0 0 {} {} x {}]} {
					>
						emit {\b, version %d}
					<
				}
	
			<
		}
		-1728153892 {
			>
				if {[N ubeshort 4 0 0 {} {} < 10]} {
					>
						emit {APT cache data, version %u}
						if {[N ubeshort 6 0 0 {} {} x {}]} {
							>
								emit {\b.%u, 32 bit big-endian}
							<
						}
	
						U 15 apt-cache-32bit-be 0
	
					<
				}
	
				if {[N ubyte 4 0 0 {} {} > 9]} {
					>
						emit {APT cache data, version %u}
						if {[N ubyte 5 0 0 {} {} x {}]} {
							>
								emit {\b.%u, big-endian}
							<
						}
	
						U 15 apt-cache-be 0
	
					<
				}
	
			<
		}
		-1722938102 {
			>
				emit {python 1.5/1.6 byte-compiled}
			<
		}
		-1643377398 {
			>
				emit {python 3.3 byte-compiled}
			<
		}
		-1374734174 {
			>
				if {[N belong 12 0 0 {} {} == 1048576]} {
					>
						if {[N belong [I 8 ubelong 0 + 0 28] 0 0 {} {} == -1036804291]} {
							>
								emit {Nintendo GameCube embedded disc image:}
								U 51 nintendo-gcn-disc-common [I 8 ubelong 0 + 0 0]
	
								mime application/x-gamecube-rom
							<
						}
	
					<
				}
	
			<
		}
		-1275982582 {
			>
				emit {python 2.5 byte-compiled}
			<
		}
		-1195374706 {
			>
				emit {Linux kernel}
				if {[S string 483 0 {} {} eq Loading]} {
					>
						emit {version 1.3.79 or older}
					<
				}
	
				if {[S string 489 0 {} {} eq Loading]} {
					>
						emit {from prehistoric times}
					<
				}
	
			<
			>
				emit Linux
				if {[N belong 486 0 0 {} {} == 1162627923]} {
					>
						emit {ELKS Kernel}
					<
				}
	
				if {[N belong 486 0 0 {} {} != 1162627923]} {
					>
						emit {style boot sector}
					<
				}
	
			<
		}
		-1161903941 {
			>
				emit {IRIX N32 core dump}
				if {[N belong 4 0 0 {} {} == 1]} {
					>
						emit of
					<
				}
	
				if {[S string 16 0 {} {} > \0]} {
					>
						emit '%s'
					<
				}
	
			<
		}
		-1059131379 {
			>
				emit {GStreamer binary registry}
				if {[S string 4 0 {} {} x {}]} {
					>
						emit {\b, version %s}
					<
				}
	
			<
		}
		-1040441407 {
			>
				emit {Common Trace Format (CTF) trace data (BE)}
			<
		}
		-976170042 {
			>
				emit {DOS EPS Binary File}
				mime image/x-eps
				if {[N long 4 0 0 {} {} > 0]} {
					>
						emit {Postscript starts at byte %d}
						if {[N long 8 0 0 {} {} > 0]} {
							>
								emit {length %d}
								if {[N long 12 0 0 {} {} > 0]} {
									>
										emit {Metafile starts at byte %d}
										if {[N long 16 0 0 {} {} > 0]} {
											>
												emit {length %d}
											<
										}
	
									<
								}
	
								if {[N long 20 0 0 {} {} > 0]} {
									>
										emit {TIFF starts at byte %d}
										if {[N long 24 0 0 {} {} > 0]} {
											>
												emit {length %d}
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
			<
			>
				emit {DOS EPS Binary File}
				if {[N long 4 0 0 {} {} > 0]} {
					>
						emit {Postscript starts at byte %d}
						if {[N long 8 0 0 {} {} > 0]} {
							>
								emit {length %d}
								if {[N long 12 0 0 {} {} > 0]} {
									>
										emit {Metafile starts at byte %d}
										if {[N long 16 0 0 {} {} > 0]} {
											>
												emit {length %d}
											<
										}
	
									<
								}
	
								if {[N long 20 0 0 {} {} > 0]} {
									>
										emit {TIFF starts at byte %d}
										if {[N long 24 0 0 {} {} > 0]} {
											>
												emit {length %d}
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
			<
		}
		-951729837 {
			>
				emit GEOS
				switch [Nv byte 40 0 {} {}] {
					1 {
						>
							emit executable
						<
					}
					2 {
						>
							emit VMFile
						<
					}
					3 {
						>
							emit binary
						<
					}
					4 {
						>
							emit {directory label}
						<
					}
				}
	
				if {[N byte 40 0 0 {} {} < 1]} {
					>
						emit unknown
					<
				}
	
				if {[N byte 40 0 0 {} {} > 4]} {
					>
						emit unknown
					<
				}
	
				if {[S string 4 0 {} {} > \0]} {
					>
						emit {\b, name "%s"}
					<
				}
	
			<
		}
		-938869246 {
			>
				emit {Bentley/Intergraph MicroStation DGN vector CAD}
			<
		}
		-889275714 {
			>
				if {[N belong 4 0 0 {} {} > 30]} {
					>
						emit {compiled Java class data,}
						if {[N beshort 6 0 0 {} {} x {}]} {
							>
								emit {version %d.}
							<
						}
	
						if {[N beshort 4 0 0 {} {} x {}]} {
							>
								emit {\b%d}
							<
						}
	
						switch [Nv belong 4 0 {} {}] {
							46 {
								>
									emit {(Java 1.2)}
								<
							}
							47 {
								>
									emit {(Java 1.3)}
								<
							}
							48 {
								>
									emit {(Java 1.4)}
								<
							}
							49 {
								>
									emit {(Java 1.5)}
								<
							}
							50 {
								>
									emit {(Java 1.6)}
								<
							}
							51 {
								>
									emit {(Java 1.7)}
								<
							}
							52 {
								>
									emit {(Java 1.8)}
								<
							}
						}
	
						mime application/x-java-applet
					<
				}
	
			<
			>
				if {[N belong 4 0 0 {} {} == 1]} {
					>
						emit {Mach-O universal binary with 1 architecture:}
						U 37 mach-o 8
	
						mime application/x-mach-binary
					<
				}
	
				if {[N belong 4 0 0 {} {} > 1]} {
					>
						if {[N belong 4 0 0 {} {} < 20]} {
							>
								emit {Mach-O universal binary with %d architectures:}
								U 37 mach-o 8
	
								mime application/x-mach-binary
							<
						}
	
						switch [Nv belong 4 0 {} {}] {
							2 {
								>
									U 37 mach-o 28
	
								<
							}
							3 {
								>
									U 37 mach-o 48
	
								<
							}
							4 {
								>
									U 37 mach-o 68
	
								<
							}
							5 {
								>
									U 37 mach-o 88
	
								<
							}
							6 {
								>
									U 37 mach-o 108
	
								<
							}
						}
	
					<
				}
	
			<
		}
		-889270259 {
			>
				emit {JAR compressed with pack200,}
				if {[N byte 5 0 0 {} {} x {}]} {
					>
						emit {version %d.}
					<
				}
	
				if {[N byte 4 0 0 {} {} x {}]} {
					>
						emit {\b%d}
						mime application/x-java-pack200
					<
				}
	
			<
			>
				emit {JAR compressed with pack200,}
				if {[N byte 5 0 0 {} {} x {}]} {
					>
						emit {version %d.}
					<
				}
	
				if {[N byte 4 0 0 {} {} x {}]} {
					>
						emit {\b%d}
						mime application/x-java-pack200
					<
				}
	
			<
		}
		-825307442 {
			>
				emit {Java JCE KeyStore}
				mime application/x-java-jce-keystore
			<
		}
		-804389139 {
			>
				if {[N byte [R [I 8 ubelong 0 + 0 0]] 0 0 {} {} x {}]} {
					>
						if {[N byte [R [I 12 ubelong 0 + 0 0]] 0 0 {} {} x {}]} {
							>
								if {[N belong 20 0 0 {} {} > 1]} {
									>
										emit {Device Tree Blob version %d}
										if {[N belong 4 0 0 {} {} x {}]} {
											>
												emit {\b, size=%d}
											<
										}
	
										if {[N belong 20 0 0 {} {} > 1]} {
											>
												if {[N belong 28 0 0 {} {} x {}]} {
													>
														emit {\b, boot CPU=%d}
													<
												}
	
											<
										}
	
										if {[N belong 20 0 0 {} {} > 2]} {
											>
												if {[N belong 32 0 0 {} {} x {}]} {
													>
														emit {\b, string block size=%d}
													<
												}
	
											<
										}
	
										if {[N belong 20 0 0 {} {} > 16]} {
											>
												if {[N belong 36 0 0 {} {} x {}]} {
													>
														emit {\b, DT structure block size=%d}
													<
												}
	
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
			<
		}
		-772666102 {
			>
				emit {python 2.6 byte-compiled}
			<
		}
		-559043264 {
			>
				emit {IRIX 64-bit core dump}
				if {[N belong 4 0 0 {} {} == 1]} {
					>
						emit of
					<
				}
	
				if {[S string 16 0 {} {} > \0]} {
					>
						emit '%s'
					<
				}
	
			<
		}
		-559043152 {
			>
				emit {IRIX core dump}
				if {[N belong 4 0 0 {} {} == 1]} {
					>
						emit of
					<
				}
	
				if {[S string 16 0 {} {} > \0]} {
					>
						emit '%s'
					<
				}
	
			<
		}
		-559039810 {
			>
				emit {IRIX Parallel Arena}
				if {[N belong 8 0 0 {} {} > 0]} {
					>
						emit {- version %d}
					<
				}
	
			<
		}
		-364936773 {
			>
				emit {Conary changeset data}
			<
		}
		-307499301 {
			>
				emit RPM
				mime application/x-rpm
				if {[N byte 4 0 0 {} {} x {}]} {
					>
						emit v%d
					<
				}
	
				if {[N byte 5 0 0 {} {} x {}]} {
					>
						emit {\b.%d}
					<
				}
	
				switch [Nv beshort 6 0 {} {}] {
					0 {
						>
							emit bin
							switch [Nv beshort 8 0 {} {}] {
								1 {
									>
										emit i386/x86_64
									<
								}
								2 {
									>
										emit Alpha/Sparc64
									<
								}
								3 {
									>
										emit Sparc
									<
								}
								4 {
									>
										emit MIPS
									<
								}
								5 {
									>
										emit PowerPC
									<
								}
								6 {
									>
										emit 68000
									<
								}
								7 {
									>
										emit SGI
									<
								}
								8 {
									>
										emit RS6000
									<
								}
								9 {
									>
										emit IA64
									<
								}
								10 {
									>
										emit Sparc64
									<
								}
								11 {
									>
										emit MIPSel
									<
								}
								12 {
									>
										emit ARM
									<
								}
								13 {
									>
										emit MiNT
									<
								}
								14 {
									>
										emit S/390
									<
								}
								15 {
									>
										emit S/390x
									<
								}
								16 {
									>
										emit PowerPC64
									<
								}
								17 {
									>
										emit SuperH
									<
								}
								18 {
									>
										emit Xtensa
									<
								}
								255 {
									>
										emit noarch
									<
								}
							}
	
						<
					}
					1 {
						>
							emit src
						<
					}
				}
	
			<
		}
		-302060034 {
			>
				emit {Sun 'jks' Java Keystore File data}
			<
		}
		-301200118 {
			>
				emit {python 3.4 byte-compiled}
			<
		}
		-249691108 {
			>
				emit {magic binary file for file(1) cmd}
				if {[N belong 4 0 0 {} {} x {}]} {
					>
						emit {(version %d) (big endian)}
					<
				}
	
			<
		}
		-86111232 {
			>
				emit {Mac OS X Code Requirement}
				if {[N belong 8 0 0 {} {} == 1]} {
					>
						emit (opExpr)
					<
				}
	
				if {[N belong 4 0 0 {} {} x {}]} {
					>
						emit {- %d bytes}
					<
				}
	
			<
		}
		-86111231 {
			>
				emit {Mac OS X Code Requirement Set}
				if {[N belong 8 0 0 {} {} > 1]} {
					>
						emit {containing %d items}
					<
				}
	
				if {[N belong 4 0 0 {} {} x {}]} {
					>
						emit {- %d bytes}
					<
				}
	
			<
		}
		-86111230 {
			>
				emit {Mac OS X Code Directory}
				if {[N belong 8 0 0 {} {} x {}]} {
					>
						emit {version %x}
					<
				}
	
				if {[N belong 12 0 0 {} {} > 0]} {
					>
						emit {flags 0x%x}
					<
				}
	
				if {[N belong 4 0 0 {} {} x {}]} {
					>
						emit {- %d bytes}
					<
				}
	
			<
		}
		-86111040 {
			>
				emit {Mac OS X Detached Code Signature (non-executable)}
				if {[N belong 4 0 0 {} {} x {}]} {
					>
						emit {- %d bytes}
					<
				}
	
			<
		}
		-86111039 {
			>
				emit {Mac OS X Detached Code Signature}
				if {[N belong 8 0 0 {} {} > 1]} {
					>
						emit {(%d elements)}
					<
				}
	
				if {[N belong 4 0 0 {} {} x {}]} {
					>
						emit {- %d bytes}
					<
				}
	
			<
		}
		-17957139 {
			>
				emit {Java KeyStore}
				mime application/x-java-keystore
			<
		}
		-12432129 {
			>
				emit {WRAptor packer (c64)}
			<
		}
		-12169394 {
			>
				emit {DOS code page font data collection}
			<
		}
		-11534511 {
			>
				emit {JPEG 2000 codestream}
			<
		}
		-65536 {
			>
				if {[N belong 24 0 0 {} {} == 0]} {
					>
						if {[N belong 28 0 0 {} {} == 0]} {
							>
								if {[N belong 32792 0 0 {} {} == 1562156707]} {
									>
										emit {Nintendo Wii SDK disc image:}
										U 51 nintendo-gcn-disc-common 32768
	
									<
								}
	
								if {[N belong 32796 0 0 {} {} == -1036804291]} {
									>
										emit {Nintendo GameCube SDK disc image:}
										U 51 nintendo-gcn-disc-common 32768
	
									<
								}
	
							<
						}
	
					<
				}
	
			<
		}
		1 {
			>
				if {[N byte 4 0 0 & 31 == 7]} {
					>
						emit {JVT NAL sequence, H.264 video}
						switch [Nv byte 5 0 {} {}] {
							66 {
								>
									emit {\b, baseline}
								<
							}
							77 {
								>
									emit {\b, main}
								<
							}
							88 {
								>
									emit {\b, extended}
								<
							}
						}
	
						if {[N byte 7 0 0 {} {} x {}]} {
							>
								emit {\b @ L %u}
							<
						}
	
					<
				}
	
			<
		}
		4 {
			>
				emit {X11 SNF font data, MSB first}
				mime application/x-font-sfn
			<
		}
		32 {
			>
				if {[N byte 4 0 0 {} {} == 1]} {
					>
						if {[S string 8 0 {} {} eq KBXf]} {
							>
								emit {GPG keybox database}
								if {[N byte 5 0 0 {} {} == 1]} {
									>
										emit {version %d}
									<
								}
	
								if {[N bedate 16 0 0 {} {} x {}]} {
									>
										emit {\b, created-at %s}
									<
								}
	
								if {[N bedate 20 0 0 {} {} x {}]} {
									>
										emit {\b, last-maintained %s}
									<
								}
	
							<
						}
	
					<
				}
	
			<
		}
		123 {
			>
				emit {dar archive,}
				if {[N belong 4 0 0 {} {} x {}]} {
					>
						emit {label "%.8x}
						if {[N belong 8 0 0 {} {} x {}]} {
							>
								emit %.8x
								if {[N beshort 12 0 0 {} {} x {}]} {
									>
										emit %.4x\"
									<
								}
	
							<
						}
	
					<
				}
	
				if {[N byte 14 0 0 {} {} == 84]} {
					>
						emit {end slice}
					<
				}
	
				switch [Nv beshort 14 0 {} {}] {
					20046 {
						>
							emit multi-part
						<
					}
					20051 {
						>
							emit {multi-part, with -S}
						<
					}
				}
	
			<
		}
		256 {
			>
				if {[N beshort [I 4 ubelong 0 + 0 24] 0 0 {} {} x {}]} {
					>
						switch [Nv belong [R 4] 0 {} {}] {
							1179602516 {
								>
									emit {Mac OSX datafork font, 'FONT'}
								<
							}
							1313230420 {
								>
									emit {Mac OSX datafork font, 'NFNT'}
								<
							}
							1347375956 {
								>
									emit {Mac OSX datafork font, PostScript}
								<
							}
							1936092788 {
								>
									emit {Mac OSX datafork font, TrueType}
								<
							}
						}
	
					<
				}
	
			<
			>
				if {[N byte 9 0 0 {} {} == 0]} {
					>
						if {[N byte 0 0 0 {} {} x {}]} {
							>
							<
						}
	
						U 163 cur-ico-dir 0
	
					<
				}
	
				if {[N ubyte 9 0 0 {} {} == 255]} {
					>
						if {[N byte 0 0 0 {} {} x {}]} {
							>
							<
						}
	
						U 163 cur-ico-dir 0
	
					<
				}
	
			<
		}
		263 {
			>
				emit {a.out big-endian 32-bit executable}
				if {[N belong 16 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
			>
				emit {Plan 9 executable, Motorola 68k}
			<
		}
		264 {
			>
				emit {a.out big-endian 32-bit pure executable}
				if {[N belong 16 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		267 {
			>
				emit {a.out big-endian 32-bit demand paged executable}
				if {[N belong 16 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		327 {
			>
				emit {Convex old-style object}
				if {[N belong 16 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		331 {
			>
				emit {Convex old-style demand paged executable}
				if {[N belong 16 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		333 {
			>
				emit {Convex old-style pre-paged executable}
				if {[N belong 16 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		335 {
			>
				emit {Convex old-style pre-paged, non-swapped executable}
				if {[N belong 16 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		385 {
			>
				emit {Convex SOFF}
				if {[N belong 88 0 0 & 983040 == 0]} {
					>
						emit c1
					<
				}
	
				if {[N belong 88 0 0 {} {} & 65536]} {
					>
						emit c2
					<
				}
	
				if {[N belong 88 0 0 {} {} & 131072]} {
					>
						emit c2mp
					<
				}
	
				if {[N belong 88 0 0 {} {} & 262144]} {
					>
						emit parallel
					<
				}
	
				if {[N belong 88 0 0 {} {} & 524288]} {
					>
						emit intrinsic
					<
				}
	
				if {[N belong 88 0 0 {} {} & 1]} {
					>
						emit {demand paged}
					<
				}
	
				if {[N belong 88 0 0 {} {} & 2]} {
					>
						emit pre-paged
					<
				}
	
				if {[N belong 88 0 0 {} {} & 4]} {
					>
						emit non-swapped
					<
				}
	
				if {[N belong 88 0 0 {} {} & 8]} {
					>
						emit POSIX
					<
				}
	
				if {[N belong 84 0 0 {} {} & -2147483648]} {
					>
						emit executable
					<
				}
	
				if {[N belong 84 0 0 {} {} & 1073741824]} {
					>
						emit object
					<
				}
	
				if {[N belong 84 0 0 & 536870912 == 0]} {
					>
						emit {not stripped}
					<
				}
	
				switch [Nv belong 84 0 & 402653184] {
					0 {
						>
							emit {native fpmode}
						<
					}
					268435456 {
						>
							emit {ieee fpmode}
						<
					}
					402653184 {
						>
							emit {undefined fpmode}
						<
					}
				}
	
			<
		}
		389 {
			>
				emit {Convex SOFF core}
			<
		}
		391 {
			>
				emit {Convex SOFF checkpoint}
				if {[N belong 88 0 0 & 983040 == 0]} {
					>
						emit c1
					<
				}
	
				if {[N belong 88 0 0 {} {} & 65536]} {
					>
						emit c2
					<
				}
	
				if {[N belong 88 0 0 {} {} & 131072]} {
					>
						emit c2mp
					<
				}
	
				if {[N belong 88 0 0 {} {} & 262144]} {
					>
						emit parallel
					<
				}
	
				if {[N belong 88 0 0 {} {} & 524288]} {
					>
						emit intrinsic
					<
				}
	
				if {[N belong 88 0 0 {} {} & 8]} {
					>
						emit POSIX
					<
				}
	
				switch [Nv belong 84 0 & 402653184] {
					0 {
						>
							emit {native fpmode}
						<
					}
					268435456 {
						>
							emit {ieee fpmode}
						<
					}
					402653184 {
						>
							emit {undefined fpmode}
						<
					}
				}
	
			<
		}
		491 {
			>
				emit {Plan 9 executable, Intel 386}
			<
		}
		505 {
			>
				emit {AIX compiled message catalog}
			<
		}
		512 {
			>
				if {[N ubyte 7 0 0 {} {} == 0]} {
					>
						if {[N ubyte 6 0 0 {} {} > 0]} {
							>
								emit Lotus
								switch [Nv uleshort 4 0 {} {}] {
									7 {
										>
											emit {1-2-3 CoNFiguration, version 2.x (PGRAPH.CNF)}
											ext cnf
										<
									}
									1028 {
										>
											emit {1-2-3 WorKSheet, version 1}
											ext wks
										<
									}
									1029 {
										>
											emit {Symphony WoRksheet, version 1.0}
											ext wrk/wr1
										<
									}
									1030 {
										>
											emit {1-2-3/Symphony worksheet, version 2}
											ext wk1/wr1
										<
									}
									1536 {
										>
											emit {1-2-3 WorKsheet, version 1.xJ}
											ext wj1
										<
									}
									1538 {
										>
											emit {1-2-3 worksheet, version 2.4J}
											ext wj3
										<
									}
									2049 {
										>
											emit {1-2-3 CoNFiguration, version 1-2.1}
											ext cnf
										<
									}
									2050 {
										>
											emit {Symphony CoNFiguration}
											ext cnf
										<
									}
									2052 {
										>
											emit {1-2-3 CoNFiguration, version 2.2}
											ext cnf
										<
									}
									2058 {
										>
											emit {1-2-3 CoNFiguration, version 2.3-2.4}
											ext cnf
										<
									}
									3077 {
										>
											emit {1-2-3 CoNFiguration, version 2.4J}
											ext cnf
										<
									}
									5122 {
										>
											emit {1-2-3 CoNFiguration, version 3.x}
											ext cnf
										<
									}
									5200 {
										>
											emit {1-2-3 CoNFiguration, version 4.x}
											ext cnf
										<
									}
									32774 {
										>
											emit {1-2-3 ForMaTting data, version 2.x}
											ext fmt/fj3
										<
									}
									32775 {
										>
											emit {1-2-3 FoRMatting data, version 2.0}
											ext frm
										<
									}
								}
	
								if {[D 4]} {
									>
										emit {unknown worksheet or configuration}
										if {[N uleshort 4 0 0 {} {} x {}]} {
											>
												emit {\b, revision 0x%x}
											<
										}
	
										ext cnf
									<
								}
	
								U 163 lotus-cells 6
	
								U 163 lotus-cells [I 8 uleshort 0 + 0 10]
	
								mime application/vnd.lotus-1-2-3
							<
						}
	
					<
				}
	
			<
			>
				if {[N byte 9 0 0 {} {} == 0]} {
					>
						U 163 cur-ico-dir 0
	
					<
				}
	
				if {[N ubyte 9 0 0 {} {} == 255]} {
					>
						U 163 cur-ico-dir 0
	
					<
				}
	
			<
		}
		583 {
			>
				emit {Plan 9 executable, Intel 960}
			<
		}
		683 {
			>
				emit {Plan 9 executable, SPARC}
			<
		}
		999 {
			>
				emit {AmigaOS object/library data}
			<
		}
		1011 {
			>
				emit {AmigaOS loadseg()ble executable/binary}
			<
		}
		1018 {
			>
				emit {AmigaOS shared library}
			<
		}
		1031 {
			>
				emit {Plan 9 executable, MIPS R3000}
			<
		}
		1163 {
			>
				emit {Plan 9 executable, AT&T DSP 3210}
			<
		}
		1303 {
			>
				emit {Plan 9 executable, MIPS R4000 BE}
			<
		}
		1451 {
			>
				emit {Plan 9 executable, AMD 29000}
			<
		}
		1607 {
			>
				emit {Plan 9 executable, ARM 7-something}
			<
		}
		1771 {
			>
				emit {Plan 9 executable, PowerPC}
			<
		}
		1943 {
			>
				emit {Plan 9 executable, MIPS R4000 LE}
			<
		}
		2123 {
			>
				emit {Plan 9 executable, DEC Alpha}
			<
		}
		6656 {
			>
				if {[N ubyte 20 0 0 {} {} > 0]} {
					>
						if {[N ubyte 20 0 0 {} {} < 32]} {
							>
								emit {Lotus 1-2-3}
								switch [Nv uleshort 4 0 {} {}] {
									4096 {
										>
											emit {WorKsheet, version 3}
											ext wk3
										<
									}
									4098 {
										>
											emit {WorKsheet, version 4}
											ext wk4/wt4
										<
									}
									4099 {
										>
											emit {WorKsheet, version 97}
											ext 123
										<
									}
									4101 {
										>
											emit {WorKsheet, version 9.8 Millennium}
											ext 123
										<
									}
									32769 {
										>
											emit {FoRMatting data}
											ext frm
										<
									}
									32775 {
										>
											emit {ForMatting data, version 3}
											ext fm3
										<
									}
								}
	
								if {[D 4]} {
									>
										emit unknown
										if {[N uleshort 6 0 0 {} {} == 4]} {
											>
												emit worksheet
												ext wXX
											<
										}
	
										if {[N uleshort 6 0 0 {} {} != 4]} {
											>
												emit {formatting data}
												ext fXX
											<
										}
	
										if {[N uleshort 4 0 0 {} {} x {}]} {
											>
												emit {\b, revision 0x%x}
											<
										}
	
									<
								}
	
								if {[N uleshort 6 0 0 {} {} == 4]} {
									>
										emit {\b, cell range}
										if {[N ulelong 8 0 0 {} {} != 0]} {
											>
												if {[N ubyte 10 0 0 {} {} > 0]} {
													>
														emit {\b%d*}
													<
												}
	
												if {[N uleshort 8 0 0 {} {} x {}]} {
													>
														emit {\b%d,}
													<
												}
	
												if {[N ubyte 11 0 0 {} {} x {}]} {
													>
														emit {\b%d-}
													<
												}
	
											<
										}
	
										if {[N ubyte 14 0 0 {} {} > 0]} {
											>
												emit {\b%d*}
											<
										}
	
										if {[N uleshort 12 0 0 {} {} x {}]} {
											>
												emit {\b%d,}
											<
										}
	
										if {[N ubyte 15 0 0 {} {} x {}]} {
											>
												emit {\b%d}
											<
										}
	
										if {[N ubyte 20 0 0 {} {} > 1]} {
											>
												emit {\b, character set 0x%x}
											<
										}
	
										if {[N ubyte 21 0 0 {} {} x {}]} {
											>
												emit {\b, flags 0x%x}
											<
										}
	
									<
								}
	
								if {[N uleshort 6 0 0 {} {} != 4]} {
									>
										if {[S search 30 0 {} 29 eq \0\xAE]} {
											>
												if {[S string [R 4] 0 {} {} > \0]} {
													>
														emit {\b, 1st font "%s"}
													<
												}
	
											<
										}
	
									<
								}
	
								mime application/vnd.lotus-1-2-3
							<
						}
	
					<
				}
	
			<
		}
		9994 {
			>
				emit {ESRI Shapefile}
				if {[N belong 4 0 0 {} {} == 0]} {
					>
					<
				}
	
				if {[N belong 8 0 0 {} {} == 0]} {
					>
					<
				}
	
				if {[N belong 12 0 0 {} {} == 0]} {
					>
					<
				}
	
				if {[N belong 16 0 0 {} {} == 0]} {
					>
					<
				}
	
				if {[N belong 20 0 0 {} {} == 0]} {
					>
					<
				}
	
				if {[N lelong 28 0 0 {} {} x {}]} {
					>
						emit {version %d}
					<
				}
	
				if {[N belong 24 0 0 {} {} x {}]} {
					>
						emit {length %d}
					<
				}
	
				switch [Nv lelong 32 0 {} {}] {
					0 {
						>
							emit {type Null Shape}
						<
					}
					1 {
						>
							emit {type Point}
						<
					}
					3 {
						>
							emit {type PolyLine}
						<
					}
					5 {
						>
							emit {type Polygon}
						<
					}
					8 {
						>
							emit {type MultiPoint}
						<
					}
					11 {
						>
							emit {type PointZ}
						<
					}
					13 {
						>
							emit {type PolyLineZ}
						<
					}
					15 {
						>
							emit {type PolygonZ}
						<
					}
					18 {
						>
							emit {type MultiPointZ}
						<
					}
					21 {
						>
							emit {type PointM}
						<
					}
					23 {
						>
							emit {type PolyLineM}
						<
					}
					25 {
						>
							emit {type PolygonM}
						<
					}
					28 {
						>
							emit {type MultiPointM}
						<
					}
					31 {
						>
							emit {type MultiPatch}
						<
					}
				}
	
			<
		}
		65381 {
			>
				emit {old 32-bit-int big-endian archive}
				if {[S string 4 0 {} {} eq __.SYMDEF]} {
					>
						emit {random library}
					<
				}
	
			<
		}
		65389 {
			>
				emit {very old 32-bit-int big-endian archive}
			<
		}
		70231 {
			>
				emit {Core file}
			<
		}
		107364 {
			>
				emit {IRCAM file (VAX big-endian)}
			<
		}
		172900 {
			>
				emit {IRCAM file (Sun little-endian)}
			<
		}
		196608 {
			>
				if {[N belong 49124 0 0 {} {} < 47104]} {
					>
						if {[N belong 49128 0 0 {} {} < 47104]} {
							>
								if {[N belong 49132 0 0 {} {} < 47104]} {
									>
										if {[N belong 49136 0 0 {} {} < 47104]} {
											>
												emit {QL OS dump data,}
												if {[S string 49148 0 {} {} > \0]} {
													>
														emit {type %.3s,}
													<
												}
	
												if {[S string 49142 0 {} {} > \0]} {
													>
														emit {version %.4s}
													<
												}
	
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
			<
		}
		238436 {
			>
				emit {IRCAM file (MIPS big-endian)}
			<
		}
		303972 {
			>
				emit {IRCAM file (NeXT little-endian)}
			<
		}
		333312 {
			>
				emit {AppleSingle encoded Macintosh file}
			<
		}
		333319 {
			>
				emit {AppleDouble encoded Macintosh file}
			<
		}
		340322 {
			>
				emit {Berkeley DB 1.85/1.86}
				if {[N belong 4 0 0 {} {} > 0]} {
					>
						emit {(Btree, version %d, big-endian)}
					<
				}
	
			<
		}
		393218 {
			>
				emit {GDSII Stream file}
				if {[N byte 4 0 0 {} {} == 0]} {
					>
						if {[N byte 5 0 0 {} {} x {}]} {
							>
								emit {version %d.0}
							<
						}
	
					<
				}
	
				if {[N byte 4 0 0 {} {} > 0]} {
					>
						emit {version %d}
						if {[N byte 5 0 0 {} {} x {}]} {
							>
								emit {\b.%d}
							<
						}
	
					<
				}
	
			<
		}
		398689 {
			>
				emit {Berkeley DB}
				switch [Nv belong 8 0 {} {}] {
					1234 {
						>
							if {[N belong 4 0 0 {} {} > 2]} {
								>
									emit 1.86
								<
							}
	
							if {[N belong 4 0 0 {} {} < 3]} {
								>
									emit 1.85
								<
							}
	
							if {[N belong 4 0 0 {} {} > 0]} {
								>
									emit {(Hash, version %d, native byte-order)}
								<
							}
	
						<
					}
					4321 {
						>
							if {[N belong 4 0 0 {} {} > 2]} {
								>
									emit 1.86
								<
							}
	
							if {[N belong 4 0 0 {} {} < 3]} {
								>
									emit 1.85
								<
							}
	
							if {[N belong 4 0 0 {} {} > 0]} {
								>
									emit {(Hash, version %d, big-endian)}
								<
							}
	
						<
					}
				}
	
			<
		}
		525398 {
			>
				emit {SunOS core file}
				switch [Nv belong 4 0 {} {}] {
					432 {
						>
							emit (SPARC)
							if {[S string 132 0 {} {} > \0]} {
								>
									emit {from '%s'}
								<
							}
	
							switch [Nv belong 116 0 {} {}] {
								3 {
									>
										emit (quit)
									<
								}
								4 {
									>
										emit {(illegal instruction)}
									<
								}
								5 {
									>
										emit {(trace trap)}
									<
								}
								6 {
									>
										emit (abort)
									<
								}
								7 {
									>
										emit {(emulator trap)}
									<
								}
								8 {
									>
										emit {(arithmetic exception)}
									<
								}
								9 {
									>
										emit (kill)
									<
								}
								10 {
									>
										emit {(bus error)}
									<
								}
								11 {
									>
										emit {(segmentation violation)}
									<
								}
								12 {
									>
										emit {(bad argument to system call)}
									<
								}
								29 {
									>
										emit {(resource lost)}
									<
								}
							}
	
							if {[N belong 120 0 0 {} {} x {}]} {
								>
									emit (T=%dK,
								<
							}
	
							if {[N belong 124 0 0 {} {} x {}]} {
								>
									emit D=%dK,
								<
							}
	
							if {[N belong 128 0 0 {} {} x {}]} {
								>
									emit S=%dK)
								<
							}
	
						<
					}
					456 {
						>
							emit {(SPARC 4.x BCP)}
							if {[S string 152 0 {} {} > \0]} {
								>
									emit {from '%s'}
								<
							}
	
						<
					}
					826 {
						>
							emit (68K)
							if {[S string 128 0 {} {} > \0]} {
								>
									emit {from '%s'}
								<
							}
	
						<
					}
				}
	
			<
		}
		34210055 {
			>
				emit {HP s200 (2.x release) executable}
				if {[N beshort 4 0 0 {} {} > 0]} {
					>
						emit {- version %d}
					<
				}
	
				if {[N belong 36 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		34210056 {
			>
				emit {HP s200 (2.x release) pure executable}
				if {[N beshort 4 0 0 {} {} > 0]} {
					>
						emit {- version %d}
					<
				}
	
				if {[N belong 36 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		34275590 {
			>
				emit {PA-RISC1.0 relocatable object}
			<
		}
		34275591 {
			>
				emit {PA-RISC1.0 executable}
				if {[N belong 168 0 0 & 4 == 4]} {
					>
						emit {dynamically linked}
					<
				}
	
				if {[N belong [I 144 long 0 + 0 0] 0 0 {} {} == 89060912]} {
					>
						emit {dynamically linked}
					<
				}
	
				if {[N belong 96 0 0 {} {} > 0]} {
					>
						emit {- not stripped}
					<
				}
	
			<
		}
		34275592 {
			>
				emit {PA-RISC1.0 shared executable}
				if {[N belong 168 0 0 & 4 == 4]} {
					>
						emit {dynamically linked}
					<
				}
	
				if {[N belong [I 144 long 0 + 0 0] 0 0 {} {} == 89060912]} {
					>
						emit {dynamically linked}
					<
				}
	
				if {[N belong 96 0 0 {} {} > 0]} {
					>
						emit {- not stripped}
					<
				}
	
			<
		}
		34275595 {
			>
				emit {PA-RISC1.0 demand-load executable}
				if {[N belong 168 0 0 & 4 == 4]} {
					>
						emit {dynamically linked}
					<
				}
	
				if {[N belong [I 144 long 0 + 0 0] 0 0 {} {} == 89060912]} {
					>
						emit {dynamically linked}
					<
				}
	
				if {[N belong 96 0 0 {} {} > 0]} {
					>
						emit {- not stripped}
					<
				}
	
			<
		}
		34275597 {
			>
				emit {PA-RISC1.0 dynamic load library}
				if {[N belong 96 0 0 {} {} > 0]} {
					>
						emit {- not stripped}
					<
				}
	
			<
		}
		34275598 {
			>
				emit {PA-RISC1.0 shared library}
				if {[N belong 96 0 0 {} {} > 0]} {
					>
						emit {- not stripped}
					<
				}
	
			<
		}
		34341126 {
			>
				emit {HP s200 relocatable executable}
				if {[N beshort 4 0 0 {} {} > 0]} {
					>
						emit {- version %d}
					<
				}
	
				if {[N beshort 6 0 0 {} {} > 0]} {
					>
						emit {- highwater %d}
					<
				}
	
				if {[N belong 8 0 0 {} {} & -2147483648]} {
					>
						emit {save fp regs}
					<
				}
	
				if {[N belong 8 0 0 {} {} & 536870912]} {
					>
						emit debuggable
					<
				}
	
				if {[N belong 8 0 0 {} {} & 268435456]} {
					>
						emit PIC
					<
				}
	
			<
		}
		34341127 {
			>
				emit {HP s200 executable}
				if {[N beshort 4 0 0 {} {} > 0]} {
					>
						emit {- version %d}
					<
				}
	
				if {[N belong 8 0 0 {} {} & -2147483648]} {
					>
						emit {save fp regs}
					<
				}
	
				if {[N belong 8 0 0 {} {} & 1073741824]} {
					>
						emit {dynamically linked}
					<
				}
	
				if {[N belong 8 0 0 {} {} & 536870912]} {
					>
						emit debuggable
					<
				}
	
				if {[N belong 36 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		34341128 {
			>
				emit {HP s200 pure executable}
				if {[N beshort 4 0 0 {} {} > 0]} {
					>
						emit {- version %d}
					<
				}
	
				if {[N belong 8 0 0 {} {} & -2147483648]} {
					>
						emit {save fp regs}
					<
				}
	
				if {[N belong 8 0 0 {} {} & 1073741824]} {
					>
						emit {dynamically linked}
					<
				}
	
				if {[N belong 8 0 0 {} {} & 536870912]} {
					>
						emit debuggable
					<
				}
	
				if {[N belong 36 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		34341131 {
			>
				emit {HP s200 demand-load executable}
				if {[N beshort 4 0 0 {} {} > 0]} {
					>
						emit {- version %d}
					<
				}
	
				if {[N belong 8 0 0 {} {} & -2147483648]} {
					>
						emit {save fp regs}
					<
				}
	
				if {[N belong 8 0 0 {} {} & 1073741824]} {
					>
						emit {dynamically linked}
					<
				}
	
				if {[N belong 8 0 0 {} {} & 536870912]} {
					>
						emit debuggable
					<
				}
	
				if {[N belong 36 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		34341133 {
			>
				emit {HP s200 dynamic load library}
				if {[N beshort 4 0 0 {} {} > 0]} {
					>
						emit {- version %d}
					<
				}
	
				if {[N beshort 6 0 0 {} {} > 0]} {
					>
						emit {- highwater %d}
					<
				}
	
				if {[N belong 36 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		34341134 {
			>
				emit {HP s200 shared library}
				if {[N beshort 4 0 0 {} {} > 0]} {
					>
						emit {- version %d}
					<
				}
	
				if {[N beshort 6 0 0 {} {} > 0]} {
					>
						emit {- highwater %d}
					<
				}
	
				if {[N belong 36 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		34603270 {
			>
				emit {PA-RISC1.1 relocatable object}
			<
		}
		34603271 {
			>
				emit {PA-RISC1.1 executable}
				if {[N belong 168 0 0 {} {} & 4]} {
					>
						emit {dynamically linked}
					<
				}
	
				if {[N belong [I 144 long 0 + 0 0] 0 0 {} {} == 89060912]} {
					>
						emit {dynamically linked}
					<
				}
	
				if {[N belong 96 0 0 {} {} > 0]} {
					>
						emit {- not stripped}
					<
				}
	
			<
		}
		34603272 {
			>
				emit {PA-RISC1.1 shared executable}
				if {[N belong 168 0 0 & 4 == 4]} {
					>
						emit {dynamically linked}
					<
				}
	
				if {[N belong [I 144 long 0 + 0 0] 0 0 {} {} == 89060912]} {
					>
						emit {dynamically linked}
					<
				}
	
				if {[N belong 96 0 0 {} {} > 0]} {
					>
						emit {- not stripped}
					<
				}
	
			<
		}
		34603275 {
			>
				emit {PA-RISC1.1 demand-load executable}
				if {[N belong 168 0 0 & 4 == 4]} {
					>
						emit {dynamically linked}
					<
				}
	
				if {[N belong [I 144 long 0 + 0 0] 0 0 {} {} == 89060912]} {
					>
						emit {dynamically linked}
					<
				}
	
				if {[N belong 96 0 0 {} {} > 0]} {
					>
						emit {- not stripped}
					<
				}
	
			<
		}
		34603277 {
			>
				emit {PA-RISC1.1 dynamic load library}
				if {[N belong 96 0 0 {} {} > 0]} {
					>
						emit {- not stripped}
					<
				}
	
			<
		}
		34603278 {
			>
				emit {PA-RISC1.1 shared library}
				if {[N belong 96 0 0 {} {} > 0]} {
					>
						emit {- not stripped}
					<
				}
	
			<
		}
		34865414 {
			>
				emit {PA-RISC2.0 relocatable object}
			<
		}
		34865415 {
			>
				emit {PA-RISC2.0 executable}
				if {[N belong 168 0 0 {} {} & 4]} {
					>
						emit {dynamically linked}
					<
				}
	
				if {[N belong [I 144 long 0 + 0 0] 0 0 {} {} == 89060912]} {
					>
						emit {dynamically linked}
					<
				}
	
				if {[N belong 96 0 0 {} {} > 0]} {
					>
						emit {- not stripped}
					<
				}
	
			<
		}
		34865416 {
			>
				emit {PA-RISC2.0 shared executable}
				if {[N belong 168 0 0 {} {} & 4]} {
					>
						emit {dynamically linked}
					<
				}
	
				if {[N belong [I 144 long 0 + 0 0] 0 0 {} {} == 89060912]} {
					>
						emit {dynamically linked}
					<
				}
	
				if {[N belong 96 0 0 {} {} > 0]} {
					>
						emit {- not stripped}
					<
				}
	
			<
		}
		34865419 {
			>
				emit {PA-RISC2.0 demand-load executable}
				if {[N belong 168 0 0 {} {} & 4]} {
					>
						emit {dynamically linked}
					<
				}
	
				if {[N belong [I 144 long 0 + 0 0] 0 0 {} {} == 89060912]} {
					>
						emit {dynamically linked}
					<
				}
	
				if {[N belong 96 0 0 {} {} > 0]} {
					>
						emit {- not stripped}
					<
				}
	
			<
		}
		34865421 {
			>
				emit {PA-RISC2.0 dynamic load library}
				if {[N belong 96 0 0 {} {} > 0]} {
					>
						emit {- not stripped}
					<
				}
	
			<
		}
		34865422 {
			>
				emit {PA-RISC2.0 shared library}
				if {[N belong 96 0 0 {} {} > 0]} {
					>
						emit {- not stripped}
					<
				}
	
			<
		}
		50331648 {
			>
				if {[N ubelong 8 0 0 {} {} == 3959554048]} {
					>
						emit {VMS Alpha executable}
						if {[S string 75264 0 {} {} eq PK\003\004]} {
							>
								emit {\b, Info-ZIP SFX archive v5.12 w/decryption}
							<
						}
	
					<
				}
	
			<
		}
		66260234 {
			>
				emit {python 2.7 byte-compiled}
			<
		}
		84017152 {
			>
				emit {Kerberos Keytab file}
				U 124 keytab_entry 4
	
			<
		}
		101117429 {
			>
				emit {Adobe InDesign}
				if {[S string 16 0 {} {} eq DOCUMENT]} {
					>
						emit Document
					<
				}
	
			<
		}
		119734787 {
			>
				emit {Khronos SPIR-V binary, big-endian}
				if {[N belong 4 0 0 {} {} x {}]} {
					>
						emit {\b, version 0x%08x}
					<
				}
	
				if {[N belong 8 0 0 {} {} x {}]} {
					>
						emit {\b, generator 0x%08x}
					<
				}
	
			<
		}
		134551296 {
			>
				emit {Bentley/Intergraph MicroStation DGN cell library}
			<
		}
		134872578 {
			>
				emit {Bentley/Intergraph MicroStation DGN vector CAD}
			<
		}
		199600449 {
			>
				emit {SGI disk label (volume header)}
			<
		}
		235082497 {
			>
				emit {Hierarchical Data Format (version 4) data}
				mime application/x-hdf
			<
		}
		324508365 {
			>
				emit {GNU dbm 1.x or ndbm database, big endian, 32-bit}
				mime application/x-gdbm
			<
		}
		324508366 {
			>
				emit {GNU dbm 1.x or ndbm database, big endian, old}
				mime application/x-gdbm
			<
		}
		324508367 {
			>
				emit {GNU dbm 1.x or ndbm database, big endian, 64-bit}
				mime application/x-gdbm
			<
		}
		326773060 {
			>
				emit {NeWS bitmap font}
			<
		}
		326773063 {
			>
				emit {NeWS font family}
			<
		}
		326773072 {
			>
				emit {scalable OpenFont binary}
			<
		}
		326773073 {
			>
				emit {encrypted scalable OpenFont binary}
			<
		}
		335698201 {
			>
				emit {libGrx font data,}
				if {[N leshort 8 0 0 {} {} x {}]} {
					>
						emit %dx
					<
				}
	
				if {[N leshort 10 0 0 {} {} x {}]} {
					>
						emit {\b%d}
					<
				}
	
				if {[S string 40 0 {} {} x {}]} {
					>
						emit %s
					<
				}
	
			<
		}
		369954058 {
			>
				emit {python 3.5.1- byte-compiled}
			<
		}
		386731274 {
			>
				emit {python 3.5.2+ byte-compiled}
			<
		}
		440786851 {
			>
				emit {EBML file}
				if {[S search 4 0 b 100 eq \102\202]} {
					>
						if {[S string [R 1] 0 {} {} x {}]} {
							>
								emit {\b, creator %.8s}
							<
						}
	
					<
				}
	
			<
			>
				if {[S search 4 0 {} 4096 eq \x42\x82]} {
					>
						if {[S string [R 1] 0 {} {} eq webm]} {
							>
								emit WebM
								mime video/webm
							<
						}
	
						if {[S string [R 1] 0 {} {} eq matroska]} {
							>
								emit {Matroska data}
								mime video/x-matroska
							<
						}
	
					<
				}
	
			<
		}
		518517022 {
			>
				emit {Pulsar POP3 daemon mailbox cache file.}
				if {[N ubelong 4 0 0 {} {} x {}]} {
					>
						emit {Version: %d.}
					<
				}
	
				if {[N ubelong 8 0 0 {} {} x {}]} {
					>
						emit {\b%d}
					<
				}
	
			<
		}
		518520576 {
			>
				emit {EET archive}
				mime application/x-eet
			<
		}
		554074152 {
			>
				emit {Sega Dreamcast VMU game image}
			<
		}
		557605234 {
			>
				emit {archive file}
				switch [Nv belong 68 0 {} {}] {
					34276889 {
						>
							emit {- PA-RISC1.0 relocatable library}
						<
					}
					34604569 {
						>
							emit {- PA-RISC1.1 relocatable library}
						<
					}
					34670105 {
						>
							emit {- PA-RISC1.2 relocatable library}
						<
					}
					34866713 {
						>
							emit {- PA-RISC2.0 relocatable library}
						<
					}
				}
	
			<
		}
		654645590 {
			>
				emit {u-boot legacy uImage,}
				if {[S string 32 0 {} {} x {}]} {
					>
						emit %s,
					<
				}
	
				switch [Nv byte 28 0 {} {}] {
					0 {
						>
							emit {Invalid os/}
						<
					}
					1 {
						>
							emit OpenBSD/
						<
					}
					2 {
						>
							emit NetBSD/
						<
					}
					3 {
						>
							emit FreeBSD/
						<
					}
					4 {
						>
							emit 4.4BSD/
						<
					}
					5 {
						>
							emit Linux/
						<
					}
					6 {
						>
							emit SVR4/
						<
					}
					7 {
						>
							emit Esix/
						<
					}
					8 {
						>
							emit Solaris/
						<
					}
					9 {
						>
							emit Irix/
						<
					}
					10 {
						>
							emit SCO/
						<
					}
					11 {
						>
							emit Dell/
						<
					}
					12 {
						>
							emit NCR/
						<
					}
					13 {
						>
							emit LynxOS/
						<
					}
					14 {
						>
							emit VxWorks/
						<
					}
					15 {
						>
							emit pSOS/
						<
					}
					16 {
						>
							emit QNX/
						<
					}
					17 {
						>
							emit Firmware/
						<
					}
					18 {
						>
							emit RTEMS/
						<
					}
					19 {
						>
							emit ARTOS/
						<
					}
					20 {
						>
							emit {Unity OS/}
						<
					}
					21 {
						>
							emit INTEGRITY/
						<
					}
				}
	
				switch [Nv byte 29 0 {} {}] {
					0 {
						>
							emit {\bInvalid CPU,}
						<
					}
					1 {
						>
							emit {\bAlpha,}
						<
					}
					2 {
						>
							emit {\bARM,}
						<
					}
					3 {
						>
							emit {\bIntel x86,}
						<
					}
					4 {
						>
							emit {\bIA64,}
						<
					}
					5 {
						>
							emit {\bMIPS,}
						<
					}
					6 {
						>
							emit {\bMIPS 64-bit,}
						<
					}
					7 {
						>
							emit {\bPowerPC,}
						<
					}
					8 {
						>
							emit {\bIBM S390,}
						<
					}
					9 {
						>
							emit {\bSuperH,}
						<
					}
					10 {
						>
							emit {\bSparc,}
						<
					}
					11 {
						>
							emit {\bSparc 64-bit,}
						<
					}
					12 {
						>
							emit {\bM68K,}
						<
					}
					13 {
						>
							emit {\bNios-32,}
						<
					}
					14 {
						>
							emit {\bMicroBlaze,}
						<
					}
					15 {
						>
							emit {\bNios-II,}
						<
					}
					16 {
						>
							emit {\bBlackfin,}
						<
					}
					17 {
						>
							emit {\bAVR32,}
						<
					}
					18 {
						>
							emit {\bSTMicroelectronics ST200,}
						<
					}
					19 {
						>
							emit {\bSandbox architecture,}
						<
					}
					20 {
						>
							emit {\bANDES Technology NDS32,}
						<
					}
					21 {
						>
							emit {\bOpenRISC 1000,}
						<
					}
					22 {
						>
							emit {\bARM 64-bit,}
						<
					}
					23 {
						>
							emit {\bDesignWare ARC,}
						<
					}
					24 {
						>
							emit {\bx86_64,}
						<
					}
					25 {
						>
							emit {\bXtensa,}
						<
					}
				}
	
				switch [Nv byte 30 0 {} {}] {
					0 {
						>
							emit {Invalid Image}
						<
					}
					1 {
						>
							emit {Standalone Program}
						<
					}
					2 {
						>
							emit {OS Kernel Image}
						<
					}
					3 {
						>
							emit {RAMDisk Image}
						<
					}
					4 {
						>
							emit {Multi-File Image}
						<
					}
					5 {
						>
							emit {Firmware Image}
						<
					}
					6 {
						>
							emit {Script File}
						<
					}
					7 {
						>
							emit {Filesystem Image (any type)}
						<
					}
					8 {
						>
							emit {Binary Flat Device Tree BLOB}
						<
					}
				}
	
				switch [Nv byte 31 0 {} {}] {
					0 {
						>
							emit {(Not compressed),}
						<
					}
					1 {
						>
							emit (gzip),
						<
					}
					2 {
						>
							emit (bzip2),
						<
					}
					3 {
						>
							emit (lzma),
						<
					}
				}
	
				if {[N belong 12 0 0 {} {} x {}]} {
					>
						emit {%d bytes,}
					<
				}
	
				if {[N bedate 8 0 0 {} {} x {}]} {
					>
						emit %s,
					<
				}
	
				if {[N belong 16 0 0 {} {} x {}]} {
					>
						emit {Load Address: 0x%08X,}
					<
				}
	
				if {[N belong 20 0 0 {} {} x {}]} {
					>
						emit {Entry Point: 0x%08X,}
					<
				}
	
				if {[N belong 4 0 0 {} {} x {}]} {
					>
						emit {Header CRC: 0x%08X,}
					<
				}
	
				if {[N belong 24 0 0 {} {} x {}]} {
					>
						emit {Data CRC: 0x%08X}
					<
				}
	
			<
		}
		684539205 {
			>
				emit {Linux Compressed ROM File System data, big endian}
				if {[N belong 4 0 0 {} {} x {}]} {
					>
						emit {size %u}
					<
				}
	
				if {[N belong 8 0 0 {} {} & 1]} {
					>
						emit {version #2}
					<
				}
	
				if {[N belong 8 0 0 {} {} & 2]} {
					>
						emit sorted_dirs
					<
				}
	
				if {[N belong 8 0 0 {} {} & 4]} {
					>
						emit hole_support
					<
				}
	
				if {[N belong 32 0 0 {} {} x {}]} {
					>
						emit {CRC 0x%x,}
					<
				}
	
				if {[N belong 36 0 0 {} {} x {}]} {
					>
						emit {edition %u,}
					<
				}
	
				if {[N belong 40 0 0 {} {} x {}]} {
					>
						emit {%u blocks,}
					<
				}
	
				if {[N belong 44 0 0 {} {} x {}]} {
					>
						emit {%u files}
					<
				}
	
			<
		}
		720047370 {
			>
				emit {python 2.1 byte-compiled}
			<
		}
		770510090 {
			>
				emit {python 2.2 byte-compiled}
			<
		}
		779248125 {
			>
				emit {RealAudio sound file}
				mime audio/x-pn-realaudio
			<
		}
		807842421 {
			>
				emit {Microsoft ASF}
				mime video/x-ms-asf
			<
		}
		834535424 {
			>
				emit {Microsoft Word Document}
				mime application/msword
			<
		}
		856493322 {
			>
				emit {python 3.6 byte-compiled}
			<
		}
		876099889 {
			>
				emit {Linux Journalled Flash File system, big endian}
			<
		}
		990645514 {
			>
				emit {python 3.0 byte-compiled}
			<
		}
		1005718794 {
			>
				emit {python 2.3 byte-compiled}
			<
		}
		1010974665 {
			>
				if {[N belong 4 0 0 {} {} == 1787282127]} {
					>
						emit {Adrift game file version}
						switch [Nv belong 8 0 {} {}] {
							-1840955807 {
								>
									emit 5.0
								<
							}
							-1824178591 {
								>
									emit 4.0
								<
							}
							-1807403423 {
								>
									emit 3.80
								<
							}
							-1807403167 {
								>
									emit 3.90
								<
							}
						}
	
						if {[D 8]} {
							>
								emit unknown
								mime application/x-adrift
							<
						}
	
					<
				}
	
			<
		}
		1041042698 {
			>
				emit {python 3.7 byte-compiled}
			<
		}
		1125466468 {
			>
				emit {X64 Image}
			<
		}
		1257963521 {
			>
				emit {QL plugin-ROM data,}
				if {[S pstring 9 0 {} {} eq \0]} {
					>
						emit un-named
					<
				}
	
				if {[S pstring 9 0 {} {} > \0]} {
					>
						emit {named: %s}
					<
				}
	
			<
		}
		1279543401 {
			>
				emit {ld.so hints file (Big Endian}
				if {[N belong 4 0 0 {} {} > 0]} {
					>
						emit {\b, version %d)}
					<
				}
	
				if {[N belong 4 0 0 {} {} < 1]} {
					>
						emit {\b)}
					<
				}
	
			<
		}
		1297241678 {
			>
				emit {VMware nvram}
			<
		}
		1313166080 {
			>
				emit {NES ROM image (Wii U Virtual Console)}
				mime application/x-nes-rom
				U 51 nes-rom-image-ines 0
	
			<
		}
		1314148939 {
			>
				emit {MultiTrack sound data}
				if {[N belong 4 0 0 {} {} x {}]} {
					>
						emit {- version %d}
					<
				}
	
			<
		}
		1326189834 {
			>
				emit {python 3.1 byte-compiled}
			<
		}
		1330597709 {
			>
				emit {User-mode Linux COW file}
				if {[N belong 4 0 0 {} {} < 3]} {
					>
						emit {\b, version %d}
						if {[S string 8 0 {} {} > \0]} {
							>
								emit {\b, backing file %s}
							<
						}
	
					<
				}
	
				if {[N belong 4 0 0 {} {} > 2]} {
					>
						emit {\b, version %d}
						if {[S string 32 0 {} {} > \0]} {
							>
								emit {\b, backing file %s}
							<
						}
	
					<
				}
	
			<
		}
		1347223552 {
			>
				U 12 apple-apm 0
	
			<
		}
		1396917837 {
			>
				emit {IRIS Showcase file}
				if {[N byte 4 0 0 {} {} x {}]} {
					>
						emit {- version %d}
					<
				}
	
			<
		}
		1413695053 {
			>
				emit {IRIS Showcase template}
				if {[N byte 4 0 0 {} {} x {}]} {
					>
						emit {- version %d}
					<
				}
	
			<
		}
		1481003842 {
			>
				emit {SGI XFS filesystem data}
				if {[N belong 4 0 0 {} {} x {}]} {
					>
						emit {(blksz %d,}
					<
				}
	
				if {[N beshort 104 0 0 {} {} x {}]} {
					>
						emit {inosz %d,}
					<
				}
	
				if {[N beshort 100 0 0 {} {} ^ 8196]} {
					>
						emit {v1 dirs)}
					<
				}
	
				if {[N beshort 100 0 0 {} {} & 8196]} {
					>
						emit {v2 dirs)}
					<
				}
	
			<
		}
		1504078485 {
			>
				emit {Sun raster image data}
				if {[N belong 4 0 0 {} {} > 0]} {
					>
						emit {\b, %d x}
					<
				}
	
				if {[N belong 8 0 0 {} {} > 0]} {
					>
						emit %d,
					<
				}
	
				if {[N belong 12 0 0 {} {} > 0]} {
					>
						emit %d-bit,
					<
				}
	
				switch [Nv belong 20 0 {} {}] {
					0 {
						>
							emit {old format,}
						<
					}
					2 {
						>
							emit compressed,
						<
					}
					3 {
						>
							emit RGB,
						<
					}
					4 {
						>
							emit TIFF,
						<
					}
					5 {
						>
							emit IFF,
						<
					}
					65535 {
						>
							emit {reserved for testing,}
						<
					}
				}
	
				switch [Nv belong 24 0 {} {}] {
					0 {
						>
							emit {no colormap}
						<
					}
					1 {
						>
							emit {RGB colormap}
						<
					}
					2 {
						>
							emit {raw colormap}
						<
					}
				}
	
			<
		}
		1688404224 {
			>
				emit {IRCAM file (VAX little-endian)}
			<
		}
		1688404480 {
			>
				emit {IRCAM file (Sun big-endian)}
			<
		}
		1688404736 {
			>
				emit {IRCAM file (MIPS little-endian)}
			<
		}
		1688404992 {
			>
				emit {IRCAM file (NeXT big-endian)}
			<
			>
				emit {IRCAM file (NeXT big-endian)}
			<
		}
		1734567009 {
			>
				emit {GCC gcda coverage (-fprofile-arcs),}
				if {[N byte [R 0] 0 0 {} {} x {}]} {
					>
						emit {version %c.}
					<
				}
	
				if {[N byte [R 2] 0 0 {} {} x {}]} {
					>
						emit {\b%c (big-endian)}
					<
				}
	
			<
		}
		1734569583 {
			>
				emit {GCC gcno coverage (-ftest-coverage),}
				if {[N byte [R 0] 0 0 {} {} x {}]} {
					>
						emit {version %c.}
					<
				}
	
				if {[N byte [R 2] 0 0 {} {} x {}]} {
					>
						emit {\b%c (big-endian)}
					<
				}
	
			<
		}
		1812729098 {
			>
				emit {python 3.2 byte-compiled}
			<
		}
		1844579594 {
			>
				emit {python 2.4 byte-compiled}
			<
		}
		1886869041 {
			>
				emit {Cracklib password index, big endian}
				if {[N belong 4 0 0 {} {} > -1]} {
					>
						emit {(%i words)}
					<
				}
	
			<
		}
		1920139574 {
			>
				emit {rdiff network-delta signature data}
				if {[N belong 4 0 0 {} {} x {}]} {
					>
						emit {(block length=%d,}
					<
				}
	
				if {[N belong 8 0 0 {} {} x {}]} {
					>
						emit {signature strength=%d)}
					<
				}
	
			<
		}
		1920139830 {
			>
				emit {rdiff network-delta data}
			<
		}
		1936484385 {
			>
				emit {Allegro datafile (packed)}
			<
		}
		1936484395 {
			>
				emit {Allegro datafile (appended exe data)}
			<
		}
		1936484398 {
			>
				emit {Allegro datafile (not packed/autodetect)}
			<
		}
		1976638807 {
			>
				emit {Common Trace Format (CTF) packetized metadata (BE)}
				if {[N byte 35 0 0 {} {} x {}]} {
					>
						emit {\b, v%d}
					<
				}
	
				if {[N byte 36 0 0 {} {} x {}]} {
					>
						emit {\b.%d}
					<
				}
	
			<
		}
	}
	
	if {[S search 0 0 {} 8192 eq (input,]} {
		>
			emit {Algol 68 source text}
			mime text/x-Algol68
		<
	}
	
	if {[S regex 0 0 {} {} eq ^PROC]} {
		>
			emit {Algol 68 source text}
			mime text/x-Algol68
		<
	}
	
	if {[S regex 0 0 {} {} eq MODE\[\t\ \]]} {
		>
			emit {Algol 68 source text}
			mime text/x-Algol68
		<
	}
	
	if {[S regex 0 0 {} {} eq REF\[\t\ \]]} {
		>
			emit {Algol 68 source text}
			mime text/x-Algol68
		<
	}
	
	if {[S regex 0 0 {} {} eq FLEX\[\t\ \]*\\\[]} {
		>
			emit {Algol 68 source text}
			mime text/x-Algol68
		<
	}
	
	switch [Nv short 0 0 {} {}] {
		-21846 {
			>
				emit {SoftQuad DESC or font file binary}
				if {[N short 2 0 0 {} {} > 0]} {
					>
						emit {- version %d}
					<
				}
	
			<
		}
		-16166 {
			>
				emit {Compiled PSI (v2) data}
				if {[S string 3 0 {} {} > \0]} {
					>
						emit (%s)
					<
				}
	
			<
		}
		-16162 {
			>
				emit {Compiled PSI (v1) data}
			<
		}
		-14479 {
			>
				emit {byte-swapped cpio archive}
				mime {application/x-cpio # encoding: swapped}
			<
		}
		-13563 {
			>
				emit {huf output}
				mime application/octet-stream
			<
		}
		256 {
			>
				if {[S search 2 0 {} 9 eq \0\0]} {
					>
					<
				}
	
				if {[D 2]} {
					>
						if {[N belong 0 0 0 {} {} != 107364]} {
							>
								if {[N beshort 2 0 0 {} {} != 8]} {
									>
										if {[S search 11 0 {} 262 eq \x06DESIGN]} {
											>
											<
										}
	
										if {[D 11]} {
											>
												if {[S search 27118 0 {} 1864 eq DreamWorld]} {
													>
													<
												}
	
												if {[D 27118]} {
													>
														if {[N ubequad 8 0 0 {} {} != 3314931918822244867]} {
															>
																if {[N ubequad 8 0 0 {} {} != 6768475576809644948]} {
																	>
																		emit {raw G3 (Group 3) FAX, byte-padded}
																		mime image/g3fax
																		ext g3
																	<
																}
	
															<
														}
	
													<
												}
	
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
			<
		}
		262 {
			>
				emit {VAX-order2 68k Blit mpx/mux executable}
			<
		}
		272 {
			>
				emit {0420 Alliant virtual executable}
				if {[N short 2 0 0 {} {} & 32]} {
					>
						emit {common library}
					<
				}
	
				if {[N long 16 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		273 {
			>
				emit {0421 Alliant compact executable}
				if {[N short 2 0 0 {} {} & 32]} {
					>
						emit {common library}
					<
				}
	
				if {[N long 16 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		286 {
			>
				emit {Berkeley vfont data}
			<
		}
		340 {
			>
				emit Encore
				switch [Nv short 20 0 {} {}] {
					263 {
						>
							emit executable
						<
					}
					264 {
						>
							emit {pure executable}
						<
					}
					267 {
						>
							emit {demand-paged executable}
						<
					}
					271 {
						>
							emit {unsupported executable}
						<
					}
				}
	
				if {[N long 12 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				if {[N short 22 0 0 {} {} > 0]} {
					>
						emit {- version %d}
					<
				}
	
				if {[N short 22 0 0 {} {} == 0]} {
					>
						emit -
					<
				}
	
			<
		}
		341 {
			>
				emit {Encore unsupported executable}
				if {[N long 12 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				if {[N short 22 0 0 {} {} > 0]} {
					>
						emit {- version %d}
					<
				}
	
				if {[N short 22 0 0 {} {} == 0]} {
					>
						emit -
					<
				}
	
			<
		}
		373 {
			>
				emit {i386 COFF object}
			<
		}
		381 {
			>
				emit {CLIPPER COFF executable (VAX #)}
				switch [Nv short 20 0 {} {}] {
					263 {
						>
							emit (impure)
						<
					}
					264 {
						>
							emit {(5.2 compatible)}
						<
					}
					265 {
						>
							emit (pure)
						<
					}
					267 {
						>
							emit {(demand paged)}
						<
					}
					291 {
						>
							emit {(target shared library)}
						<
					}
				}
	
				if {[N long 12 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				if {[N short 22 0 0 {} {} > 0]} {
					>
						emit {- version %d}
					<
				}
	
			<
		}
		383 {
			>
				emit {CLIPPER COFF executable}
				switch [Nv short 18 0 & 30720] {
					0 {
						>
							emit {C1 R1}
						<
					}
					2048 {
						>
							emit {C2 R1}
						<
					}
					4096 {
						>
							emit {C3 R1}
						<
					}
					30720 {
						>
							emit TEST
						<
					}
				}
	
				switch [Nv short 20 0 {} {}] {
					263 {
						>
							emit (impure)
						<
					}
					264 {
						>
							emit (pure)
						<
					}
					265 {
						>
							emit {(separate I&D)}
						<
					}
					267 {
						>
							emit (paged)
						<
					}
					291 {
						>
							emit {(target shared library)}
						<
					}
				}
	
				if {[N long 12 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				if {[N short 22 0 0 {} {} > 0]} {
					>
						emit {- version %d}
					<
				}
	
				if {[N long 48 0 0 & 1 == 1]} {
					>
						emit {alignment trap enabled}
					<
				}
	
				switch [Nv byte 52 0 {} {}] {
					1 {
						>
							emit -Ctnc
						<
					}
					2 {
						>
							emit -Ctsw
						<
					}
					3 {
						>
							emit -Ctpw
						<
					}
					4 {
						>
							emit -Ctcb
						<
					}
				}
	
				switch [Nv byte 53 0 {} {}] {
					1 {
						>
							emit -Cdnc
						<
					}
					2 {
						>
							emit -Cdsw
						<
					}
					3 {
						>
							emit -Cdpw
						<
					}
					4 {
						>
							emit -Cdcb
						<
					}
				}
	
				switch [Nv byte 54 0 {} {}] {
					1 {
						>
							emit -Csnc
						<
					}
					2 {
						>
							emit -Cssw
						<
					}
					3 {
						>
							emit -Cspw
						<
					}
					4 {
						>
							emit -Cscb
						<
					}
				}
	
			<
		}
		392 {
			>
				emit {Perkin-Elmer executable}
			<
		}
		601 {
			>
				emit {mumps avl global}
				if {[N byte 2 0 0 {} {} > 0]} {
					>
						emit (V%d)
					<
				}
	
				if {[N byte 6 0 0 {} {} > 0]} {
					>
						emit {with %d byte name}
					<
				}
	
				if {[N byte 7 0 0 {} {} > 0]} {
					>
						emit {and %d byte data cells}
					<
				}
	
			<
		}
		602 {
			>
				emit {mumps blt global}
				if {[N byte 2 0 0 {} {} > 0]} {
					>
						emit (V%d)
					<
				}
	
				if {[N short 8 0 0 {} {} > 0]} {
					>
						emit {- %d byte blocks}
					<
				}
	
				switch [Nv byte 15 0 {} {}] {
					0 {
						>
							emit {- P/D format}
						<
					}
					1 {
						>
							emit {- P/K/D format}
						<
					}
					2 {
						>
							emit {- K/D format}
						<
					}
				}
	
				if {[N byte 15 0 0 {} {} > 2]} {
					>
						emit {- Bad Flags}
					<
				}
	
			<
		}
		1281 {
			>
				emit {locale data table}
				switch [Nv short 6 0 {} {}] {
					36 {
						>
							emit {for MIPS}
						<
					}
					64 {
						>
							emit {for Alpha}
						<
					}
				}
	
			<
		}
		1537 {
			>
				emit {VAX-order 68k Blit mpx/mux executable}
			<
		}
		1793 {
			>
				emit {VAX-order 68K Blit (standalone) executable}
			<
		}
		5120 {
			>
				if {[S search 2 0 {} 9 eq \0\0]} {
					>
					<
				}
	
				if {[D 2]} {
					>
						emit {raw G3 (Group 3) FAX}
						mime image/g3fax
						ext g3
					<
				}
	
			<
		}
		7681 {
			>
				emit {byte-swapped Berkeley vfont data}
			<
		}
		7967 {
			>
				emit {old packed data}
				mime application/octet-stream
			<
		}
		8191 {
			>
				emit {compacted data}
				mime application/octet-stream
			<
		}
		10012 {
			>
				if {[S regex 16 0 s {} eq ^\[0-78\]\[0-9.\]\{4\}]} {
					>
						emit {Sendmail frozen configuration}
						if {[S string 16 0 {} {} > \0]} {
							>
								emit {- version %s}
							<
						}
	
						ext fc
					<
				}
	
			<
		}
		10775 {
			>
				emit {"compact bitmap" format (Poskanzer)}
			<
		}
		21845 {
			>
				emit {VISX image file}
				switch [Nv byte 2 0 {} {}] {
					-126 {
						>
							emit (graph)
						<
					}
					-125 {
						>
							emit {(adjacency graph)}
						<
					}
					-124 {
						>
							emit {(adjacency graph library)}
						<
					}
					0 {
						>
							emit (zero)
						<
					}
					1 {
						>
							emit {(unsigned char)}
						<
					}
					2 {
						>
							emit {(short integer)}
						<
					}
					3 {
						>
							emit {(float 32)}
						<
					}
					4 {
						>
							emit {(float 64)}
						<
					}
					5 {
						>
							emit {(signed char)}
						<
					}
					6 {
						>
							emit (bit-plane)
						<
					}
					7 {
						>
							emit (classes)
						<
					}
					8 {
						>
							emit (statistics)
						<
					}
					10 {
						>
							emit {(ascii text)}
						<
					}
					15 {
						>
							emit {(image segments)}
						<
					}
					100 {
						>
							emit {(image set)}
						<
					}
					101 {
						>
							emit {(unsigned char vector)}
						<
					}
					102 {
						>
							emit {(short integer vector)}
						<
					}
					103 {
						>
							emit {(float 32 vector)}
						<
					}
					104 {
						>
							emit {(float 64 vector)}
						<
					}
					105 {
						>
							emit {(signed char vector)}
						<
					}
					106 {
						>
							emit {(bit plane vector)}
						<
					}
					121 {
						>
							emit {(feature vector)}
						<
					}
					122 {
						>
							emit {(feature vector library)}
						<
					}
					124 {
						>
							emit {(chain code)}
						<
					}
					126 {
						>
							emit {(bit vector)}
						<
					}
				}
	
				if {[S string 2 0 {} {} eq .VISIX]} {
					>
						emit {(ascii text)}
					<
				}
	
			<
		}
		24672 {
			>
				emit {Dyalog APL transfer}
			<
		}
		29127 {
			>
				emit {cpio archive}
				mime application/x-cpio
			<
		}
	}
	
	if {[S string 0 0 {} {} eq AMANDA:\ ]} {
		>
			emit AMANDA
			if {[S string 8 0 {} {} eq TAPESTART\ DATE]} {
				>
					emit {tape header file,}
					if {[S string 23 0 {} {} eq X]} {
						>
							if {[S string 25 0 {} {} > \ ]} {
								>
									emit {Unused %s}
								<
							}
	
						<
					}
	
					if {[S string 23 0 {} {} > \ ]} {
						>
							emit {DATE %s}
						<
					}
	
				<
			}
	
			if {[S string 8 0 {} {} eq FILE\ ]} {
				>
					emit {dump file,}
					if {[S string 13 0 {} {} > \ ]} {
						>
							emit {DATE %s}
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq FC14]} {
		>
			emit {Future Composer 1.4 Module sound file}
		<
	}
	
	if {[S string 0 0 {} {} eq SMOD]} {
		>
			emit {Future Composer 1.3 Module sound file}
		<
	}
	
	if {[S string 0 0 {} {} eq AON4artofnoise]} {
		>
			emit {Art Of Noise Module sound file}
		<
	}
	
	if {[S string 1 0 {} {} eq MUGICIAN/SOFTEYES]} {
		>
			emit {Mugician Module sound file}
		<
	}
	
	if {[S string 58 0 {} {} eq SIDMON\ II\ -\ THE]} {
		>
			emit {Sidmon 2.0 Module sound file}
		<
	}
	
	if {[S string 0 0 {} {} eq Synth4.0]} {
		>
			emit {Synthesis Module sound file}
		<
	}
	
	if {[S string 0 0 {} {} eq ARP.]} {
		>
			emit {The Holy Noise Module sound file}
		<
	}
	
	if {[S string 0 0 {} {} eq BeEp\0]} {
		>
			emit {JamCracker Module sound file}
		<
	}
	
	if {[S string 0 0 {} {} eq COSO\0]} {
		>
			emit {Hippel-COSO Module sound file}
		<
	}
	
	if {[S string 0 0 {} {} eq \#\#\ version]} {
		>
			emit {catalog translation}
		<
	}
	
	if {[S string 0 0 {} {} eq EMOD\0]} {
		>
			emit {Amiga E module}
		<
	}
	
	if {[S string 8 0 {} {} eq ECXM\0]} {
		>
			emit {ECX module}
		<
	}
	
	if {[S string 0 0 c {} eq @database]} {
		>
			emit {AmigaGuide file}
		<
	}
	
	if {[S string 0 0 {} {} eq RDSK]} {
		>
			emit {Rigid Disk Block}
			if {[S string 160 0 {} {} x {}]} {
				>
					emit {on %.24s}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq DOS\0]} {
		>
			emit {Amiga DOS disk}
		<
	}
	
	if {[S string 0 0 {} {} eq DOS\1]} {
		>
			emit {Amiga FFS disk}
		<
	}
	
	if {[S string 0 0 {} {} eq DOS\2]} {
		>
			emit {Amiga Inter DOS disk}
		<
	}
	
	if {[S string 0 0 {} {} eq DOS\3]} {
		>
			emit {Amiga Inter FFS disk}
		<
	}
	
	if {[S string 0 0 {} {} eq DOS\4]} {
		>
			emit {Amiga Fastdir DOS disk}
		<
	}
	
	if {[S string 0 0 {} {} eq DOS\5]} {
		>
			emit {Amiga Fastdir FFS disk}
		<
	}
	
	if {[S string 0 0 {} {} eq KICK]} {
		>
			emit {Kickstart disk}
		<
	}
	
	if {[S string 0 0 {} {} eq LZX]} {
		>
			emit {LZX compressed archive (Amiga)}
		<
	}
	
	if {[S string 0 0 {} {} eq .KEY]} {
		>
			emit {AmigaDOS script}
		<
	}
	
	if {[S string 0 0 {} {} eq .key]} {
		>
			emit {AmigaDOS script}
		<
	}
	
	if {[S string 0 0 {} {} eq dex\n]} {
		>
			if {[S regex 0 0 {} {} eq dex\n\[0-9\]\{2\}\0]} {
				>
					emit {Dalvik dex file}
				<
			}
	
			if {[S string 4 0 {} {} > 000]} {
				>
					emit {version %s}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq dey\n]} {
		>
			if {[S regex 0 0 {} {} eq dey\n\[0-9\]\{2\}\0]} {
				>
					emit {Dalvik dex file (optimized for host)}
				<
			}
	
			if {[S string 4 0 {} {} > 000]} {
				>
					emit {version %s}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq ANDROID!]} {
		>
			emit {Android bootimg}
			if {[S string 1024 0 {} {} eq LOKI\01]} {
				>
					emit {\b, LOKI'd}
				<
			}
	
			if {[N lelong 8 0 0 {} {} > 0]} {
				>
					emit {\b, kernel}
					if {[N lelong 12 0 0 {} {} > 0]} {
						>
							emit {\b (0x%x)}
						<
					}
	
				<
			}
	
			if {[N lelong 16 0 0 {} {} > 0]} {
				>
					emit {\b, ramdisk}
					if {[N lelong 20 0 0 {} {} > 0]} {
						>
							emit {\b (0x%x)}
						<
					}
	
				<
			}
	
			if {[N lelong 24 0 0 {} {} > 0]} {
				>
					emit {\b, second stage}
					if {[N lelong 28 0 0 {} {} > 0]} {
						>
							emit {\b (0x%x)}
						<
					}
	
				<
			}
	
			if {[N lelong 36 0 0 {} {} > 0]} {
				>
					emit {\b, page size: %d}
				<
			}
	
			if {[S string 38 0 {} {} > 0]} {
				>
					emit {\b, name: %s}
				<
			}
	
			if {[S string 64 0 {} {} > 0]} {
				>
					emit {\b, cmdline (%s)}
				<
			}
	
		<
	}
	
	if {[S string 0 0 b {} eq ANDROID\ BACKUP\n1\n]} {
		>
			emit {Android Backup}
			if {[S string 17 0 {} {} eq 0\n]} {
				>
					emit {\b, Not-Compressed}
				<
			}
	
			if {[S string 17 0 {} {} eq 1\n]} {
				>
					emit {\b, Compressed}
					if {[S regex 19 0 l 1 eq ^(\[^n\n\]|n\[^o\]|no\[^n\]|non\[^e\]|none.+).*]} {
						>
							emit {\b, Encrypted (%s)}
						<
					}
	
					if {[S string 19 0 {} {} eq none\n]} {
						>
							emit {\b, Not-Encrypted}
						<
					}
	
				<
			}
	
		<
	}
	
	switch [Nv ulelong 0 0 {} {}] {
		1 {
			>
				if {[S string 40 0 {} {} eq \ EMF]} {
					>
						emit {Windows Enhanced Metafile (EMF) image data}
						if {[N ulelong 44 0 0 {} {} x {}]} {
							>
								emit {version 0x%x}
							<
						}
	
					<
				}
	
			<
		}
		8127978 {
			>
				emit {pxelinux loader (version 2.13 or older)}
			<
		}
		168627466 {
			>
				if {[N ulelong 8 0 0 {} {} == 439041101]} {
					>
						emit {pcap-ng capture file}
						if {[N leshort 12 0 0 {} {} x {}]} {
							>
								emit {- version %d}
							<
						}
	
						if {[N leshort 14 0 0 {} {} x {}]} {
							>
								emit {\b.%d}
							<
						}
	
					<
				}
	
			<
		}
		305436790 {
			>
				if {[N ulequad 28 0 0 & 18446744060824649724 == 0]} {
					>
						if {[N ulelong 4 0 0 {} {} < 128]} {
							>
								emit {Partition Information Table for Samsung smartphone}
								if {[N ulelong 4 0 0 {} {} x {}]} {
									>
										emit {\b, %d entries}
									<
								}
	
								if {[N ulelong 4 0 0 {} {} > 0]} {
									>
										emit {\b; #1}
									<
								}
	
								U 7 PIT-entry 28
	
								if {[N ulelong 4 0 0 {} {} > 1]} {
									>
										emit {\b; #2}
									<
								}
	
								U 7 PIT-entry 160
	
								if {[N ulelong 4 0 0 {} {} > 2]} {
									>
										emit {\b; #3}
									<
								}
	
								U 7 PIT-entry 292
	
								if {[N ulelong 4 0 0 {} {} > 3]} {
									>
										emit {\b; #4}
									<
								}
	
								U 7 PIT-entry 424
	
								if {[N ulelong 4 0 0 {} {} > 4]} {
									>
										emit {\b; #5}
									<
								}
	
								U 7 PIT-entry 556
	
								if {[N ulelong 4 0 0 {} {} > 5]} {
									>
										emit {\b; #6}
									<
								}
	
								U 7 PIT-entry 688
	
								if {[N ulelong 4 0 0 {} {} > 6]} {
									>
										emit {\b; #7}
									<
								}
	
								U 7 PIT-entry 820
	
								if {[N ulelong 4 0 0 {} {} > 7]} {
									>
										emit {\b; #8}
									<
								}
	
								U 7 PIT-entry 952
	
								if {[N ulelong 4 0 0 {} {} > 8]} {
									>
										emit {\b; #9}
									<
								}
	
								U 7 PIT-entry 1084
	
								if {[N ulelong 4 0 0 {} {} > 9]} {
									>
										emit {\b; #10}
									<
								}
	
								U 7 PIT-entry 1216
	
								if {[N ulelong 4 0 0 {} {} > 10]} {
									>
										emit {\b; #11}
									<
								}
	
								U 7 PIT-entry 1348
	
								if {[N ulelong 4 0 0 {} {} > 11]} {
									>
										emit {\b; #12}
									<
								}
	
								U 7 PIT-entry 1480
	
								if {[N ulelong 4 0 0 {} {} > 12]} {
									>
										emit {\b; #13}
										U 7 PIT-entry 1612
	
									<
								}
	
								if {[N ulelong 4 0 0 {} {} > 13]} {
									>
										emit {\b; #14}
										U 7 PIT-entry 1744
	
									<
								}
	
								if {[N ulelong 4 0 0 {} {} > 14]} {
									>
										emit {\b; #15}
									<
								}
	
								U 7 PIT-entry 1876
	
								if {[N ulelong 4 0 0 {} {} > 15]} {
									>
										emit {\b; #16}
									<
								}
	
								U 7 PIT-entry 2008
	
								if {[N ulelong 4 0 0 {} {} > 16]} {
									>
										emit {\b; #17}
									<
								}
	
								U 7 PIT-entry 2140
	
								if {[N ulelong 4 0 0 {} {} > 17]} {
									>
										emit {\b; #18}
									<
								}
	
								U 7 PIT-entry 2272
	
							<
						}
	
					<
				}
	
			<
		}
		1212429320 {
			>
				emit {4DOS help file}
				if {[S string 4 0 {} {} x {}]} {
					>
						emit {\b, version %-4.4s}
					<
				}
	
			<
		}
		1617337446 {
			>
				emit {pxelinux loader}
			<
		}
		2712847316 {
			>
				emit {tcpdump capture file (little-endian)}
				mime application/vnd.tcpdump.pcap
				U 235 pcap-be 0
	
			<
		}
		2712849716 {
			>
				emit {extended tcpdump capture file (little-endian)}
				U 235 pcap-be 0
	
			<
		}
		3221226986 {
			>
				emit {pxelinux loader (version 3.70 or newer)}
			<
		}
		4294906091 {
			>
				emit {DR-DOS executable (COM)}
			<
		}
	}
	
	switch [Nv lelong 0 0 {} {}] {
		-2147417760 {
			>
				emit {MDEC video stream,}
				if {[N leshort 16 0 0 {} {} x {}]} {
					>
						emit %dx
					<
				}
	
				if {[N leshort 18 0 0 {} {} x {}]} {
					>
						emit {\b%d}
					<
				}
	
			<
		}
		-1728153892 {
			>
				if {[N uleshort 4 0 0 {} {} < 10]} {
					>
						emit {APT cache data, version %u}
						if {[N uleshort 6 0 0 {} {} x {}]} {
							>
								emit {\b.%u, 32 bit little-endian}
							<
						}
	
						U 15 apt-cache-32bit-be 0
	
					<
				}
	
				if {[N ubyte 4 0 0 {} {} > 9]} {
					>
						emit {APT cache data, version %u}
						if {[N ubyte 5 0 0 {} {} x {}]} {
							>
								emit {\b.%u, little-endian}
							<
						}
	
						U 15 apt-cache-be 0
	
					<
				}
	
			<
		}
		-1700603645 {
			>
				emit {Keepass password database}
				switch [Nv lelong 4 0 {} {}] {
					-1253311643 {
						>
							emit {1.x KDB}
							if {[N lelong 48 0 0 {} {} > 0]} {
								>
									emit {\b, %d groups}
								<
							}
	
							if {[N lelong 52 0 0 {} {} > 0]} {
								>
									emit {\b, %d entries}
								<
							}
	
							switch [Nv lelong 8 0 & 15] {
								1 {
									>
										emit {\b, SHA-256}
									<
								}
								2 {
									>
										emit {\b, AES}
									<
								}
								4 {
									>
										emit {\b, RC4}
									<
								}
								8 {
									>
										emit {\b, Twofish}
									<
								}
							}
	
							if {[N lelong 120 0 0 {} {} > 0]} {
								>
									emit {\b, %d key transformation rounds}
								<
							}
	
						<
					}
					-1253311641 {
						>
							emit {2.x KDBX}
						<
					}
				}
	
			<
		}
		-1641380927 {
			>
				emit {Unreal Engine Package,}
				if {[N leshort 4 0 0 {} {} x {}]} {
					>
						emit {version: %i}
					<
				}
	
				if {[N lelong 12 0 0 {} {} != 0]} {
					>
						emit {\b, names: %i}
					<
				}
	
				if {[N lelong 28 0 0 {} {} != 0]} {
					>
						emit {\b, imports: %i}
					<
				}
	
				if {[N lelong 20 0 0 {} {} != 0]} {
					>
						emit {\b, exports: %i}
					<
				}
	
			<
		}
		-1456779524 {
			>
				emit {Linux Software RAID}
				if {[N lelong 4 0 0 {} {} x {}]} {
					>
						emit {version 1.1 (%d)}
					<
				}
	
				U 129 linuxraid 0
	
			<
		}
		-1324630015 {
			>
				switch [Nv lelong 4 0 {} {}] {
					0 {
						>
							emit {Nintendo GameCube disc image (GCZ format)}
							mime application/x-gamecube-rom
						<
					}
					1 {
						>
							emit {Nintendo Wii disc image (GCZ format)}
							mime application/x-wii-rom
						<
					}
				}
	
				if {[D 4]} {
					>
						emit {Nintendo GameCube/Wii disc image (GCZ format)}
					<
				}
	
			<
		}
		-1040441407 {
			>
				emit {Common Trace Format (CTF) trace data (LE)}
			<
		}
		-681629056 {
			>
				emit {Cineon image data}
				if {[N belong 200 0 0 {} {} > 0]} {
					>
						emit {\b, %d x}
					<
				}
	
				if {[N belong 204 0 0 {} {} > 0]} {
					>
						emit %d
					<
				}
	
			<
		}
		-570294007 {
			>
				emit {locale archive}
				if {[N lelong 24 0 0 {} {} x {}]} {
					>
						emit {%d strings}
					<
				}
	
			<
		}
		-332356553 {
			>
				emit {Zstandard dictionary}
				mime application/x-zstd-dictionary
				if {[N lelong 4 0 0 {} {} x {}]} {
					>
						emit {(ID %u)}
					<
				}
	
			<
		}
		-316211398 {
			>
				emit {Android sparse image}
				if {[N leshort 4 0 0 {} {} x {}]} {
					>
						emit {\b, version: %d}
					<
				}
	
				if {[N leshort 6 0 0 {} {} x {}]} {
					>
						emit {\b.%d}
					<
				}
	
				if {[N lelong 16 0 0 {} {} x {}]} {
					>
						emit {\b, Total of %d}
					<
				}
	
				if {[N lelong 12 0 0 {} {} x {}]} {
					>
						emit {\b %d-byte output blocks in}
					<
				}
	
				if {[N lelong 20 0 0 {} {} x {}]} {
					>
						emit {\b %d input chunks.}
					<
				}
	
			<
		}
		-249691108 {
			>
				emit {magic binary file for file(1) cmd}
				if {[N lelong 4 0 0 {} {} x {}]} {
					>
						emit {(version %d) (little endian)}
					<
				}
	
			<
		}
		-109248628 {
			>
				emit {SE Linux policy}
				if {[N lelong 16 0 0 {} {} x {}]} {
					>
						emit v%d
					<
				}
	
				if {[N lelong 20 0 0 {} {} == 1]} {
					>
						emit MLS
					<
				}
	
				if {[N lelong 24 0 0 {} {} x {}]} {
					>
						emit {%d symbols}
					<
				}
	
				if {[N lelong 28 0 0 {} {} x {}]} {
					>
						emit {%d ocons}
					<
				}
	
			<
			>
				emit {SE Linux policy}
				if {[N lelong 16 0 0 {} {} x {}]} {
					>
						emit v%d
					<
				}
	
				if {[N lelong 20 0 0 {} {} == 1]} {
					>
						emit MLS
					<
				}
	
				if {[N lelong 24 0 0 {} {} x {}]} {
					>
						emit {%d symbols}
					<
				}
	
				if {[N lelong 28 0 0 {} {} x {}]} {
					>
						emit {%d ocons}
					<
				}
	
			<
			>
				emit {SE Linux policy}
				if {[N lelong 16 0 0 {} {} x {}]} {
					>
						emit v%d
					<
				}
	
				if {[N lelong 20 0 0 {} {} == 1]} {
					>
						emit MLS
					<
				}
	
				if {[N lelong 24 0 0 {} {} x {}]} {
					>
						emit {%d symbols}
					<
				}
	
				if {[N lelong 28 0 0 {} {} x {}]} {
					>
						emit {%d ocons}
					<
				}
	
			<
		}
		-109248625 {
			>
				emit {SE Linux modular policy}
				if {[N lelong 4 0 0 {} {} x {}]} {
					>
						emit {version %d,}
					<
				}
	
				if {[N lelong 8 0 0 {} {} x {}]} {
					>
						emit {%d sections,}
						if {[N lelong [I 12 ulelong 0 + 0 0] 0 0 {} {} == -109248627]} {
							>
								if {[N lelong [I 12 ulelong 0 + 0 27] 0 0 {} {} x {}]} {
									>
										emit {mod version %d,}
									<
								}
	
								switch [Nv lelong [I 12 ulelong 0 + 0 31] 0 {} {}] {
									0 {
										>
											emit {Not MLS,}
										<
									}
									1 {
										>
											emit MLS,
										<
									}
								}
	
								switch [Nv lelong [I 12 ulelong 0 + 0 23] 0 {} {}] {
									1 {
										>
											emit base
										<
									}
									2 {
										>
											if {[S string [I 12 ulelong 0 + 0 47] 0 {} {} > \0]} {
												>
													emit {module name %s}
												<
											}
	
										<
									}
								}
	
							<
						}
	
					<
				}
	
			<
		}
		-47205086 {
			>
				emit {Zstandard compressed data (v0.2)}
				mime application/x-zstd
			<
		}
		-47205085 {
			>
				emit {Zstandard compressed data (v0.3)}
				mime application/x-zstd
			<
		}
		-47205084 {
			>
				emit {Zstandard compressed data (v0.4)}
				mime application/x-zstd
			<
		}
		-47205083 {
			>
				emit {Zstandard compressed data (v0.5)}
				mime application/x-zstd
			<
		}
		-47205082 {
			>
				emit {Zstandard compressed data (v0.6)}
				mime application/x-zstd
			<
		}
		-47205081 {
			>
				emit {Zstandard compressed data (v0.7)}
				mime application/x-zstd
				U 50 zstd-dictionary-id 4
	
			<
		}
		-47205080 {
			>
				emit {Zstandard compressed data (v0.8+)}
				mime application/x-zstd
				U 50 zstd-dictionary-id 4
	
			<
		}
		-21555 {
			>
				emit {MLSSA datafile,}
				if {[N leshort 4 0 0 {} {} x {}]} {
					>
						emit {algorithm %d,}
					<
				}
	
				if {[N lelong 10 0 0 {} {} x {}]} {
					>
						emit {%d samples}
					<
				}
	
			<
		}
		1 {
			>
				if {[N lelong 4 0 0 {} {} == 100]} {
					>
						if {[N lelong 8 0 0 {} {} == 10000]} {
							>
								if {[N lelong 12 0 0 {} {} == 50]} {
									>
										if {[N lelong 16 0 0 {} {} == 50000]} {
											>
												if {[N lelong 20 0 0 {} {} == 100]} {
													>
														if {[N lelong 24 0 0 {} {} == 1000]} {
															>
																if {[N lelong 28 0 0 {} {} == 1000]} {
																	>
																		if {[N lelong 36 0 0 {} {} == 10]} {
																			>
																				if {[N lelong 40 0 0 {} {} == 100]} {
																					>
																						if {[N lelong 32 0 0 {} {} x {}]} {
																							>
																								emit {LG robot VR6[234]xx %dm^2 navigation}
																							<
																						}
	
																						switch [Nv lelong 136040 0 {} {}] {
																							-1 {
																								>
																									emit {reuse map data}
																								<
																							}
																							0 {
																								>
																									emit {map data}
																								<
																							}
																						}
	
																						if {[N lelong 136040 0 0 {} {} > 0]} {
																							>
																								emit {spurious map data}
																							<
																						}
	
																						if {[N lelong 136040 0 0 {} {} < -1]} {
																							>
																								emit {spurious map data}
																							<
																						}
	
																					<
																				}
	
																			<
																		}
	
																	<
																}
	
															<
														}
	
													<
												}
	
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
			<
		}
		4 {
			>
				if {[N lelong 104 0 0 {} {} == 4]} {
					>
						emit {X11 SNF font data, LSB first}
						mime application/x-font-sfn
					<
				}
	
			<
			>
				if {[N lelong 12 0 0 {} {} == 280]} {
					>
						emit {Windows Recycle Bin INFO2 file (Win98 or below)}
					<
				}
	
			<
		}
		5 {
			>
				if {[N lelong 12 0 0 {} {} == 800]} {
					>
						emit {Windows Recycle Bin INFO2 file (Win2k - WinXP)}
					<
				}
	
			<
		}
		16 {
			>
				emit {TIM image,}
				switch [Nv lelong 4 0 {} {}] {
					2 {
						>
							emit 15-Bit,
						<
					}
					3 {
						>
							emit 24-Bit,
						<
					}
					8 {
						>
							emit 4-Bit,
						<
					}
					9 {
						>
							emit 8-Bit,
						<
					}
				}
	
				if {[N lelong 4 0 0 {} {} & 8]} {
					>
						if {[N leshort [I 8 ulelong 0 + 0 12] 0 0 {} {} x {}]} {
							>
								emit {Pixel at (%d,}
							<
						}
	
						if {[N leshort [I 8 ulelong 0 + 0 14] 0 0 {} {} x {}]} {
							>
								emit {\b%d)}
							<
						}
	
						if {[N leshort [I 8 ulelong 0 + 0 16] 0 0 {} {} x {}]} {
							>
								emit Size=%dx
							<
						}
	
						if {[N leshort [I 8 ulelong 0 + 0 18] 0 0 {} {} x {}]} {
							>
								emit {\b%d,}
							<
						}
	
						switch [Nv lelong 4 0 {} {}] {
							8 {
								>
									emit {16 CLUT Entries at}
								<
							}
							9 {
								>
									emit {256 CLUT Entries at}
								<
							}
						}
	
						if {[N leshort 12 0 0 {} {} x {}]} {
							>
								emit (%d,
							<
						}
	
						if {[N leshort 14 0 0 {} {} x {}]} {
							>
								emit {\b%d)}
							<
						}
	
					<
				}
	
				if {[N lelong 4 0 0 {} {} ^ 8]} {
					>
						if {[N leshort 12 0 0 {} {} x {}]} {
							>
								emit {Pixel at (%d,}
							<
						}
	
						if {[N leshort 14 0 0 {} {} x {}]} {
							>
								emit {\b%d)}
							<
						}
	
						if {[N leshort 16 0 0 {} {} x {}]} {
							>
								emit Size=%dx
							<
						}
	
						if {[N leshort 18 0 0 {} {} x {}]} {
							>
								emit {\b%d}
							<
						}
	
					<
				}
	
			<
		}
		76 {
			>
				if {[N lelong 4 0 0 {} {} == 136193]} {
					>
						emit {Windows shortcut file}
					<
				}
	
			<
		}
		204 {
			>
				emit {386 compact demand paged pure executable}
				if {[N lelong 16 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				if {[N byte 32 0 0 {} {} == 106]} {
					>
						emit {(uses shared libs)}
					<
				}
	
			<
		}
		234 {
			>
				emit {BALANCE NS32000 .o}
				if {[N lelong 16 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				if {[N lelong 124 0 0 {} {} > 0]} {
					>
						emit {version %d}
					<
				}
	
			<
		}
		263 {
			>
				emit {a.out little-endian 32-bit executable}
				if {[N lelong 16 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				if {[N byte 32 0 0 {} {} == 106]} {
					>
						emit {(uses BSD/OS shared libs)}
					<
				}
	
			<
		}
		264 {
			>
				emit {a.out little-endian 32-bit pure executable}
				if {[N lelong 16 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				if {[N byte 32 0 0 {} {} == 106]} {
					>
						emit {(uses BSD/OS shared libs)}
					<
				}
	
			<
		}
		267 {
			>
				emit {a.out little-endian 32-bit demand paged pure executable}
				if {[N lelong 16 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				if {[N byte 32 0 0 {} {} == 106]} {
					>
						emit {(uses BSD/OS shared libs)}
					<
				}
	
			<
		}
		272 {
			>
				emit {a.out VAX demand paged (first page unmapped) pure executable}
				if {[N lelong 16 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		518 {
			>
				emit b.out
				if {[N leshort 30 0 0 {} {} & 16]} {
					>
						emit overlay
					<
				}
	
				if {[N leshort 30 0 0 {} {} & 2]} {
					>
						emit separate
					<
				}
	
				if {[N leshort 30 0 0 {} {} & 4]} {
					>
						emit pure
					<
				}
	
				if {[N leshort 30 0 0 {} {} & 2048]} {
					>
						emit segmented
					<
				}
	
				if {[N leshort 30 0 0 {} {} & 1024]} {
					>
						emit standalone
					<
				}
	
				if {[N leshort 30 0 0 {} {} & 1]} {
					>
						emit executable
					<
				}
	
				if {[N leshort 30 0 0 {} {} ^ 1]} {
					>
						emit {object file}
					<
				}
	
				if {[N leshort 30 0 0 {} {} & 16384]} {
					>
						emit V2.3
					<
				}
	
				if {[N leshort 30 0 0 {} {} & -32768]} {
					>
						emit V3.0
					<
				}
	
				if {[N byte 28 0 0 {} {} & 4]} {
					>
						emit 86
					<
				}
	
				if {[N byte 28 0 0 {} {} & 11]} {
					>
						emit 186
					<
				}
	
				if {[N byte 28 0 0 {} {} & 9]} {
					>
						emit 286
					<
				}
	
				if {[N byte 28 0 0 {} {} & 41]} {
					>
						emit 286
					<
				}
	
				if {[N byte 28 0 0 {} {} & 10]} {
					>
						emit 386
					<
				}
	
				if {[N leshort 30 0 0 {} {} & 4]} {
					>
						emit {Large Text}
					<
				}
	
				if {[N leshort 30 0 0 {} {} & 2]} {
					>
						emit {Large Data}
					<
				}
	
				if {[N leshort 30 0 0 {} {} & 258]} {
					>
						emit {Huge Objects Enabled}
					<
				}
	
			<
		}
		4330 {
			>
				emit {BALANCE NS32000 executable (0 @ 0)}
				if {[N lelong 16 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				if {[N lelong 124 0 0 {} {} > 0]} {
					>
						emit {version %d}
					<
				}
	
			<
		}
		8426 {
			>
				emit {BALANCE NS32000 executable (invalid @ 0)}
				if {[N lelong 16 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				if {[N lelong 124 0 0 {} {} > 0]} {
					>
						emit {version %d}
					<
				}
	
			<
		}
		12522 {
			>
				emit {BALANCE NS32000 standalone executable}
				if {[N lelong 16 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				if {[N lelong 124 0 0 {} {} > 0]} {
					>
						emit {version %d}
					<
				}
	
			<
		}
		33644 {
			>
				emit {PDP-11 double precision APL workspace}
			<
		}
		33645 {
			>
				emit {PDP-11 single precision APL workspace}
			<
		}
		33646 {
			>
				emit {VAX double precision APL workspace}
			<
		}
		33647 {
			>
				emit {VAX single precision APL workspace}
			<
		}
		65381 {
			>
				emit {old 32-bit-int little-endian archive}
				if {[S string 4 0 {} {} eq __.SYMDEF]} {
					>
						emit {random library}
					<
				}
	
			<
		}
		65389 {
			>
				emit {very old 32-bit-int little-endian archive}
			<
		}
		220991 {
			>
				if {[N uleshort [I 4 ulelong 0 + 0 9] 0 0 {} {} == 10555]} {
					>
						emit MS
						if {[S string 212 0 {} {} eq \x62\x6D\x66\x01\x00]} {
							>
								emit {Windows help annotation}
								mime application/x-winhelp
								ext ann
							<
						}
	
						if {[S string 212 0 {} {} ne \x62\x6D\x66\x01\x00]} {
							>
								if {[S string [I 4 ulelong 0 + 0 101] 0 {} {} eq |Pete]} {
									>
										emit {Windows help Global Index}
										mime application/x-winhelp
										ext gid
									<
								}
	
								if {[S string [I 4 ulelong 0 + 0 101] 0 {} {} ne |Pete]} {
									>
										if {[S search 16 0 {} 18863 eq s]} {
											>
												emit {\x6c\x03}
												U 275 help-ver-date [R 0]
	
												if {[N leshort [R 4] 0 0 {} {} != 1]} {
													>
														if {[S search [R 0] 0 {} 27055 eq s]} {
															>
																emit {\x6c\x03}
																U 275 help-ver-date [R 0]
	
																if {[N leshort [R 4] 0 0 {} {} != 1]} {
																	>
																		if {[S search [R 0] 0 {} 18863 eq s]} {
																			>
																				emit {\x6c\x03}
																				U 275 help-ver-date [R 0]
	
																				if {[N leshort [R 4] 0 0 {} {} != 1]} {
																					>
																						if {[S search [R 0] 0 {} 18863 eq s]} {
																							>
																								emit {\x6c\x03}
																								U 275 help-ver-date [R 0]
	
																								if {[N leshort [R 4] 0 0 {} {} != 1]} {
																									>
																										if {[S search [R 0] 0 {} 18863 eq s]} {
																											>
																												emit {\x6c\x03}
																												U 275 help-ver-date [R 0]
	
																												if {[N leshort [R 4] 0 0 {} {} != 1]} {
																													>
																														if {[S search [R 0] 0 {} 18863 eq s]} {
																															>
																																emit {\x6c\x03}
																																U 275 help-ver-date [R 0]
	
																																if {[N leshort [R 4] 0 0 {} {} != 1]} {
																																	>
																																		if {[S search [R 0] 0 {} 18863 eq s]} {
																																			>
																																				emit {\x6c\x03}
																																				U 275 help-ver-date [R 0]
	
																																				if {[N leshort [R 4] 0 0 {} {} != 1]} {
																																					>
																																						emit {Windows y.z help}
																																						mime application/winhelp
																																						ext hlp
																																					<
																																				}
	
																																			<
																																		}
	
																																	<
																																}
	
																															<
																														}
	
																													<
																												}
	
																											<
																										}
	
																									<
																								}
	
																							<
																						}
	
																					<
																				}
	
																			<
																		}
	
																	<
																}
	
															<
														}
	
													<
												}
	
											<
										}
	
										if {[S search 16 0 {} 18863 eq s]} {
											>
												emit {\x6c\x03}
											<
										}
	
										if {[D 16]} {
											>
												emit {Windows help Bookmark}
												mime application/x-winhelp
												ext bmk
											<
										}
	
									<
								}
	
							<
						}
	
						if {[N lelong 12 0 0 {} {} x {}]} {
							>
								emit {\b, %d bytes}
							<
						}
	
					<
				}
	
			<
		}
		236525 {
			>
				emit {PDP-11 old archive}
			<
		}
		236526 {
			>
				emit {PDP-11 4.0 archive}
			<
		}
		340322 {
			>
				emit {Berkeley DB 1.85/1.86}
				if {[N lelong 4 0 0 {} {} > 0]} {
					>
						emit {(Btree, version %d, little-endian)}
					<
				}
	
			<
		}
		459106 {
			>
				emit {LFS filesystem image}
				switch [Nv lelong 4 0 {} {}] {
					1 {
						>
							emit {version 1,}
							if {[N lelong 8 0 0 {} {} x {}]} {
								>
									emit {\b blocks %u,}
								<
							}
	
							if {[N lelong 12 0 0 {} {} x {}]} {
								>
									emit {\b blocks per segment %u,}
								<
							}
	
						<
					}
					2 {
						>
							emit {version 2,}
							if {[N lelong 8 0 0 {} {} x {}]} {
								>
									emit {\b fragments %u,}
								<
							}
	
							if {[N lelong 12 0 0 {} {} x {}]} {
								>
									emit {\b bytes per segment %u,}
								<
							}
	
						<
					}
				}
	
				if {[N lelong 16 0 0 {} {} x {}]} {
					>
						emit {\b disk blocks %u,}
					<
				}
	
				if {[N lelong 20 0 0 {} {} x {}]} {
					>
						emit {\b block size %u,}
					<
				}
	
				if {[N lelong 24 0 0 {} {} x {}]} {
					>
						emit {\b fragment size %u,}
					<
				}
	
				if {[N lelong 28 0 0 {} {} x {}]} {
					>
						emit {\b fragments per block %u,}
					<
				}
	
				if {[N lelong 32 0 0 {} {} x {}]} {
					>
						emit {\b start for free list %u,}
					<
				}
	
				if {[N lelong 36 0 0 {} {} x {}]} {
					>
						emit {\b number of free blocks %d,}
					<
				}
	
				if {[N lelong 40 0 0 {} {} x {}]} {
					>
						emit {\b number of files %u,}
					<
				}
	
				if {[N lelong 44 0 0 {} {} x {}]} {
					>
						emit {\b blocks available for writing %d,}
					<
				}
	
				if {[N lelong 48 0 0 {} {} x {}]} {
					>
						emit {\b inodes in cache %d,}
					<
				}
	
				if {[N lelong 52 0 0 {} {} x {}]} {
					>
						emit {\b inode file disk address 0x%x,}
					<
				}
	
				if {[N lelong 56 0 0 {} {} x {}]} {
					>
						emit {\b inode file inode number %u,}
					<
				}
	
				if {[N lelong 60 0 0 {} {} x {}]} {
					>
						emit {\b address of last segment written 0x%x,}
					<
				}
	
				if {[N lelong 64 0 0 {} {} x {}]} {
					>
						emit {\b address of next segment to write 0x%x,}
					<
				}
	
				if {[N lelong 68 0 0 {} {} x {}]} {
					>
						emit {\b address of current segment written 0x%x}
					<
				}
	
			<
		}
		459141 {
			>
				emit {ECOFF NetBSD/alpha binary}
				switch [Nv leshort 10 0 {} {}] {
					0 {
						>
							emit stripped
						<
					}
					1 {
						>
							emit {not stripped}
						<
					}
				}
	
			<
		}
		524291 {
			>
				emit {Android binary XML}
			<
		}
		1638399 {
			>
				emit {GEM Metafile data}
				if {[N leshort 4 0 0 {} {} x {}]} {
					>
						emit {version %d}
					<
				}
	
			<
		}
		6553804 {
			>
				emit {Linux/i386 demand-paged executable (QMAGIC)}
				if {[N lelong 16 0 0 {} {} == 0]} {
					>
						emit {\b, stripped}
					<
				}
	
			<
		}
		6553863 {
			>
				emit {Linux/i386 impure executable (OMAGIC)}
				if {[N lelong 16 0 0 {} {} == 0]} {
					>
						emit {\b, stripped}
					<
				}
	
			<
		}
		6553864 {
			>
				emit {Linux/i386 pure executable (NMAGIC)}
				if {[N lelong 16 0 0 {} {} == 0]} {
					>
						emit {\b, stripped}
					<
				}
	
			<
		}
		6553867 {
			>
				emit {Linux/i386 demand-paged executable (ZMAGIC)}
				if {[N lelong 16 0 0 {} {} == 0]} {
					>
						emit {\b, stripped}
					<
				}
	
			<
		}
		6583086 {
			>
				emit {DEC audio data:}
				switch [Nv lelong 12 0 {} {}] {
					1 {
						>
							emit {8-bit ISDN mu-law,}
							mime audio/x-dec-basic
						<
					}
					2 {
						>
							emit {8-bit linear PCM [REF-PCM],}
							mime audio/x-dec-basic
						<
					}
					3 {
						>
							emit {16-bit linear PCM,}
							mime audio/x-dec-basic
						<
					}
					4 {
						>
							emit {24-bit linear PCM,}
							mime audio/x-dec-basic
						<
					}
					5 {
						>
							emit {32-bit linear PCM,}
							mime audio/x-dec-basic
						<
					}
					6 {
						>
							emit {32-bit IEEE floating point,}
							mime audio/x-dec-basic
						<
					}
					7 {
						>
							emit {64-bit IEEE floating point,}
							mime audio/x-dec-basic
						<
					}
					23 {
						>
							emit {8-bit ISDN mu-law compressed (CCITT G.721 ADPCM voice enc.),}
							mime audio/x-dec-basic
						<
					}
				}
	
				switch [Nv belong 12 0 {} {}] {
					8 {
						>
							emit {Fragmented sample data,}
						<
					}
					10 {
						>
							emit {DSP program,}
						<
					}
					11 {
						>
							emit {8-bit fixed point,}
						<
					}
					12 {
						>
							emit {16-bit fixed point,}
						<
					}
					13 {
						>
							emit {24-bit fixed point,}
						<
					}
					14 {
						>
							emit {32-bit fixed point,}
						<
					}
					18 {
						>
							emit {16-bit linear with emphasis,}
						<
					}
					19 {
						>
							emit {16-bit linear compressed,}
						<
					}
					20 {
						>
							emit {16-bit linear with emphasis and compression,}
						<
					}
					21 {
						>
							emit {Music kit DSP commands,}
						<
					}
					24 {
						>
							emit {compressed (8-bit CCITT G.722 ADPCM)}
						<
					}
					25 {
						>
							emit {compressed (3-bit CCITT G.723.3 ADPCM),}
						<
					}
					26 {
						>
							emit {compressed (5-bit CCITT G.723.5 ADPCM),}
						<
					}
					27 {
						>
							emit {8-bit A-law (CCITT G.711),}
						<
					}
				}
	
				switch [Nv lelong 20 0 {} {}] {
					1 {
						>
							emit mono,
						<
					}
					2 {
						>
							emit stereo,
						<
					}
					4 {
						>
							emit quad,
						<
					}
				}
	
				if {[N lelong 16 0 0 {} {} > 0]} {
					>
						emit {%d Hz}
					<
				}
	
			<
		}
		16922978 {
			>
				emit {mdbm file, version 0 (obsolete)}
			<
		}
		20000630 {
			>
				emit {OpenEXR image data,}
				mime image/x-exr
				if {[N lelong 4 0 0 & 255 x {}]} {
					>
						emit {version %d,}
					<
				}
	
				if {[N lelong 4 0 0 {} {} ^ 512]} {
					>
						emit {storage: scanline}
					<
				}
	
				if {[N lelong 4 0 0 {} {} & 512]} {
					>
						emit {storage: tiled}
					<
				}
	
				if {[S search 8 0 {} 4096 eq compression\0]} {
					>
						emit {\b, compression:}
						switch [Nv byte [R 16] 0 {} {}] {
							0 {
								>
									emit none
								<
							}
							1 {
								>
									emit rle
								<
							}
							2 {
								>
									emit zips
								<
							}
							3 {
								>
									emit zip
								<
							}
							4 {
								>
									emit piz
								<
							}
							5 {
								>
									emit pxr24
								<
							}
							6 {
								>
									emit b44
								<
							}
							7 {
								>
									emit b44a
								<
							}
							8 {
								>
									emit dwaa
								<
							}
							9 {
								>
									emit dwab
								<
							}
						}
	
						if {[N byte [R 16] 0 0 {} {} > 9]} {
							>
								emit unknown
							<
						}
	
					<
				}
	
				if {[S search 8 0 {} 4096 eq dataWindow\0]} {
					>
						emit {\b, dataWindow:}
						if {[N lelong [R 10] 0 0 {} {} x {}]} {
							>
								emit (%d
							<
						}
	
						if {[N lelong [R 14] 0 0 {} {} x {}]} {
							>
								emit %d)-
							<
						}
	
						if {[N lelong [R 18] 0 0 {} {} x {}]} {
							>
								emit {\b(%d}
							<
						}
	
						if {[N lelong [R 22] 0 0 {} {} x {}]} {
							>
								emit %d)
							<
						}
	
					<
				}
	
				if {[S search 8 0 {} 4096 eq displayWindow\0]} {
					>
						emit {\b, displayWindow:}
						if {[N lelong [R 10] 0 0 {} {} x {}]} {
							>
								emit (%d
							<
						}
	
						if {[N lelong [R 14] 0 0 {} {} x {}]} {
							>
								emit %d)-
							<
						}
	
						if {[N lelong [R 18] 0 0 {} {} x {}]} {
							>
								emit {\b(%d}
							<
						}
	
						if {[N lelong [R 22] 0 0 {} {} x {}]} {
							>
								emit %d)
							<
						}
	
					<
				}
	
				if {[S search 8 0 {} 4096 eq lineOrder\0]} {
					>
						emit {\b, lineOrder:}
						switch [Nv byte [R 14] 0 {} {}] {
							0 {
								>
									emit {increasing y}
								<
							}
							1 {
								>
									emit {decreasing y}
								<
							}
							2 {
								>
									emit {random y}
								<
							}
						}
	
						if {[N byte [R 14] 0 0 {} {} > 2]} {
							>
								emit unknown
							<
						}
	
					<
				}
	
			<
		}
		38177486 {
			>
				emit {Bochs Sparse disk image}
			<
		}
		101718065 {
			>
				if {[N leshort 22 0 0 {} {} == 0]} {
					>
						emit {UBIfs image}
					<
				}
	
				if {[N lequad 8 0 0 {} {} x {}]} {
					>
						emit {\b, sequence number %llu}
					<
				}
	
				if {[N leshort 16 0 0 {} {} x {}]} {
					>
						emit {\b, length %u}
					<
				}
	
				if {[N lelong 4 0 0 {} {} x {}]} {
					>
						emit {\b, CRC 0x%08x}
					<
				}
	
			<
		}
		119734787 {
			>
				emit {Khronos SPIR-V binary, little-endian}
				if {[N lelong 4 0 0 {} {} x {}]} {
					>
						emit {\b, version 0x%08x}
					<
				}
	
				if {[N lelong 8 0 0 {} {} x {}]} {
					>
						emit {\b, generator 0x%08x}
					<
				}
	
			<
		}
		134761296 {
			>
				emit {TurboC Font file}
			<
		}
		134769520 {
			>
				emit {TurboC BGI file}
			<
		}
		186106078 {
			>
				emit {LLVM bitcode, wrapper}
				switch [Nv lelong 16 0 {} {}] {
					7 {
						>
							emit i386
						<
					}
					12 {
						>
							emit arm
						<
					}
					18 {
						>
							emit ppc
						<
					}
					16777223 {
						>
							emit x86_64
						<
					}
					16777234 {
						>
							emit ppc64
						<
					}
				}
	
			<
		}
		250739385 {
			>
				switch [Nv lelong 4 0 {} {}] {
					1 {
						>
							emit {Universal EFI binary with 1 architecture}
							switch [Nv lelong [R 0] 0 {} {}] {
								7 {
									>
										emit {\b, i386}
									<
								}
								16777223 {
									>
										emit {\b, x86_64}
									<
								}
							}
	
						<
					}
					2 {
						>
							emit {Universal EFI binary with 2 architectures}
							switch [Nv lelong [R 0] 0 {} {}] {
								7 {
									>
										emit {\b, i386}
									<
								}
								16777223 {
									>
										emit {\b, x86_64}
									<
								}
							}
	
							switch [Nv lelong [R 20] 0 {} {}] {
								7 {
									>
										emit {\b, i386}
									<
								}
								16777223 {
									>
										emit {\b, x86_64}
									<
								}
							}
	
						<
					}
				}
	
				if {[N lelong 4 0 0 {} {} > 2]} {
					>
						emit {Universal EFI binary with %d architectures}
					<
				}
	
			<
		}
		267429210 {
			>
				emit {Intel serial flash for ICH/PCH ROM <= 5 or 3400 series A-step}
			<
		}
		268435511 {
			>
				emit {Psion Series 5}
				switch [Nv lelong 4 0 {} {}] {
					268435513 {
						>
							emit {font file}
						<
					}
					268435514 {
						>
							emit {printer driver}
						<
					}
					268435515 {
						>
							emit clipboard
						<
					}
					268435522 {
						>
							emit {multi-bitmap image}
							mime image/x-epoc-mbm
						<
					}
					268435562 {
						>
							emit {application information file}
						<
					}
					268435565 {
						>
							switch [Nv lelong 8 0 {} {}] {
								268435581 {
									>
										emit {Sketch image}
										mime image/x-epoc-sketch
									<
								}
								268435582 {
									>
										emit {voice note}
									<
								}
								268435583 {
									>
										emit {Word file}
										mime application/x-epoc-word
									<
								}
								268435589 {
									>
										emit {OPL program (TextEd)}
										mime application/x-epoc-opl
									<
								}
								268435591 {
									>
										emit {Comms settings}
									<
								}
								268435592 {
									>
										emit {Sheet file}
										mime application/x-epoc-sheet
									<
								}
								268435908 {
									>
										emit {EasyFax initialisation file}
									<
								}
							}
	
						<
					}
					268435571 {
						>
							emit {OPO module}
							mime application/x-epoc-opo
						<
					}
					268435572 {
						>
							emit {OPL application}
							mime application/x-epoc-app
						<
					}
					268435594 {
						>
							emit {exported multi-bitmap image}
						<
					}
					268435821 {
						>
							if {[N lelong 8 0 0 {} {} == 268435591]} {
								>
									emit {Comms names}
								<
							}
	
						<
					}
				}
	
			<
		}
		268435521 {
			>
				emit {Psion Series 5 ROM multi-bitmap image}
			<
		}
		268435536 {
			>
				emit {Psion Series 5}
				switch [Nv lelong 4 0 {} {}] {
					268435565 {
						>
							emit database
							switch [Nv lelong 8 0 {} {}] {
								268435588 {
									>
										emit {Agenda file}
										mime application/x-epoc-agenda
									<
								}
								268435590 {
									>
										emit {Data file}
										mime application/x-epoc-data
									<
								}
								268438762 {
									>
										emit {Jotter file}
										mime application/x-epoc-jotter
									<
								}
							}
	
						<
					}
					268435684 {
						>
							emit {ini file}
						<
					}
				}
	
			<
		}
		268435577 {
			>
				emit {Psion Series 5 binary:}
				switch [Nv lelong 4 0 {} {}] {
					0 {
						>
							emit DLL
						<
					}
					268435529 {
						>
							emit {comms hardware library}
						<
					}
					268435530 {
						>
							emit {comms protocol library}
						<
					}
					268435549 {
						>
							emit OPX
						<
					}
					268435564 {
						>
							emit application
						<
					}
					268435597 {
						>
							emit DLL
						<
					}
					268435628 {
						>
							emit {logical device driver}
						<
					}
					268435629 {
						>
							emit {physical device driver}
						<
					}
					268435685 {
						>
							emit {file transfer protocol}
						<
						>
							emit {file transfer protocol}
						<
					}
					268435776 {
						>
							emit {printer definition}
						<
					}
					268435777 {
						>
							emit {printer definition}
						<
					}
				}
	
			<
		}
		268435578 {
			>
				emit {Psion Series 5 executable}
			<
		}
		270539386 {
			>
				emit {Symbian installation file (Symbian OS 9.x)}
				mime x-epoc/x-sisx-app
			<
		}
		320013059 {
			>
				emit {SpeedShop data file}
			<
		}
		324508365 {
			>
				emit {GNU dbm 1.x or ndbm database, little endian, 32-bit}
				mime application/x-gdbm
			<
		}
		324508366 {
			>
				emit {GNU dbm 1.x or ndbm database, little endian, old}
				mime application/x-gdbm
			<
		}
		324508367 {
			>
				emit {GNU dbm 1.x or ndbm database, little endian, 64-bit}
				mime application/x-gdbm
			<
		}
		329904510 {
			>
				emit {ST40 component image format}
				if {[S string 4 0 {} {} > \0]} {
					>
						emit {\b, name '%s'}
					<
				}
	
			<
		}
		336851773 {
			>
				emit {SYSLINUX' LSS16 image data}
				mime image/x-lss16
				if {[N leshort 4 0 0 {} {} x {}]} {
					>
						emit {\b, width %d}
					<
				}
	
				if {[N leshort 6 0 0 {} {} x {}]} {
					>
						emit {\b, height %d}
					<
				}
	
			<
		}
		407642370 {
			>
				emit {LZ4 compressed data (v0.1-v0.9)}
				mime application/x-lz4
			<
		}
		407642371 {
			>
				emit {LZ4 compressed data (v1.0-v1.3)}
				mime application/x-lz4
			<
		}
		407708164 {
			>
				emit {LZ4 compressed data (v1.4+)}
				mime application/x-lz4
			<
		}
		453186358 {
			>
				emit {L	Netboot image,}
				if {[N lelong 4 0 0 & -256 == 0]} {
					>
						switch [Nv lelong 4 0 & 256] {
							0 {
								>
									emit {mode 2}
								<
							}
							256 {
								>
									emit {mode 3}
								<
							}
						}
	
					<
				}
	
				if {[N lelong 4 0 0 & -256 != 0]} {
					>
						emit {unknown mode}
					<
				}
	
			<
		}
		536937252 {
			>
				emit {gconv module configuration cache data}
			<
		}
		574529400 {
			>
				emit {Transport Neutral Encapsulation Format}
				mime application/vnd.ms-tnef
			<
			>
				emit TNEF
				mime application/vnd.ms-tnef
			<
		}
		592003669 {
			>
				if {[N leshort 4 0 0 {} {} < 2]} {
					>
					<
				}
	
				if {[S string 5 0 {} {} eq \0\0\0]} {
					>
					<
				}
	
				if {[S string 28 0 {} {} eq \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0]} {
					>
					<
				}
	
				if {[N leshort 4 0 0 {} {} x {}]} {
					>
						emit {UBI image, version %u}
					<
				}
	
			<
		}
		684539205 {
			>
				emit {Linux Compressed ROM File System data, little endian}
				if {[N lelong 4 0 0 {} {} x {}]} {
					>
						emit {size %u}
					<
				}
	
				if {[N lelong 8 0 0 {} {} & 1]} {
					>
						emit {version #2}
					<
				}
	
				if {[N lelong 8 0 0 {} {} & 2]} {
					>
						emit sorted_dirs
					<
				}
	
				if {[N lelong 8 0 0 {} {} & 4]} {
					>
						emit hole_support
					<
				}
	
				if {[N lelong 32 0 0 {} {} x {}]} {
					>
						emit {CRC 0x%x,}
					<
				}
	
				if {[N lelong 36 0 0 {} {} x {}]} {
					>
						emit {edition %u,}
					<
				}
	
				if {[N lelong 40 0 0 {} {} x {}]} {
					>
						emit {%u blocks,}
					<
				}
	
				if {[N lelong 44 0 0 {} {} x {}]} {
					>
						emit {%u files}
					<
				}
	
			<
		}
		876099889 {
			>
				emit {Linux Journalled Flash File system, little endian}
			<
		}
		987654321 {
			>
				emit {DCX multi-page PCX image data}
			<
		}
		1160843812 {
			>
				emit {iproute2 routes dump}
			<
		}
		1194725922 {
			>
				emit {iproute2 addresses dump}
			<
		}
		1279543401 {
			>
				emit {ld.so hints file (Little Endian}
				if {[N lelong 4 0 0 {} {} > 0]} {
					>
						emit {\b, version %d)}
					<
				}
	
				if {[N belong 4 0 0 {} {} < 1]} {
					>
						emit {\b)}
					<
				}
	
			<
		}
		1313096225 {
			>
				emit {Microsoft Outlook email folder}
				switch [Nv leshort 10 0 {} {}] {
					14 {
						>
							emit (<=2002)
						<
					}
					23 {
						>
							emit (>=2003)
						<
					}
				}
	
			<
		}
		1414939417 {
			>
				emit {CRIU image file v1.1}
			<
		}
		1427134784 {
			>
				emit {CRIU service file}
			<
		}
		1437209140 {
			>
				emit {Valve Pak file}
				if {[N lelong 4 0 0 {} {} x {}]} {
					>
						emit {\b, version %u}
					<
				}
	
				if {[N lelong 8 0 0 {} {} x {}]} {
					>
						emit {\b, %u entries}
					<
				}
	
			<
		}
		1479618838 {
			>
				emit {CRIU inventory}
			<
		}
		1554098963 {
			>
				emit ASTC
				if {[N byte 4 0 0 {} {} x {}]} {
					>
						emit %u
					<
				}
	
				if {[N byte 5 0 0 {} {} x {}]} {
					>
						emit {\bx%u}
					<
				}
	
				if {[N byte 6 0 0 {} {} > 1]} {
					>
						emit {\bx%u}
					<
				}
	
				if {[N lelong 7 0 0 & 16777215 x {}]} {
					>
						emit {texture, %u}
					<
				}
	
				if {[N lelong 10 0 0 & 16777215 x {}]} {
					>
						emit {x %u}
					<
				}
	
				if {[N lelong 13 0 0 & 16777215 > 1]} {
					>
						emit {x %u}
					<
				}
	
			<
		}
		1734567009 {
			>
				emit {GCC gcda coverage (-fprofile-arcs),}
				if {[N byte [R 3] 0 0 {} {} x {}]} {
					>
						emit {version %c.}
					<
				}
	
				if {[N byte [R 1] 0 0 {} {} x {}]} {
					>
						emit {\b%c}
					<
				}
	
			<
		}
		1734569583 {
			>
				emit {GCC gcno coverage (-ftest-coverage),}
				if {[N byte [R 3] 0 0 {} {} x {}]} {
					>
						emit {version %c.}
					<
				}
	
				if {[N byte [R 1] 0 0 {} {} x {}]} {
					>
						emit {\b%c}
					<
				}
	
			<
		}
		1886869041 {
			>
				emit {Cracklib password index, little endian}
				if {[N long 4 0 0 {} {} > 0]} {
					>
						emit {(%i words)}
					<
				}
	
				if {[N long 4 0 0 {} {} == 0]} {
					>
						emit (\"64-bit\")
						if {[N long 8 0 0 {} {} > -1]} {
							>
								emit {(%i words)}
							<
						}
	
					<
				}
	
			<
		}
		1976638807 {
			>
				emit {Common Trace Format (CTF) packetized metadata (LE)}
				if {[N byte 35 0 0 {} {} x {}]} {
					>
						emit {\b, v%d}
					<
				}
	
				if {[N byte 36 0 0 {} {} x {}]} {
					>
						emit {\b.%d}
					<
				}
	
			<
		}
	}
	
	if {[S string 0 0 {} {} eq MOVI]} {
		>
			emit {Silicon Graphics movie file}
			mime video/x-sgi-movie
		<
	}
	
	if {[S string 4 0 {} {} eq moov]} {
		>
			emit {Apple QuickTime}
			if {[S string 12 0 {} {} eq mvhd]} {
				>
					emit {\b movie (fast start)}
				<
			}
	
			if {[S string 12 0 {} {} eq mdra]} {
				>
					emit {\b URL}
				<
			}
	
			if {[S string 12 0 {} {} eq cmov]} {
				>
					emit {\b movie (fast start, compressed header)}
				<
			}
	
			if {[S string 12 0 {} {} eq rmra]} {
				>
					emit {\b multiple URLs}
				<
			}
	
			mime video/quicktime
		<
	}
	
	if {[S string 4 0 {} {} eq mdat]} {
		>
			emit {Apple QuickTime movie (unoptimized)}
			mime video/quicktime
		<
	}
	
	if {[S string 4 0 {} {} eq idsc]} {
		>
			emit {Apple QuickTime image (fast start)}
			mime image/x-quicktime
		<
	}
	
	if {[S string 4 0 {} {} eq pckg]} {
		>
			emit {Apple QuickTime compressed archive}
			mime application/x-quicktime-player
		<
	}
	
	if {[S string 4 0 W {} eq jP]} {
		>
			emit {JPEG 2000 image}
			mime image/jp2
		<
	}
	
	if {[S string 4 0 {} {} eq ftyp]} {
		>
			emit {ISO Media}
			if {[S string 8 0 {} {} eq XAVC]} {
				>
					emit {\b, MPEG v4 system, Sony XAVC Codec}
					if {[S string 96 0 {} {} x {}]} {
						>
							emit {\b, Audio "%.4s"}
						<
					}
	
					if {[N beshort 118 0 0 {} {} x {}]} {
						>
							emit {at %dHz}
						<
					}
	
					if {[S string 140 0 {} {} x {}]} {
						>
							emit {\b, Video "%.4s"}
						<
					}
	
					if {[N beshort 168 0 0 {} {} x {}]} {
						>
							emit %d
						<
					}
	
					if {[N beshort 170 0 0 {} {} x {}]} {
						>
							emit {\bx%d}
						<
					}
	
				<
			}
	
			if {[S string 8 0 {} {} eq 3g2]} {
				>
					emit {\b, MPEG v4 system, 3GPP2}
					switch [Nv byte 11 0 {} {}] {
						4 {
							>
								emit {\b v4 (H.263/AMR GSM 6.10)}
							<
						}
						5 {
							>
								emit {\b v5 (H.263/AMR GSM 6.10)}
							<
						}
						6 {
							>
								emit {\b v6 (ITU H.264/AMR GSM 6.10)}
							<
						}
						97 {
							>
								emit {\b C.S0050-0 V1.0}
							<
						}
						98 {
							>
								emit {\b C.S0050-0-A V1.0.0}
							<
						}
						99 {
							>
								emit {\b C.S0050-0-B V1.0}
							<
						}
					}
	
					mime video/3gpp2
				<
			}
	
			if {[S string 8 0 {} {} eq 3ge]} {
				>
					emit {\b, MPEG v4 system, 3GPP}
					switch [Nv byte 11 0 {} {}] {
						6 {
							>
								emit {\b, Release 6 MBMS Extended Presentations}
							<
						}
						7 {
							>
								emit {\b, Release 7 MBMS Extended Presentations}
							<
						}
					}
	
					mime video/3gpp
				<
			}
	
			if {[S string 8 0 {} {} eq 3gg]} {
				>
					emit {\b, MPEG v4 system, 3GPP}
					if {[N byte 11 0 0 {} {} == 6]} {
						>
							emit {\b, Release 6 General Profile}
						<
					}
	
					mime video/3gpp
				<
			}
	
			if {[S string 8 0 {} {} eq 3gp]} {
				>
					emit {\b, MPEG v4 system, 3GPP}
					switch [Nv byte 11 0 {} {}] {
						1 {
							>
								emit {\b, Release %d (non existent)}
							<
						}
						2 {
							>
								emit {\b, Release %d (non existent)}
							<
						}
						3 {
							>
								emit {\b, Release %d (non existent)}
							<
						}
						4 {
							>
								emit {\b, Release %d}
							<
						}
						5 {
							>
								emit {\b, Release %d}
							<
						}
						6 {
							>
								emit {\b, Release %d}
							<
						}
						7 {
							>
								emit {\b, Release %d Streaming Servers}
							<
						}
					}
	
					mime video/3gpp
				<
			}
	
			if {[S string 8 0 {} {} eq 3gs]} {
				>
					emit {\b, MPEG v4 system, 3GPP}
					if {[N byte 11 0 0 {} {} == 7]} {
						>
							emit {\b, Release %d Streaming Servers}
						<
					}
	
					mime video/3gpp
				<
			}
	
			if {[S string 8 0 {} {} eq avc1]} {
				>
					emit {\b, MPEG v4 system, 3GPP JVT AVC [ISO 14496-12:2005]}
					mime video/mp4
				<
			}
	
			if {[S string 8 0 W {} eq qt]} {
				>
					emit {\b, Apple QuickTime movie}
					mime video/quicktime
				<
			}
	
			if {[S string 8 0 {} {} eq CAEP]} {
				>
					emit {\b, Canon Digital Camera}
				<
			}
	
			if {[S string 8 0 {} {} eq caqv]} {
				>
					emit {\b, Casio Digital Camera}
				<
			}
	
			if {[S string 8 0 {} {} eq CDes]} {
				>
					emit {\b, Convergent Design}
				<
			}
	
			if {[S string 8 0 {} {} eq da0a]} {
				>
					emit {\b, DMB MAF w/ MPEG Layer II aud, MOT slides, DLS, JPG/PNG/MNG}
				<
			}
	
			if {[S string 8 0 {} {} eq da0b]} {
				>
					emit {\b, DMB MAF, ext DA0A, with 3GPP timed text, DID, TVA, REL, IPMP}
				<
			}
	
			if {[S string 8 0 {} {} eq da1a]} {
				>
					emit {\b, DMB MAF audio with ER-BSAC audio, JPG/PNG/MNG images}
				<
			}
	
			if {[S string 8 0 {} {} eq da1b]} {
				>
					emit {\b, DMB MAF, ext da1a, with 3GPP timed text, DID, TVA, REL, IPMP}
				<
			}
	
			if {[S string 8 0 {} {} eq da2a]} {
				>
					emit {\b, DMB MAF aud w/ HE-AAC v2 aud, MOT slides, DLS, JPG/PNG/MNG}
				<
			}
	
			if {[S string 8 0 {} {} eq da2b]} {
				>
					emit {\b, DMB MAF, ext da2a, with 3GPP timed text, DID, TVA, REL, IPMP}
				<
			}
	
			if {[S string 8 0 {} {} eq da3a]} {
				>
					emit {\b, DMB MAF aud with HE-AAC aud, JPG/PNG/MNG images}
				<
			}
	
			if {[S string 8 0 {} {} eq da3b]} {
				>
					emit {\b, DMB MAF, ext da3a w/ BIFS, 3GPP, DID, TVA, REL, IPMP}
				<
			}
	
			if {[S string 8 0 {} {} eq dash]} {
				>
					emit {\b, MPEG v4 system, Dynamic Adaptive Streaming over HTTP}
					mime video/mp4
				<
			}
	
			if {[S string 8 0 {} {} eq dmb1]} {
				>
					emit {\b, DMB MAF supporting all the components defined in the spec}
				<
			}
	
			if {[S string 8 0 {} {} eq dmpf]} {
				>
					emit {\b, Digital Media Project}
				<
			}
	
			if {[S string 8 0 {} {} eq drc1]} {
				>
					emit {\b, Dirac (wavelet compression), encap in ISO base media (MP4)}
				<
			}
	
			if {[S string 8 0 {} {} eq dv1a]} {
				>
					emit {\b, DMB MAF vid w/ AVC vid, ER-BSAC aud, BIFS, JPG/PNG/MNG, TS}
				<
			}
	
			if {[S string 8 0 {} {} eq dv1b]} {
				>
					emit {\b, DMB MAF, ext dv1a, with 3GPP timed text, DID, TVA, REL, IPMP}
				<
			}
	
			if {[S string 8 0 {} {} eq dv2a]} {
				>
					emit {\b, DMB MAF vid w/ AVC vid, HE-AAC v2 aud, BIFS, JPG/PNG/MNG, TS}
				<
			}
	
			if {[S string 8 0 {} {} eq dv2b]} {
				>
					emit {\b, DMB MAF, ext dv2a, with 3GPP timed text, DID, TVA, REL, IPMP}
				<
			}
	
			if {[S string 8 0 {} {} eq dv3a]} {
				>
					emit {\b, DMB MAF vid w/ AVC vid, HE-AAC aud, BIFS, JPG/PNG/MNG, TS}
				<
			}
	
			if {[S string 8 0 {} {} eq dv3b]} {
				>
					emit {\b, DMB MAF, ext dv3a, with 3GPP timed text, DID, TVA, REL, IPMP}
				<
			}
	
			if {[S string 8 0 {} {} eq dvr1]} {
				>
					emit {\b, DVB (.DVB) over RTP}
					mime video/vnd.dvb.file
				<
			}
	
			if {[S string 8 0 {} {} eq dvt1]} {
				>
					emit {\b, DVB (.DVB) over MPEG-2 Transport Stream}
					mime video/vnd.dvb.file
				<
			}
	
			if {[S string 8 0 {} {} eq F4V]} {
				>
					emit {\b, Video for Adobe Flash Player 9+ (.F4V)}
					mime video/mp4
				<
			}
	
			if {[S string 8 0 {} {} eq F4P]} {
				>
					emit {\b, Protected Video for Adobe Flash Player 9+ (.F4P)}
					mime video/mp4
				<
			}
	
			if {[S string 8 0 {} {} eq F4A]} {
				>
					emit {\b, Audio for Adobe Flash Player 9+ (.F4A)}
					mime audio/mp4
				<
			}
	
			if {[S string 8 0 {} {} eq F4B]} {
				>
					emit {\b, Audio Book for Adobe Flash Player 9+ (.F4B)}
					mime audio/mp4
				<
			}
	
			if {[S string 8 0 {} {} eq isc2]} {
				>
					emit {\b, ISMACryp 2.0 Encrypted File}
				<
			}
	
			if {[S string 8 0 {} {} eq iso2]} {
				>
					emit {\b, MP4 Base Media v2 [ISO 14496-12:2005]}
					mime video/mp4
				<
			}
	
			if {[S string 8 0 {} {} eq isom]} {
				>
					emit {\b, MP4 Base Media v1 [IS0 14496-12:2003]}
					mime video/mp4
				<
			}
	
			if {[S string 8 0 W {} eq jp2]} {
				>
					emit {\b, JPEG 2000}
					mime image/jp2
				<
			}
	
			if {[S string 8 0 {} {} eq JP2]} {
				>
					emit {\b, JPEG 2000 Image (.JP2) [ISO 15444-1 ?]}
					mime image/jp2
				<
			}
	
			if {[S string 8 0 {} {} eq JP20]} {
				>
					emit {\b, Unknown, from GPAC samples (prob non-existent)}
				<
			}
	
			if {[S string 8 0 {} {} eq jpm]} {
				>
					emit {\b, JPEG 2000 Compound Image (.JPM) [ISO 15444-6]}
					mime image/jpm
				<
			}
	
			if {[S string 8 0 {} {} eq jpx]} {
				>
					emit {\b, JPEG 2000 w/ extensions (.JPX) [ISO 15444-2]}
					mime image/jpx
				<
			}
	
			if {[S string 8 0 {} {} eq KDDI]} {
				>
					emit {\b, 3GPP2 EZmovie for KDDI 3G cellphones}
					mime video/3gpp2
				<
			}
	
			if {[S string 8 0 {} {} eq M4A]} {
				>
					emit {\b, Apple iTunes ALAC/AAC-LC (.M4A) Audio}
					mime audio/x-m4a
				<
			}
	
			if {[S string 8 0 {} {} eq M4B]} {
				>
					emit {\b, Apple iTunes ALAC/AAC-LC (.M4B) Audio Book}
					mime audio/mp4
				<
			}
	
			if {[S string 8 0 {} {} eq M4P]} {
				>
					emit {\b, Apple iTunes ALAC/AAC-LC (.M4P) AES Protected Audio}
					mime video/mp4
				<
			}
	
			if {[S string 8 0 {} {} eq M4V]} {
				>
					emit {\b, Apple iTunes Video (.M4V) Video}
					mime video/x-m4v
				<
			}
	
			if {[S string 8 0 {} {} eq M4VH]} {
				>
					emit {\b, Apple TV (.M4V)}
					mime video/x-m4v
				<
			}
	
			if {[S string 8 0 {} {} eq M4VP]} {
				>
					emit {\b, Apple iPhone (.M4V)}
					mime video/x-m4v
				<
			}
	
			if {[S string 8 0 {} {} eq mj2s]} {
				>
					emit {\b, Motion JPEG 2000 [ISO 15444-3] Simple Profile}
					mime video/mj2
				<
			}
	
			if {[S string 8 0 {} {} eq mjp2]} {
				>
					emit {\b, Motion JPEG 2000 [ISO 15444-3] General Profile}
					mime video/mj2
				<
			}
	
			if {[S string 8 0 {} {} eq mmp4]} {
				>
					emit {\b, MPEG-4/3GPP Mobile Profile (.MP4 / .3GP) (for NTT)}
					mime video/mp4
				<
			}
	
			if {[S string 8 0 {} {} eq mobi]} {
				>
					emit {\b, MPEG-4, MOBI format}
					mime video/mp4
				<
			}
	
			if {[S string 8 0 {} {} eq mp21]} {
				>
					emit {\b, MPEG-21 [ISO/IEC 21000-9]}
				<
			}
	
			if {[S string 8 0 {} {} eq mp41]} {
				>
					emit {\b, MP4 v1 [ISO 14496-1:ch13]}
					mime video/mp4
				<
			}
	
			if {[S string 8 0 {} {} eq mp42]} {
				>
					emit {\b, MP4 v2 [ISO 14496-14]}
					mime video/mp4
				<
			}
	
			if {[S string 8 0 {} {} eq mp71]} {
				>
					emit {\b, MP4 w/ MPEG-7 Metadata [per ISO 14496-12]}
				<
			}
	
			if {[S string 8 0 {} {} eq mp7t]} {
				>
					emit {\b, MPEG v4 system, MPEG v7 XML}
				<
			}
	
			if {[S string 8 0 {} {} eq mp7b]} {
				>
					emit {\b, MPEG v4 system, MPEG v7 binary XML}
				<
			}
	
			if {[S string 8 0 {} {} eq mmp4]} {
				>
					emit {\b, MPEG v4 system, 3GPP Mobile}
					mime video/mp4
				<
			}
	
			if {[S string 8 0 {} {} eq MPPI]} {
				>
					emit {\b, Photo Player, MAF [ISO/IEC 23000-3]}
				<
			}
	
			if {[S string 8 0 {} {} eq mqt]} {
				>
					emit {\b, Sony / Mobile QuickTime (.MQV) US Pat 7,477,830}
					mime video/quicktime
				<
			}
	
			if {[S string 8 0 {} {} eq MSNV]} {
				>
					emit {\b, MPEG-4 (.MP4) for SonyPSP}
					mime audio/mp4
				<
			}
	
			if {[S string 8 0 {} {} eq NDAS]} {
				>
					emit {\b, MP4 v2 [ISO 14496-14] Nero Digital AAC Audio}
					mime audio/mp4
				<
			}
	
			if {[S string 8 0 {} {} eq NDSC]} {
				>
					emit {\b, MPEG-4 (.MP4) Nero Cinema Profile}
					mime video/mp4
				<
			}
	
			if {[S string 8 0 {} {} eq NDSH]} {
				>
					emit {\b, MPEG-4 (.MP4) Nero HDTV Profile}
					mime video/mp4
				<
			}
	
			if {[S string 8 0 {} {} eq NDSM]} {
				>
					emit {\b, MPEG-4 (.MP4) Nero Mobile Profile}
					mime video/mp4
				<
			}
	
			if {[S string 8 0 {} {} eq NDSP]} {
				>
					emit {\b, MPEG-4 (.MP4) Nero Portable Profile}
					mime video/mp4
				<
			}
	
			if {[S string 8 0 {} {} eq NDSS]} {
				>
					emit {\b, MPEG-4 (.MP4) Nero Standard Profile}
					mime video/mp4
				<
			}
	
			if {[S string 8 0 {} {} eq NDXC]} {
				>
					emit {\b, H.264/MPEG-4 AVC (.MP4) Nero Cinema Profile}
					mime video/mp4
				<
			}
	
			if {[S string 8 0 {} {} eq NDXH]} {
				>
					emit {\b, H.264/MPEG-4 AVC (.MP4) Nero HDTV Profile}
					mime video/mp4
				<
			}
	
			if {[S string 8 0 {} {} eq NDXM]} {
				>
					emit {\b, H.264/MPEG-4 AVC (.MP4) Nero Mobile Profile}
					mime video/mp4
				<
			}
	
			if {[S string 8 0 {} {} eq NDXP]} {
				>
					emit {\b, H.264/MPEG-4 AVC (.MP4) Nero Portable Profile}
					mime video/mp4
				<
			}
	
			if {[S string 8 0 {} {} eq NDXS]} {
				>
					emit {\b, H.264/MPEG-4 AVC (.MP4) Nero Standard Profile}
					mime video/mp4
				<
			}
	
			if {[S string 8 0 {} {} eq odcf]} {
				>
					emit {\b, OMA DCF DRM Format 2.0 (OMA-TS-DRM-DCF-V2_0-20060303-A)}
				<
			}
	
			if {[S string 8 0 {} {} eq opf2]} {
				>
					emit {\b, OMA PDCF DRM Format 2.1 (OMA-TS-DRM-DCF-V2_1-20070724-C)}
				<
			}
	
			if {[S string 8 0 {} {} eq opx2]} {
				>
					emit {\b, OMA PDCF DRM + XBS ext (OMA-TS-DRM_XBS-V1_0-20070529-C)}
				<
			}
	
			if {[S string 8 0 {} {} eq pana]} {
				>
					emit {\b, Panasonic Digital Camera}
				<
			}
	
			if {[S string 8 0 {} {} eq qt]} {
				>
					emit {\b, Apple QuickTime (.MOV/QT)}
					mime video/quicktime
				<
			}
	
			if {[S string 8 0 {} {} eq mif1]} {
				>
					emit {\b, HEIF Image}
					mime image/heif
				<
			}
	
			if {[S string 8 0 {} {} eq msf1]} {
				>
					emit {\b, HEIF Image Sequence}
					mime image/heif-sequence
				<
			}
	
			if {[S string 8 0 {} {} eq heic]} {
				>
					emit {\b, HEIF Image HEVC Main or Main Still Picture Profile}
					mime image/heic
				<
			}
	
			if {[S string 8 0 {} {} eq heix]} {
				>
					emit {\b, HEIF Image HEVC Main 10 Profile}
					mime image/heic
				<
			}
	
			if {[S string 8 0 {} {} eq hevc]} {
				>
					emit {\b, HEIF Image Sequenz HEVC Main or Main Still Picture Profile}
					mime image/heic-sequence
				<
			}
	
			if {[S string 8 0 {} {} eq hevx]} {
				>
					emit {\b, HEIF Image Sequence HEVC Main 10 Profile}
					mime image/heic-sequence
				<
			}
	
			if {[S string 8 0 {} {} eq heim]} {
				>
					emit {\b, HEIF Image L-HEVC}
					mime image/heif
				<
			}
	
			if {[S string 8 0 {} {} eq heis]} {
				>
					emit {\b, HEIF Image L-HEVC}
					mime image/heif
				<
			}
	
			if {[S string 8 0 {} {} eq avic]} {
				>
					emit {\b, HEIF Image AVC}
					mime image/heif
				<
			}
	
			if {[S string 8 0 {} {} eq hevm]} {
				>
					emit {\b, HEIF Image Sequence L-HEVC}
					mime image/heif-sequence
				<
			}
	
			if {[S string 8 0 {} {} eq hevs]} {
				>
					emit {\b, HEIF Image Sequence L-HEVC}
					mime image/heif-sequence
				<
			}
	
			if {[S string 8 0 {} {} eq avcs]} {
				>
					emit {\b, HEIF Image Sequence AVC}
					mime image/heif-sequence
				<
			}
	
			if {[S string 8 0 {} {} eq ROSS]} {
				>
					emit {\b, Ross Video}
				<
			}
	
			if {[S string 8 0 {} {} eq sdv]} {
				>
					emit {\b, SD Memory Card Video}
				<
			}
	
			if {[S string 8 0 {} {} eq ssc1]} {
				>
					emit {\b, Samsung stereo, single stream (patent pending)}
				<
			}
	
			if {[S string 8 0 {} {} eq ssc2]} {
				>
					emit {\b, Samsung stereo, dual stream (patent pending)}
				<
			}
	
		<
	}
	
	switch [Nv belong 0 0 & -256] {
		-2063526912 {
			>
				emit {cisco IOS microcode}
				if {[S string 7 0 {} {} > \0]} {
					>
						emit {for '%s'}
					<
				}
	
			<
		}
		-2063480064 {
			>
				emit {cisco IOS experimental microcode}
				if {[S string 7 0 {} {} > \0]} {
					>
						emit {for '%s'}
					<
				}
	
			<
		}
		-16907008 {
			>
				emit {MySQL ISAM index file}
				if {[N byte 3 0 0 {} {} x {}]} {
					>
						emit {Version %d}
					<
				}
	
			<
		}
		-16906752 {
			>
				emit {MySQL ISAM compressed data file}
				if {[N byte 3 0 0 {} {} x {}]} {
					>
						emit {Version %d}
					<
				}
	
			<
		}
		-16906496 {
			>
				emit {MySQL MyISAM index file}
				if {[N byte 3 0 0 {} {} x {}]} {
					>
						emit {Version %d}
					<
				}
	
				if {[N beshort 14 0 0 {} {} x {}]} {
					>
						emit {\b, %d key parts}
					<
				}
	
				if {[N beshort 16 0 0 {} {} x {}]} {
					>
						emit {\b, %d unique key parts}
					<
				}
	
				if {[N byte 18 0 0 {} {} x {}]} {
					>
						emit {\b, %d keys}
					<
				}
	
				if {[N bequad 28 0 0 {} {} x {}]} {
					>
						emit {\b, %lld records}
					<
				}
	
				if {[N bequad 36 0 0 {} {} x {}]} {
					>
						emit {\b, %lld deleted records}
					<
				}
	
			<
		}
		-16906240 {
			>
				emit {MySQL MyISAM compressed data file}
				if {[N byte 3 0 0 {} {} x {}]} {
					>
						emit {Version %d}
					<
				}
	
			<
		}
		-16905984 {
			>
				emit {MySQL Maria index file}
				if {[N byte 3 0 0 {} {} x {}]} {
					>
						emit {Version %d}
					<
				}
	
			<
		}
		-16905728 {
			>
				emit {MySQL Maria compressed data file}
				if {[N byte 3 0 0 {} {} x {}]} {
					>
						emit {Version %d}
					<
				}
	
			<
		}
		-16905216 {
			>
				if {[S string 4 0 {} {} eq MACF]} {
					>
						emit {MySQL Maria control file}
						if {[N byte 3 0 0 {} {} x {}]} {
							>
								emit {Version %d}
							<
						}
	
					<
				}
	
			<
		}
		256 {
			>
				switch [Nv byte 3 0 {} {}] {
					-80 {
						>
							emit {MPEG sequence, v4}
							mime video/mpeg4-generic
							if {[N belong 5 0 0 {} {} == 437]} {
								>
									if {[N byte 9 0 0 {} {} & -128]} {
										>
											switch [Nv byte 10 0 & -16] {
												16 {
													>
														emit {\b, video}
													<
												}
												32 {
													>
														emit {\b, still texture}
													<
												}
												48 {
													>
														emit {\b, mesh}
													<
												}
												64 {
													>
														emit {\b, face}
													<
												}
											}
	
										<
									}
	
									switch [Nv byte 9 0 & -8] {
										8 {
											>
												emit {\b, video}
											<
										}
										16 {
											>
												emit {\b, still texture}
											<
										}
										24 {
											>
												emit {\b, mesh}
											<
										}
										32 {
											>
												emit {\b, face}
											<
										}
									}
	
								<
							}
	
							switch [Nv byte 4 0 {} {}] {
								-127 {
									>
										emit {\b, hybrid @ L1}
									<
								}
								-126 {
									>
										emit {\b, hybrid @ L2}
									<
								}
								-111 {
									>
										emit {\b, advanced RT simple @ L!}
									<
								}
								-110 {
									>
										emit {\b, advanced RT simple @ L2}
									<
								}
								-109 {
									>
										emit {\b, advanced RT simple @ L3}
									<
								}
								-108 {
									>
										emit {\b, advanced RT simple @ L4}
									<
								}
								-95 {
									>
										emit {\b, core scalable @ L1}
									<
								}
								-94 {
									>
										emit {\b, core scalable @ L2}
									<
								}
								-93 {
									>
										emit {\b, core scalable @ L3}
									<
								}
								-79 {
									>
										emit {\b, advanced coding efficiency @ L1}
									<
								}
								-78 {
									>
										emit {\b, advanced coding efficiency @ L2}
									<
								}
								-77 {
									>
										emit {\b, advanced coding efficiency @ L3}
									<
								}
								-76 {
									>
										emit {\b, advanced coding efficiency @ L4}
									<
								}
								-63 {
									>
										emit {\b, advanced core @ L1}
									<
								}
								-62 {
									>
										emit {\b, advanced core @ L2}
									<
								}
								-47 {
									>
										emit {\b, advanced scalable texture @ L1}
									<
								}
								-46 {
									>
										emit {\b, advanced scalable texture @ L2}
									<
								}
								-45 {
									>
										emit {\b, advanced scalable texture @ L3}
									<
								}
								-31 {
									>
										emit {\b, simple studio @ L1}
									<
								}
								-30 {
									>
										emit {\b, simple studio @ L2}
									<
								}
								-29 {
									>
										emit {\b, simple studio @ L3}
									<
								}
								-28 {
									>
										emit {\b, simple studio @ L4}
									<
								}
								-27 {
									>
										emit {\b, core studio @ L1}
									<
								}
								-26 {
									>
										emit {\b, core studio @ L2}
									<
								}
								-25 {
									>
										emit {\b, core studio @ L3}
									<
								}
								-24 {
									>
										emit {\b, core studio @ L4}
									<
								}
								-16 {
									>
										emit {\b, advanced simple @ L0}
									<
								}
								-15 {
									>
										emit {\b, advanced simple @ L1}
									<
								}
								-14 {
									>
										emit {\b, advanced simple @ L2}
									<
								}
								-13 {
									>
										emit {\b, advanced simple @ L3}
									<
								}
								-12 {
									>
										emit {\b, advanced simple @ L4}
									<
								}
								-11 {
									>
										emit {\b, advanced simple @ L5}
									<
								}
								-9 {
									>
										emit {\b, advanced simple @ L3b}
									<
								}
								-8 {
									>
										emit {\b, FGS @ L0}
									<
								}
								-7 {
									>
										emit {\b, FGS @ L1}
									<
								}
								-6 {
									>
										emit {\b, FGS @ L2}
									<
								}
								-5 {
									>
										emit {\b, FGS @ L3}
									<
								}
								-4 {
									>
										emit {\b, FGS @ L4}
									<
								}
								-3 {
									>
										emit {\b, FGS @ L5}
									<
								}
								1 {
									>
										emit {\b, simple @ L1}
									<
								}
								2 {
									>
										emit {\b, simple @ L2}
									<
								}
								3 {
									>
										emit {\b, simple @ L3}
									<
								}
								4 {
									>
										emit {\b, simple @ L0}
									<
								}
								17 {
									>
										emit {\b, simple scalable @ L1}
									<
								}
								18 {
									>
										emit {\b, simple scalable @ L2}
									<
								}
								33 {
									>
										emit {\b, core @ L1}
									<
								}
								34 {
									>
										emit {\b, core @ L2}
									<
								}
								50 {
									>
										emit {\b, main @ L2}
									<
								}
								51 {
									>
										emit {\b, main @ L3}
									<
								}
								53 {
									>
										emit {\b, main @ L4}
									<
								}
								66 {
									>
										emit {\b, n-bit @ L2}
									<
								}
								81 {
									>
										emit {\b, scalable texture @ L1}
									<
								}
								97 {
									>
										emit {\b, simple face animation @ L1}
									<
								}
								98 {
									>
										emit {\b, simple face animation @ L2}
									<
								}
								99 {
									>
										emit {\b, simple face basic animation @ L1}
									<
								}
								100 {
									>
										emit {\b, simple face basic animation @ L2}
									<
								}
								113 {
									>
										emit {\b, basic animation text @ L1}
									<
								}
								114 {
									>
										emit {\b, basic animation text @ L2}
									<
								}
							}
	
						<
					}
					-77 {
						>
							emit {MPEG sequence}
							mime video/mpeg
							switch [Nv belong 12 0 {} {}] {
								434 {
									>
										emit {\b, v1, progressive Y'CbCr 4:2:0 video}
									<
								}
								437 {
									>
										emit {\b, v2,}
										switch [Nv byte 16 0 & 15] {
											1 {
												>
													emit {\b HP}
												<
											}
											2 {
												>
													emit {\b Spt}
												<
											}
											3 {
												>
													emit {\b SNR}
												<
											}
											4 {
												>
													emit {\b MP}
												<
											}
											5 {
												>
													emit {\b SP}
												<
											}
										}
	
										switch [Nv byte 17 0 & -16] {
											-128 {
												>
													emit {\b@ML}
												<
											}
											-96 {
												>
													emit {\b@LL}
												<
											}
											64 {
												>
													emit {\b@HL}
												<
											}
											96 {
												>
													emit {\b@H-14}
												<
											}
										}
	
										if {[N byte 17 0 0 {} {} & 8]} {
											>
												emit {\b progressive}
											<
										}
	
										if {[N byte 17 0 0 {} {} ^ 8]} {
											>
												emit {\b interlaced}
											<
										}
	
										switch [Nv byte 17 0 & 6] {
											2 {
												>
													emit {\b Y'CbCr 4:2:0 video}
												<
											}
											4 {
												>
													emit {\b Y'CbCr 4:2:2 video}
												<
											}
											6 {
												>
													emit {\b Y'CbCr 4:4:4 video}
												<
											}
										}
	
									<
								}
								440 {
									>
										emit {\b, v1, progressive Y'CbCr 4:2:0 video}
									<
								}
							}
	
							if {[N byte 11 0 0 {} {} & 2]} {
								>
									if {[N byte 75 0 0 {} {} & 1]} {
										>
											switch [Nv belong 140 0 {} {}] {
												434 {
													>
														emit {\b, v1, progressive Y'CbCr 4:2:0 video}
													<
												}
												437 {
													>
														emit {\b, v2,}
														switch [Nv byte 144 0 & 15] {
															1 {
																>
																	emit {\b HP}
																<
															}
															2 {
																>
																	emit {\b Spt}
																<
															}
															3 {
																>
																	emit {\b SNR}
																<
															}
															4 {
																>
																	emit {\b MP}
																<
															}
															5 {
																>
																	emit {\b SP}
																<
															}
														}
	
														switch [Nv byte 145 0 & -16] {
															-128 {
																>
																	emit {\b@ML}
																<
															}
															-96 {
																>
																	emit {\b@LL}
																<
															}
															64 {
																>
																	emit {\b@HL}
																<
															}
															96 {
																>
																	emit {\b@H-14}
																<
															}
														}
	
														if {[N byte 145 0 0 {} {} & 8]} {
															>
																emit {\b progressive}
															<
														}
	
														if {[N byte 145 0 0 {} {} ^ 8]} {
															>
																emit {\b interlaced}
															<
														}
	
														switch [Nv byte 145 0 & 6] {
															2 {
																>
																	emit {\b Y'CbCr 4:2:0 video}
																<
															}
															4 {
																>
																	emit {\b Y'CbCr 4:2:2 video}
																<
															}
															6 {
																>
																	emit {\b Y'CbCr 4:4:4 video}
																<
															}
														}
	
													<
												}
												440 {
													>
														emit {\b, v1, progressive Y'CbCr 4:2:0 video}
													<
												}
											}
	
										<
									}
	
								<
							}
	
							switch [Nv belong 76 0 {} {}] {
								434 {
									>
										emit {\b, v1, progressive Y'CbCr 4:2:0 video}
									<
								}
								437 {
									>
										emit {\b, v2,}
										switch [Nv byte 80 0 & 15] {
											1 {
												>
													emit {\b HP}
												<
											}
											2 {
												>
													emit {\b Spt}
												<
											}
											3 {
												>
													emit {\b SNR}
												<
											}
											4 {
												>
													emit {\b MP}
												<
											}
											5 {
												>
													emit {\b SP}
												<
											}
										}
	
										switch [Nv byte 81 0 & -16] {
											-128 {
												>
													emit {\b@ML}
												<
											}
											-96 {
												>
													emit {\b@LL}
												<
											}
											64 {
												>
													emit {\b@HL}
												<
											}
											96 {
												>
													emit {\b@H-14}
												<
											}
										}
	
										if {[N byte 81 0 0 {} {} & 8]} {
											>
												emit {\b progressive}
											<
										}
	
										if {[N byte 81 0 0 {} {} ^ 8]} {
											>
												emit {\b interlaced}
											<
										}
	
										switch [Nv byte 81 0 & 6] {
											2 {
												>
													emit {\b Y'CbCr 4:2:0 video}
												<
											}
											4 {
												>
													emit {\b Y'CbCr 4:2:2 video}
												<
											}
											6 {
												>
													emit {\b Y'CbCr 4:4:4 video}
												<
											}
										}
	
									<
								}
								440 {
									>
										emit {\b, v1, progressive Y'CbCr 4:2:0 video}
									<
								}
							}
	
							switch [Nv belong 4 0 & -256] {
								167802880 {
									>
										emit {\b, 160x120}
										if {[N byte 7 0 0 & -16 == 16]} {
											>
												emit {\b, 4:3}
											<
										}
	
									<
								}
								251699200 {
									>
										emit {\b, 240x160}
										if {[N byte 7 0 0 & -16 == 16]} {
											>
												emit {\b, 4:3}
											<
										}
	
									<
								}
								335605760 {
									>
										emit {\b, 320x240}
										if {[N byte 7 0 0 & -16 == 16]} {
											>
												emit {\b, 4:3}
											<
										}
	
									<
								}
								671211520 {
									>
										emit {\b, LD-TV 640P}
										if {[N byte 7 0 0 & -16 == 16]} {
											>
												emit {\b, 4:3}
											<
										}
	
									<
								}
								805453824 {
									>
										emit {\b, PAL Capture}
										if {[N byte 7 0 0 & -16 == 16]} {
											>
												emit {\b, 4:3}
											<
										}
	
									<
								}
								1342188800 {
									>
										emit {\b, SD-TV 1280I}
										if {[N byte 7 0 0 & -16 == 16]} {
											>
												emit {\b, 16:9}
											<
										}
	
									<
								}
								2013542400 {
									>
										emit {\b, HD-TV 1920P}
										if {[N byte 7 0 0 & -16 == 16]} {
											>
												emit {\b, 16:9}
											<
										}
	
									<
								}
							}
	
							switch [Nv beshort 4 0 & -16] {
								5632 {
									>
										emit {\b, CIF}
										switch [Nv beshort 5 0 & 4095] {
											240 {
												>
													emit {\b NTSC}
												<
											}
											288 {
												>
													emit {\b PAL}
												<
											}
											576 {
												>
													emit {\b PAL 625}
													switch [Nv byte 7 0 & -16] {
														32 {
															>
																emit {\b, 4:3}
															<
														}
														48 {
															>
																emit {\b, 16:9}
															<
														}
														64 {
															>
																emit {\b, 11:5}
															<
														}
													}
	
												<
											}
										}
	
										switch [Nv byte 7 0 & -16] {
											-128 {
												>
													emit {\b, PAL 4:3}
												<
											}
											-64 {
												>
													emit {\b, NTSC 4:3}
												<
											}
											32 {
												>
													emit {\b, 4:3}
												<
											}
											48 {
												>
													emit {\b, 16:9}
												<
											}
											64 {
												>
													emit {\b, 11:5}
												<
											}
										}
	
									<
								}
								7680 {
									>
										emit {\b, SVCD}
										switch [Nv beshort 5 0 & 4095] {
											480 {
												>
													emit {\b NTSC 525}
												<
											}
											576 {
												>
													emit {\b PAL 625}
												<
											}
										}
	
										switch [Nv byte 7 0 & -16] {
											32 {
												>
													emit {\b, 4:3}
												<
											}
											48 {
												>
													emit {\b, 16:9}
												<
											}
											64 {
												>
													emit {\b, 11:5}
												<
											}
										}
	
									<
								}
								11264 {
									>
										emit {\b, 4CIF}
										switch [Nv beshort 5 0 & 4095] {
											480 {
												>
													emit {\b NTSC}
												<
											}
											576 {
												>
													emit {\b PAL}
												<
											}
										}
	
										switch [Nv byte 7 0 & -16] {
											-128 {
												>
													emit {\b, PAL 4:3}
												<
											}
											-64 {
												>
													emit {\b, NTSC 4:3}
												<
											}
											32 {
												>
													emit {\b, 4:3}
												<
											}
											48 {
												>
													emit {\b, 16:9}
												<
											}
											64 {
												>
													emit {\b, 11:5}
												<
											}
										}
	
									<
								}
								11520 {
									>
										emit {\b, CCIR/ITU}
										switch [Nv beshort 5 0 & 4095] {
											480 {
												>
													emit {\b NTSC 525}
												<
											}
											576 {
												>
													emit {\b PAL 625}
												<
											}
										}
	
										switch [Nv byte 7 0 & -16] {
											32 {
												>
													emit {\b, 4:3}
												<
											}
											48 {
												>
													emit {\b, 16:9}
												<
											}
											64 {
												>
													emit {\b, 11:5}
												<
											}
										}
	
									<
								}
							}
	
							switch [Nv byte 7 0 & 15] {
								1 {
									>
										emit {\b, 23.976 fps}
									<
								}
								2 {
									>
										emit {\b, 24 fps}
									<
								}
								3 {
									>
										emit {\b, 25 fps}
									<
								}
								4 {
									>
										emit {\b, 29.97 fps}
									<
								}
								5 {
									>
										emit {\b, 30 fps}
									<
								}
								6 {
									>
										emit {\b, 50 fps}
									<
								}
								7 {
									>
										emit {\b, 59.94 fps}
									<
								}
								8 {
									>
										emit {\b, 60 fps}
									<
								}
							}
	
							if {[N byte 11 0 0 {} {} & 4]} {
								>
									emit {\b, Constrained}
								<
							}
	
						<
					}
					-75 {
						>
							emit {MPEG sequence, v4}
							mime video/mpeg4-generic
							if {[N byte 4 0 0 {} {} & -128]} {
								>
									switch [Nv byte 5 0 & -16] {
										16 {
											>
												emit {\b, video (missing profile header)}
											<
										}
										32 {
											>
												emit {\b, still texture (missing profile header)}
											<
										}
										48 {
											>
												emit {\b, mesh (missing profile header)}
											<
										}
										64 {
											>
												emit {\b, face (missing profile header)}
											<
										}
									}
	
								<
							}
	
							switch [Nv byte 4 0 & -8] {
								8 {
									>
										emit {\b, video (missing profile header)}
									<
								}
								16 {
									>
										emit {\b, still texture (missing profile header)}
									<
								}
								24 {
									>
										emit {\b, mesh (missing profile header)}
									<
								}
								32 {
									>
										emit {\b, face (missing profile header)}
									<
								}
							}
	
						<
					}
					-70 {
						>
							emit {MPEG sequence}
							mime video/mpeg
							if {[N byte 4 0 0 {} {} & 64]} {
								>
									emit {\b, v2, program multiplex}
								<
							}
	
							if {[N byte 4 0 0 {} {} ^ 64]} {
								>
									emit {\b, v1, system multiplex}
								<
							}
	
						<
					}
					-69 {
						>
							emit {MPEG sequence, v1/2, multiplex (missing pack header)}
						<
					}
				}
	
				if {[N byte 3 0 0 & 31 == 7]} {
					>
						emit {MPEG sequence, H.264 video}
						switch [Nv byte 4 0 {} {}] {
							66 {
								>
									emit {\b, baseline}
								<
							}
							77 {
								>
									emit {\b, main}
								<
							}
							88 {
								>
									emit {\b, extended}
								<
							}
						}
	
						if {[N byte 6 0 0 {} {} x {}]} {
							>
								emit {\b @ L %u}
							<
						}
	
					<
				}
	
			<
		}
		520552448 {
			>
				emit DIF
				if {[N byte 4 0 0 {} {} & 1]} {
					>
						emit {(DVCPRO) movie file}
					<
				}
	
				if {[N byte 4 0 0 {} {} ^ 1]} {
					>
						emit {(DV) movie file}
					<
				}
	
				if {[N byte 3 0 0 {} {} & -128]} {
					>
						emit (PAL)
					<
				}
	
				if {[N byte 3 0 0 {} {} ^ -128]} {
					>
						emit (NTSC)
					<
				}
	
			<
		}
	}
	
	switch [Nv beshort 0 0 & -2] {
		-30 {
			>
				emit {MPEG ADTS, layer III,  v2.5}
				mime audio/mpeg
				switch [Nv byte 2 0 & -16] {
					-128 {
						>
							emit {\b,  64 kbps}
						<
					}
					-112 {
						>
							emit {\b,  80 kbps}
						<
					}
					-96 {
						>
							emit {\b,  96 kbps}
						<
					}
					-80 {
						>
							emit {\b, 112 kbps}
						<
					}
					-64 {
						>
							emit {\b, 128 kbps}
						<
					}
					-48 {
						>
							emit {\b, 144 kbps}
						<
					}
					-32 {
						>
							emit {\b, 160 kbps}
						<
					}
					16 {
						>
							emit {\b,   8 kbps}
						<
					}
					32 {
						>
							emit {\b,  16 kbps}
						<
					}
					48 {
						>
							emit {\b,  24 kbps}
						<
					}
					64 {
						>
							emit {\b,  32 kbps}
						<
					}
					80 {
						>
							emit {\b,  40 kbps}
						<
					}
					96 {
						>
							emit {\b,  48 kbps}
						<
					}
					112 {
						>
							emit {\b,  56 kbps}
						<
					}
				}
	
				switch [Nv byte 2 0 & 12] {
					0 {
						>
							emit {\b, 11.025 kHz}
						<
					}
					4 {
						>
							emit {\b, 12 kHz}
						<
					}
					8 {
						>
							emit {\b, 8 kHz}
						<
					}
				}
	
				switch [Nv byte 3 0 & -64] {
					-128 {
						>
							emit {\b, 2x Monaural}
						<
					}
					-64 {
						>
							emit {\b, Monaural}
						<
					}
					0 {
						>
							emit {\b, Stereo}
						<
					}
					64 {
						>
							emit {\b, JntStereo}
						<
					}
				}
	
			<
		}
		-14 {
			>
				emit {MPEG ADTS, layer III, v2}
				mime audio/mpeg
				switch [Nv byte 2 0 & -16] {
					-128 {
						>
							emit {\b,  64 kbps}
						<
					}
					-112 {
						>
							emit {\b,  80 kbps}
						<
					}
					-96 {
						>
							emit {\b,  96 kbps}
						<
					}
					-80 {
						>
							emit {\b, 112 kbps}
						<
					}
					-64 {
						>
							emit {\b, 128 kbps}
						<
					}
					-48 {
						>
							emit {\b, 144 kbps}
						<
					}
					-32 {
						>
							emit {\b, 160 kbps}
						<
					}
					16 {
						>
							emit {\b,   8 kbps}
						<
					}
					32 {
						>
							emit {\b,  16 kbps}
						<
					}
					48 {
						>
							emit {\b,  24 kbps}
						<
					}
					64 {
						>
							emit {\b,  32 kbps}
						<
					}
					80 {
						>
							emit {\b,  40 kbps}
						<
					}
					96 {
						>
							emit {\b,  48 kbps}
						<
					}
					112 {
						>
							emit {\b,  56 kbps}
						<
					}
				}
	
				switch [Nv byte 2 0 & 12] {
					0 {
						>
							emit {\b, 22.05 kHz}
						<
					}
					4 {
						>
							emit {\b, 24 kHz}
						<
					}
					8 {
						>
							emit {\b, 16 kHz}
						<
					}
				}
	
				switch [Nv byte 3 0 & -64] {
					-128 {
						>
							emit {\b, 2x Monaural}
						<
					}
					-64 {
						>
							emit {\b, Monaural}
						<
					}
					0 {
						>
							emit {\b, Stereo}
						<
					}
					64 {
						>
							emit {\b, JntStereo}
						<
					}
				}
	
			<
		}
		-12 {
			>
				emit {MPEG ADTS, layer II, v2}
				mime audio/mpeg
				switch [Nv byte 2 0 & -16] {
					-128 {
						>
							emit {\b,  64 kbps}
						<
					}
					-112 {
						>
							emit {\b,  80 kbps}
						<
					}
					-96 {
						>
							emit {\b,  96 kbps}
						<
					}
					-80 {
						>
							emit {\b, 112 kbps}
						<
					}
					-64 {
						>
							emit {\b, 128 kbps}
						<
					}
					-48 {
						>
							emit {\b, 144 kbps}
						<
					}
					-32 {
						>
							emit {\b, 160 kbps}
						<
					}
					16 {
						>
							emit {\b,   8 kbps}
						<
					}
					32 {
						>
							emit {\b,  16 kbps}
						<
					}
					48 {
						>
							emit {\b,  24 kbps}
						<
					}
					64 {
						>
							emit {\b,  32 kbps}
						<
					}
					80 {
						>
							emit {\b,  40 kbps}
						<
					}
					96 {
						>
							emit {\b,  48 kbps}
						<
					}
					112 {
						>
							emit {\b,  56 kbps}
						<
					}
				}
	
				switch [Nv byte 2 0 & 12] {
					0 {
						>
							emit {\b, 22.05 kHz}
						<
					}
					4 {
						>
							emit {\b, 24 kHz}
						<
					}
					8 {
						>
							emit {\b, 16 kHz}
						<
					}
				}
	
				switch [Nv byte 3 0 & -64] {
					-128 {
						>
							emit {\b, 2x Monaural}
						<
					}
					-64 {
						>
							emit {\b, Monaural}
						<
					}
					0 {
						>
							emit {\b, Stereo}
						<
					}
					64 {
						>
							emit {\b, JntStereo}
						<
					}
				}
	
			<
		}
		-10 {
			>
				emit {MPEG ADTS, layer I, v2}
				mime audio/mpeg
				switch [Nv byte 2 0 & -16] {
					-128 {
						>
							emit {\b, 128 kbps}
						<
					}
					-112 {
						>
							emit {\b, 144 kbps}
						<
					}
					-96 {
						>
							emit {\b, 160 kbps}
						<
					}
					-80 {
						>
							emit {\b, 176 kbps}
						<
					}
					-64 {
						>
							emit {\b, 192 kbps}
						<
					}
					-48 {
						>
							emit {\b, 224 kbps}
						<
					}
					-32 {
						>
							emit {\b, 256 kbps}
						<
					}
					16 {
						>
							emit {\b,  32 kbps}
						<
					}
					32 {
						>
							emit {\b,  48 kbps}
						<
					}
					48 {
						>
							emit {\b,  56 kbps}
						<
					}
					64 {
						>
							emit {\b,  64 kbps}
						<
					}
					80 {
						>
							emit {\b,  80 kbps}
						<
					}
					96 {
						>
							emit {\b,  96 kbps}
						<
					}
					112 {
						>
							emit {\b, 112 kbps}
						<
					}
				}
	
				switch [Nv byte 2 0 & 12] {
					0 {
						>
							emit {\b, 22.05 kHz}
						<
					}
					4 {
						>
							emit {\b, 24 kHz}
						<
					}
					8 {
						>
							emit {\b, 16 kHz}
						<
					}
				}
	
				switch [Nv byte 3 0 & -64] {
					-128 {
						>
							emit {\b, 2x Monaural}
						<
					}
					-64 {
						>
							emit {\b, Monaural}
						<
					}
					0 {
						>
							emit {\b, Stereo}
						<
					}
					64 {
						>
							emit {\b, JntStereo}
						<
					}
				}
	
			<
		}
		-6 {
			>
				switch [Nv byte 2 0 & -16] {
					-128 {
						>
							emit {MPEG ADTS, layer III, v1, 112 kbps}
							mime audio/mpeg
						<
					}
					-112 {
						>
							emit {MPEG ADTS, layer III, v1, 128 kbps}
							mime audio/mpeg
						<
					}
					-96 {
						>
							emit {MPEG ADTS, layer III, v1, 160 kbps}
							mime audio/mpeg
						<
					}
					-80 {
						>
							emit {MPEG ADTS, layer III, v1, 192 kbps}
							mime audio/mpeg
						<
					}
					-64 {
						>
							emit {MPEG ADTS, layer III, v1, 224 kbps}
							mime audio/mpeg
						<
					}
					-48 {
						>
							emit {MPEG ADTS, layer III, v1, 256 kbps}
							mime audio/mpeg
						<
					}
					-32 {
						>
							emit {MPEG ADTS, layer III, v1, 320 kbps}
							mime audio/mpeg
						<
					}
					16 {
						>
							emit {MPEG ADTS, layer III, v1,  32 kbps}
							mime audio/mpeg
						<
					}
					32 {
						>
							emit {MPEG ADTS, layer III, v1,  40 kbps}
							mime audio/mpeg
						<
					}
					48 {
						>
							emit {MPEG ADTS, layer III, v1,  48 kbps}
							mime audio/mpeg
						<
					}
					64 {
						>
							emit {MPEG ADTS, layer III, v1,  56 kbps}
							mime audio/mpeg
						<
					}
					80 {
						>
							emit {MPEG ADTS, layer III, v1,  64 kbps}
							mime audio/mpeg
						<
					}
					96 {
						>
							emit {MPEG ADTS, layer III, v1,  80 kbps}
							mime audio/mpeg
						<
					}
					112 {
						>
							emit {MPEG ADTS, layer III, v1,  96 kbps}
							mime audio/mpeg
						<
					}
				}
	
				switch [Nv byte 2 0 & 12] {
					0 {
						>
							emit {\b, 44.1 kHz}
						<
					}
					4 {
						>
							emit {\b, 48 kHz}
						<
					}
					8 {
						>
							emit {\b, 32 kHz}
						<
					}
				}
	
				switch [Nv byte 3 0 & -64] {
					-128 {
						>
							emit {\b, 2x Monaural}
						<
					}
					-64 {
						>
							emit {\b, Monaural}
						<
					}
					0 {
						>
							emit {\b, Stereo}
						<
					}
					64 {
						>
							emit {\b, JntStereo}
						<
					}
				}
	
			<
		}
		-4 {
			>
				emit {MPEG ADTS, layer II, v1}
				mime audio/mpeg
				switch [Nv byte 2 0 & -16] {
					-128 {
						>
							emit {\b, 128 kbps}
						<
					}
					-112 {
						>
							emit {\b, 160 kbps}
						<
					}
					-96 {
						>
							emit {\b, 192 kbps}
						<
					}
					-80 {
						>
							emit {\b, 224 kbps}
						<
					}
					-64 {
						>
							emit {\b, 256 kbps}
						<
					}
					-48 {
						>
							emit {\b, 320 kbps}
						<
					}
					-32 {
						>
							emit {\b, 384 kbps}
						<
					}
					16 {
						>
							emit {\b,  32 kbps}
						<
					}
					32 {
						>
							emit {\b,  48 kbps}
						<
					}
					48 {
						>
							emit {\b,  56 kbps}
						<
					}
					64 {
						>
							emit {\b,  64 kbps}
						<
					}
					80 {
						>
							emit {\b,  80 kbps}
						<
					}
					96 {
						>
							emit {\b,  96 kbps}
						<
					}
					112 {
						>
							emit {\b, 112 kbps}
						<
					}
				}
	
				switch [Nv byte 2 0 & 12] {
					0 {
						>
							emit {\b, 44.1 kHz}
						<
					}
					4 {
						>
							emit {\b, 48 kHz}
						<
					}
					8 {
						>
							emit {\b, 32 kHz}
						<
					}
				}
	
				switch [Nv byte 3 0 & -64] {
					-128 {
						>
							emit {\b, 2x Monaural}
						<
					}
					-64 {
						>
							emit {\b, Monaural}
						<
					}
					0 {
						>
							emit {\b, Stereo}
						<
					}
					64 {
						>
							emit {\b, JntStereo}
						<
					}
				}
	
			<
		}
	}
	
	if {[S string 0 0 {} {} eq ADIF]} {
		>
			emit {MPEG ADIF, AAC}
			if {[N byte 4 0 0 {} {} & -128]} {
				>
					if {[N byte 13 0 0 {} {} & 16]} {
						>
							emit {\b, VBR}
						<
					}
	
					if {[N byte 13 0 0 {} {} ^ 16]} {
						>
							emit {\b, CBR}
						<
					}
	
					switch [Nv byte 16 0 & 30] {
						2 {
							>
								emit {\b, single stream}
							<
						}
						4 {
							>
								emit {\b, 2 streams}
							<
						}
						6 {
							>
								emit {\b, 3 streams}
							<
						}
					}
	
					if {[N byte 16 0 0 {} {} & 8]} {
						>
							emit {\b, 4 or more streams}
						<
					}
	
					if {[N byte 16 0 0 {} {} & 16]} {
						>
							emit {\b, 8 or more streams}
						<
					}
	
					if {[N byte 4 0 0 {} {} & -128]} {
						>
							emit {\b, Copyrighted}
						<
					}
	
					if {[N byte 13 0 0 {} {} & 64]} {
						>
							emit {\b, Original Source}
						<
					}
	
					if {[N byte 13 0 0 {} {} & 32]} {
						>
							emit {\b, Home Flag}
						<
					}
	
				<
			}
	
			if {[N byte 4 0 0 {} {} ^ -128]} {
				>
					if {[N byte 4 0 0 {} {} & 16]} {
						>
							emit {\b, VBR}
						<
					}
	
					if {[N byte 4 0 0 {} {} ^ 16]} {
						>
							emit {\b, CBR}
						<
					}
	
					switch [Nv byte 7 0 & 30] {
						2 {
							>
								emit {\b, single stream}
							<
						}
						4 {
							>
								emit {\b, 2 streams}
							<
						}
						6 {
							>
								emit {\b, 3 streams}
							<
						}
					}
	
					if {[N byte 7 0 0 {} {} & 8]} {
						>
							emit {\b, 4 or more streams}
						<
					}
	
					if {[N byte 7 0 0 {} {} & 16]} {
						>
							emit {\b, 8 or more streams}
						<
					}
	
					if {[N byte 4 0 0 {} {} & 64]} {
						>
							emit {\b, Original Stream(s)}
						<
					}
	
					if {[N byte 4 0 0 {} {} & 32]} {
						>
							emit {\b, Home Source}
						<
					}
	
				<
			}
	
			mime audio/x-hx-aac-adif
		<
	}
	
	if {[N beshort 0 0 0 & -10 == -16]} {
		>
			emit {MPEG ADTS, AAC}
			if {[N byte 1 0 0 {} {} & 8]} {
				>
					emit {\b, v2}
				<
			}
	
			if {[N byte 1 0 0 {} {} ^ 8]} {
				>
					emit {\b, v4}
					if {[N byte 2 0 0 {} {} & -64]} {
						>
							emit {\b LTP}
						<
					}
	
				<
			}
	
			switch [Nv byte 2 0 & -64] {
				-128 {
					>
						emit {\b SSR}
					<
				}
				0 {
					>
						emit {\b Main}
					<
				}
				64 {
					>
						emit {\b LC}
					<
				}
			}
	
			switch [Nv byte 2 0 & 60] {
				0 {
					>
						emit {\b, 96 kHz}
					<
				}
				4 {
					>
						emit {\b, 88.2 kHz}
					<
				}
				8 {
					>
						emit {\b, 64 kHz}
					<
				}
				12 {
					>
						emit {\b, 48 kHz}
					<
				}
				16 {
					>
						emit {\b, 44.1 kHz}
					<
				}
				20 {
					>
						emit {\b, 32 kHz}
					<
				}
				24 {
					>
						emit {\b, 24 kHz}
					<
				}
				28 {
					>
						emit {\b, 22.05 kHz}
					<
				}
				32 {
					>
						emit {\b, 16 kHz}
					<
				}
				36 {
					>
						emit {\b, 12 kHz}
					<
				}
				40 {
					>
						emit {\b, 11.025 kHz}
					<
				}
				44 {
					>
						emit {\b, 8 kHz}
					<
				}
			}
	
			switch [Nv beshort 2 0 & 448] {
				64 {
					>
						emit {\b, monaural}
					<
				}
				128 {
					>
						emit {\b, stereo}
					<
				}
				192 {
					>
						emit {\b, stereo + center}
					<
				}
				256 {
					>
						emit {\b, stereo+center+LFE}
					<
				}
				320 {
					>
						emit {\b, surround}
					<
				}
				384 {
					>
						emit {\b, surround + LFE}
					<
				}
			}
	
			if {[N beshort 2 0 0 {} {} & 448]} {
				>
					emit {\b, surround + side}
				<
			}
	
			mime audio/x-hx-aac-adts
		<
	}
	
	if {[N beshort 0 0 0 & -32 == 22240]} {
		>
			emit {MPEG-4 LOAS}
			if {[N byte 3 0 0 & -32 == 64]} {
				>
					switch [Nv byte 4 0 & 60] {
						4 {
							>
								emit {\b, single stream}
							<
						}
						8 {
							>
								emit {\b, 2 streams}
							<
						}
						12 {
							>
								emit {\b, 3 streams}
							<
						}
					}
	
					if {[N byte 4 0 0 {} {} & 8]} {
						>
							emit {\b, 4 or more streams}
						<
					}
	
					if {[N byte 4 0 0 {} {} & 32]} {
						>
							emit {\b, 8 or more streams}
						<
					}
	
				<
			}
	
			if {[N byte 3 0 0 & -64 == 0]} {
				>
					switch [Nv byte 4 0 & 120] {
						8 {
							>
								emit {\b, single stream}
							<
						}
						16 {
							>
								emit {\b, 2 streams}
							<
						}
						24 {
							>
								emit {\b, 3 streams}
							<
						}
					}
	
					if {[N byte 4 0 0 {} {} & 32]} {
						>
							emit {\b, 4 or more streams}
						<
					}
	
					if {[N byte 4 0 0 {} {} & 64]} {
						>
							emit {\b, 8 or more streams}
						<
					}
	
				<
			}
	
			mime audio/x-mp4a-latm
		<
	}
	
	switch [Nv leshort 4 0 {} {}] {
		-20719 {
			>
				if {[N leshort 8 0 0 {} {} == 320]} {
					>
						if {[N leshort 10 0 0 {} {} == 200]} {
							>
								if {[N leshort 12 0 0 {} {} == 8]} {
									>
										emit {FLI animation, 320x200x8}
										if {[N leshort 6 0 0 {} {} x {}]} {
											>
												emit {\b, %d frames}
											<
										}
	
										if {[N leshort 16 0 0 {} {} x {}]} {
											>
												emit {\b, %d/70s per frame}
											<
										}
	
										mime video/x-fli
									<
								}
	
							<
						}
	
					<
				}
	
			<
		}
		-20718 {
			>
				if {[N leshort 12 0 0 {} {} == 8]} {
					>
						emit {FLC animation}
						if {[N leshort 8 0 0 {} {} x {}]} {
							>
								emit {\b, %d}
							<
						}
	
						if {[N leshort 10 0 0 {} {} x {}]} {
							>
								emit {\bx%dx8}
							<
						}
	
						if {[N uleshort 6 0 0 {} {} x {}]} {
							>
								emit {\b, %d frames}
							<
						}
	
						if {[N uleshort 16 0 0 {} {} x {}]} {
							>
								emit {\b, %dms per frame}
							<
						}
	
						mime video/x-flc
					<
				}
	
			<
		}
	}
	
	if {[N belong 0 0 0 & -10486000 == 1195376656]} {
		>
			if {[N byte 188 0 0 {} {} == 71]} {
				>
					emit {MPEG transport stream data}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \x8aMNG]} {
		>
			emit {MNG video data,}
			if {[N belong 4 0 0 {} {} != 218765834]} {
				>
					emit CORRUPTED,
				<
			}
	
			if {[N belong 4 0 0 {} {} == 218765834]} {
				>
					if {[N belong 16 0 0 {} {} x {}]} {
						>
							emit {%d x}
						<
					}
	
					if {[N belong 20 0 0 {} {} x {}]} {
						>
							emit %d
						<
					}
	
				<
			}
	
			mime video/x-mng
		<
	}
	
	if {[S string 0 0 {} {} eq \x8bJNG]} {
		>
			emit {JNG video data,}
			if {[N belong 4 0 0 {} {} != 218765834]} {
				>
					emit CORRUPTED,
				<
			}
	
			if {[N belong 4 0 0 {} {} == 218765834]} {
				>
					if {[N belong 16 0 0 {} {} x {}]} {
						>
							emit {%d x}
						<
					}
	
					if {[N belong 20 0 0 {} {} x {}]} {
						>
							emit %d
						<
					}
	
				<
			}
	
			mime video/x-jng
		<
	}
	
	if {[S string 3 0 {} {} eq \x0D\x0AVersion:Vivo]} {
		>
			emit {Vivo video data}
		<
	}
	
	if {[S string 0 0 w {} eq \#VRML\ V1.0\ ascii]} {
		>
			emit {VRML 1 file}
			mime model/vrml
		<
	}
	
	if {[S string 0 0 w {} eq \#VRML\ V2.0\ utf8]} {
		>
			emit {ISO/IEC 14772 VRML 97 file}
			mime model/vrml
		<
	}
	
	if {[S string 0 0 w {} eq <?xml\ version=]} {
		>
			if {[S search 20 0 w 1000 eq <!DOCTYPE\ X3D]} {
				>
					emit {X3D (Extensible 3D) model xml text}
					mime model/x3d+xml
				<
			}
	
			strength {+ 5}
		<
	}
	
	if {[S string 0 0 {} {} eq HVQM4]} {
		>
			emit %s
			if {[S string 6 0 {} {} > \0]} {
				>
					emit v%s
				<
			}
	
			if {[N byte 0 0 0 {} {} x {}]} {
				>
					emit {GameCube movie,}
				<
			}
	
			if {[N ubeshort 52 0 0 {} {} x {}]} {
				>
					emit {%d x}
				<
			}
	
			if {[N ubeshort 54 0 0 {} {} x {}]} {
				>
					emit %d,
				<
			}
	
			if {[N ubeshort 38 0 0 {} {} x {}]} {
				>
					emit %dus,
				<
			}
	
			if {[N ubeshort 66 0 0 {} {} == 0]} {
				>
					emit {no audio}
				<
			}
	
			if {[N ubeshort 66 0 0 {} {} > 0]} {
				>
					emit {%dHz audio}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq DVDVIDEO-VTS]} {
		>
			emit {Video title set,}
			if {[N byte 33 0 0 {} {} x {}]} {
				>
					emit v%x
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq DVDVIDEO-VMG]} {
		>
			emit {Video manager,}
			if {[N byte 33 0 0 {} {} x {}]} {
				>
					emit v%x
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq NuppelVideo]} {
		>
			emit {MythTV NuppelVideo}
			if {[S string 12 0 {} {} x {}]} {
				>
					emit v%s
				<
			}
	
			if {[N lelong 20 0 0 {} {} x {}]} {
				>
					emit (%d
				<
			}
	
			if {[N lelong 24 0 0 {} {} x {}]} {
				>
					emit {\bx%d),}
				<
			}
	
			if {[S string 36 0 {} {} eq P]} {
				>
					emit {\bprogressive,}
				<
			}
	
			if {[S string 36 0 {} {} eq I]} {
				>
					emit {\binterlaced,}
				<
			}
	
			if {[N ledouble 40 0 0 {} {} x {}]} {
				>
					emit {\baspect:%.2f,}
				<
			}
	
			if {[N ledouble 48 0 0 {} {} x {}]} {
				>
					emit {\bfps:%.2f}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq MythTV]} {
		>
			emit {MythTV NuppelVideo}
			if {[S string 12 0 {} {} x {}]} {
				>
					emit v%s
				<
			}
	
			if {[N lelong 20 0 0 {} {} x {}]} {
				>
					emit (%d
				<
			}
	
			if {[N lelong 24 0 0 {} {} x {}]} {
				>
					emit {\bx%d),}
				<
			}
	
			if {[S string 36 0 {} {} eq P]} {
				>
					emit {\bprogressive,}
				<
			}
	
			if {[S string 36 0 {} {} eq I]} {
				>
					emit {\binterlaced,}
				<
			}
	
			if {[N ledouble 40 0 0 {} {} x {}]} {
				>
					emit {\baspect:%.2f,}
				<
			}
	
			if {[N ledouble 48 0 0 {} {} x {}]} {
				>
					emit {\bfps:%.2f}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq BIK]} {
		>
			emit {Bink Video}
			if {[S regex 3 0 {} {} eq \[a-z\]]} {
				>
					emit rev.%s
				<
			}
	
			if {[N ulelong 20 0 0 {} {} x {}]} {
				>
					emit {\b, %d}
				<
			}
	
			if {[N ulelong 24 0 0 {} {} x {}]} {
				>
					emit {\bx%d}
				<
			}
	
			if {[N ulelong 8 0 0 {} {} x {}]} {
				>
					emit {\b, %d frames}
				<
			}
	
			if {[N ulelong 32 0 0 {} {} x {}]} {
				>
					emit {at rate %d/}
				<
			}
	
			if {[N ulelong 28 0 0 {} {} > 1]} {
				>
					emit {\b%d}
				<
			}
	
			if {[N ulelong 40 0 0 {} {} == 0]} {
				>
					emit {\b, no audio}
				<
			}
	
			if {[N ulelong 40 0 0 {} {} != 0]} {
				>
					emit {\b, %d audio track}
					if {[N ulelong 40 0 0 {} {} != 1]} {
						>
							emit {\bs}
						<
					}
	
					if {[N uleshort 48 0 0 {} {} x {}]} {
						>
							emit %dHz
						<
					}
	
					if {[N byte 51 0 0 & 32 == 0]} {
						>
							emit mono
						<
					}
	
					if {[N byte 51 0 0 & 32 != 0]} {
						>
							emit stereo
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq nut/multimedia\ container\0]} {
		>
			emit {NUT multimedia container}
		<
	}
	
	if {[S string 0 0 {} {} eq NSVf]} {
		>
			emit {Nullsoft Video}
		<
	}
	
	if {[S string 4 0 {} {} eq RED1]} {
		>
			emit {REDCode Video}
		<
	}
	
	if {[S string 0 0 {} {} eq AMVS]} {
		>
			emit {MTV Multimedia File}
		<
	}
	
	if {[S string 0 0 {} {} eq ARMovie\012]} {
		>
			emit ARMovie
		<
	}
	
	if {[S string 0 0 {} {} eq Interplay\040MVE\040File\032]} {
		>
			emit {Interplay MVE Movie}
		<
	}
	
	switch [Nv bequad 0 0 {} {}] {
		-9207870847048482801 {
			>
				emit {Nintendo 64 ROM image}
				mime application/x-n64-rom
				if {[S string 32 0 {} {} > \0]} {
					>
						emit {\b: "%.20s"}
					<
				}
	
				if {[S string 59 0 {} {} x {}]} {
					>
						emit (%.4s
					<
				}
	
				if {[N byte 63 0 0 {} {} x {}]} {
					>
						emit {\b, Rev.%02u)}
					<
				}
	
			<
		}
		-9121646941414855425 {
			>
				emit {LLVM indexed profile data,}
				if {[N byte [R 7] 0 0 {} {} x {}]} {
					>
						emit {version %d (big-endian)}
					<
				}
	
			<
		}
		-6518119229588284681 {
			>
				emit {Hash::SharedMem master file, big-endian}
				if {[N bequad 8 0 0 {} {} < 16777216]} {
					>
						if {[N byte 15 0 0 {} {} > 2]} {
							>
								emit {\b, line size 2^%d byte}
							<
						}
	
						if {[N byte 14 0 0 {} {} > 2]} {
							>
								emit {\b, page size 2^%d byte}
							<
						}
	
						if {[N byte 13 0 0 {} {} & 1]} {
							>
								if {[N byte 13 0 0 {} {} > 1]} {
									>
										emit {\b, max fanout %d}
									<
								}
	
							<
						}
	
					<
				}
	
			<
		}
		-5199405631432697327 {
			>
				if {[N bequad 8 0 0 {} {} == -6463228381250015859]} {
					>
						emit {Windows Television DVR Media}
					<
				}
	
			<
		}
		-4137723088997562430 {
			>
				emit {Hash::SharedMem data file, big-endian}
				if {[N bequad 8 0 0 {} {} < 16777216]} {
					>
						if {[N byte 15 0 0 {} {} > 2]} {
							>
								emit {\b, line size 2^%d byte}
							<
						}
	
						if {[N byte 14 0 0 {} {} > 2]} {
							>
								emit {\b, page size 2^%d byte}
							<
						}
	
						if {[N byte 13 0 0 {} {} & 1]} {
							>
								if {[N byte 13 0 0 {} {} > 1]} {
									>
										emit {\b, max fanout %d}
									<
								}
	
							<
						}
	
					<
				}
	
			<
		}
		-41534659755609471 {
			>
				emit {LLVM raw profile data,}
				if {[N byte [R 7] 0 0 {} {} x {}]} {
					>
						emit {version %d (big-endian)}
					<
				}
	
			<
		}
		11259375 {
			>
				emit {Erlang DETS file}
			<
		}
		2566813404 {
			>
				if {[N ubeshort 8 0 0 {} {} < 10]} {
					>
						emit {APT cache data, version %u}
						if {[N beshort 10 0 0 {} {} x {}]} {
							>
								emit {\b.%u, 64 bit big-endian}
							<
						}
	
						U 15 apt-cache-64bit-be 0
	
					<
				}
	
			<
		}
		65677417116533018 {
			>
				emit {UCL compressed data}
			<
		}
		1315192064904724480 {
			>
				emit {Nintendo 64 ROM image (wordswapped)}
				mime application/x-n64-rom
			<
		}
		3999266915158593280 {
			>
				emit {Nintendo 64 ROM image (V64)}
				mime application/x-n64-rom
			<
		}
		4616813591155179520 {
			>
				emit {Nintendo 64 ROM image (32-bit byteswapped)}
				mime application/x-n64-rom
			<
		}
	}
	
	if {[S string 0 0 {} {} eq FILM]} {
		>
			emit {Sega FILM/CPK Multimedia,}
			if {[N belong 32 0 0 {} {} x {}]} {
				>
					emit {%d x}
				<
			}
	
			if {[N belong 28 0 0 {} {} x {}]} {
				>
					emit %d
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq THP\0]} {
		>
			emit {Nintendo THP Multimedia}
		<
	}
	
	if {[S string 0 0 {} {} eq BBCD]} {
		>
			emit {BBC Dirac Video}
		<
	}
	
	if {[S string 0 0 {} {} eq SMK]} {
		>
			emit {RAD Game Tools Smacker Multimedia}
			if {[N byte 3 0 0 {} {} x {}]} {
				>
					emit {version %c,}
				<
			}
	
			if {[N lelong 4 0 0 {} {} x {}]} {
				>
					emit {%d x}
				<
			}
	
			if {[N lelong 8 0 0 {} {} x {}]} {
				>
					emit %d,
				<
			}
	
			if {[N lelong 12 0 0 {} {} x {}]} {
				>
					emit {%d frames}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \x06\x0e\x2b\x34\x02\x05\x01\x01\x0d\x01\x02\x01\x01\x02]} {
		>
			emit {Material exchange container format}
			mime application/mxf
			ext mxf
		<
	}
	
	if {[S string 0 0 {} {} eq ANIM]} {
		>
			if {[S string 8 0 {} {} eq AHDR]} {
				>
					emit {LucasArts Smush Animation Format (SAN) video}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq SANM]} {
		>
			if {[S string 8 0 {} {} eq SHDR]} {
				>
					emit {LucasArts Smush v2 (SANM) video}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq Obj]} {
		>
			emit {Apache Avro}
			if {[N byte 3 0 0 {} {} x {}]} {
				>
					emit {version %d}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq ORC]} {
		>
			emit {Apache ORC}
		<
	}
	
	if {[S string 0 0 {} {} eq PAR1]} {
		>
			emit {Apache Parquet}
		<
	}
	
	if {[S string 0 0 {} {} eq RCF]} {
		>
			emit {Apache Hive RC file}
			if {[N byte 3 0 0 {} {} x {}]} {
				>
					emit {version %d}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq SEQ]} {
		>
			if {[N byte 3 0 0 {} {} < 6]} {
				>
					emit {Apache Hadoop Sequence file version %d}
				<
			}
	
			if {[N byte 3 0 0 {} {} > 6]} {
				>
					emit {Apache Hadoop Sequence file version %d}
				<
			}
	
			if {[N byte 3 0 0 {} {} == 6]} {
				>
					if {[S string 5 0 {} {} eq org.apache.hadoop.hive.ql.io.RCFile\$KeyBuffer]} {
						>
							emit {Apache Hive RC file version 0}
						<
					}
	
					if {[D 3]} {
						>
							emit {Apache Hadoop Sequence file version 6}
						<
					}
	
				<
			}
	
		<
	}
	
	switch [Nv long 0 0 {} {}] {
		-1042103351 {
			>
				emit {SPSS Portable File}
				if {[S string 40 0 {} {} x {}]} {
					>
						emit %s
					<
				}
	
			<
		}
		-762612112 {
			>
				emit {CLISP memory image data, other endian}
			<
		}
		-97271666 {
			>
				emit {SunPC 4.0 Hard Disk}
			<
		}
		-1 {
			>
				if {[N belong [R 0] 0 0 {} {} == -1432791706]} {
					>
						emit {Xilinx RAW bitstream (.BIN)}
					<
				}
	
			<
		}
		262 {
			>
				emit {68k Blit mpx/mux executable}
			<
		}
		268 {
			>
				emit {unknown demand paged pure executable}
				if {[N long 16 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		269 {
			>
				emit {i960 b.out relocatable object}
				if {[N long 16 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		270 {
			>
				emit {unknown readable demand paged pure executable}
			<
		}
		31415 {
			>
				emit {Mirage Assembler m.out executable}
			<
		}
		33132 {
			>
				emit {APL workspace (Ken's original?)}
			<
			>
				emit {apl workspace}
			<
		}
		59397 {
			>
				emit {overlay object file (z8000 a.out)}
			<
		}
		59399 {
			>
				emit {object file (z8000 a.out)}
			<
		}
		59400 {
			>
				emit {pure object file (z8000 a.out)}
			<
		}
		59401 {
			>
				emit {separate object file (z8000 a.out)}
			<
		}
		61374 {
			>
				emit {OSF/Rose object}
			<
		}
		65381 {
			>
				emit {HP old archive}
			<
		}
		340322 {
			>
				emit {Berkeley DB 1.85/1.86}
				if {[N long 4 0 0 {} {} > 0]} {
					>
						emit {(Btree, version %d, native byte-order)}
					<
				}
	
			<
		}
		395726 {
			>
				emit {Jaleo XFS file}
				if {[N long 4 0 0 {} {} x {}]} {
					>
						emit {- version %d}
					<
				}
	
				if {[N long 8 0 0 {} {} x {}]} {
					>
						emit {- [%d -}
					<
				}
	
				if {[N long 20 0 0 {} {} x {}]} {
					>
						emit {\b%dx}
					<
				}
	
				if {[N long 24 0 0 {} {} x {}]} {
					>
						emit {\b%dx}
					<
				}
	
				switch [Nv long 28 0 {} {}] {
					1000 {
						>
							emit {\bRGB24]}
						<
					}
					1008 {
						>
							emit {\bYUV422]}
						<
					}
				}
	
			<
		}
		398689 {
			>
				emit {Berkeley DB}
				mime application/x-dbm
				switch [Nv belong 8 0 {} {}] {
					1234 {
						>
							if {[N belong 4 0 0 {} {} > 2]} {
								>
									emit 1.86
								<
							}
	
							if {[N belong 4 0 0 {} {} < 3]} {
								>
									emit 1.85
								<
							}
	
							if {[N belong 4 0 0 {} {} > 0]} {
								>
									emit {(Hash, version %d, little-endian)}
								<
							}
	
						<
					}
					4321 {
						>
							if {[N belong 4 0 0 {} {} > 2]} {
								>
									emit 1.86
								<
							}
	
							if {[N belong 4 0 0 {} {} < 3]} {
								>
									emit 1.85
								<
							}
	
							if {[N belong 4 0 0 {} {} > 0]} {
								>
									emit {(Hash, version %d, native byte-order)}
								<
							}
	
						<
					}
				}
	
			<
		}
		1234567 {
			>
				emit {X image}
			<
		}
		22552998 {
			>
				emit {HP core file}
			<
		}
		34078982 {
			>
				emit {HP s500 relocatable executable}
				if {[N long 16 0 0 {} {} > 0]} {
					>
						emit {- version %d}
					<
				}
	
			<
		}
		34078983 {
			>
				emit {HP s500 executable}
				if {[N long 16 0 0 {} {} > 0]} {
					>
						emit {- version %d}
					<
				}
	
			<
		}
		34078984 {
			>
				emit {HP s500 pure executable}
				if {[N long 16 0 0 {} {} > 0]} {
					>
						emit {- version %d}
					<
				}
	
			<
		}
		34144101 {
			>
				emit {HP s500 old archive}
			<
		}
		34275173 {
			>
				emit {HP s200 old archive}
			<
		}
		34341132 {
			>
				emit {compiled Lisp}
			<
		}
		34406245 {
			>
				emit {HP s200 old archive}
			<
		}
		135137807 {
			>
				emit {TML 2301 byte-order format}
			<
		}
		168757262 {
			>
				emit {TML 0123 byte-order format}
			<
		}
		235409162 {
			>
				emit {TML 3210 byte-order format}
			<
		}
		252317192 {
			>
				emit {TML 1032 byte-order format}
			<
		}
		1123028772 {
			>
				emit {Artisan image data}
				switch [Nv long 4 0 {} {}] {
					1 {
						>
							emit {\b, rectangular 24-bit}
						<
					}
					2 {
						>
							emit {\b, rectangular 8-bit with colormap}
						<
					}
					3 {
						>
							emit {\b, rectangular 32-bit (24-bit with matte)}
						<
					}
				}
	
			<
		}
		1145263299 {
			>
				emit {DACT compressed data}
				if {[N byte 4 0 0 {} {} > -1]} {
					>
						emit {(version %i.}
					<
				}
	
				if {[N byte 5 0 0 {} {} > -1]} {
					>
						emit %i.
					<
				}
	
				if {[N byte 6 0 0 {} {} > -1]} {
					>
						emit %i)
					<
				}
	
				if {[N long 7 0 0 {} {} > 0]} {
					>
						emit {, original size: %i bytes}
					<
				}
	
				if {[N long 15 0 0 {} {} > 30]} {
					>
						emit {, block size: %i bytes}
					<
				}
	
			<
			>
				emit {DACT compressed data}
				if {[N byte 4 0 0 {} {} > -1]} {
					>
						emit {(version %i.}
					<
				}
	
				if {[N byte 5 0 0 {} {} > -1]} {
					>
						emit {$BS%i.}
					<
				}
	
				if {[N byte 6 0 0 {} {} > -1]} {
					>
						emit {$BS%i)}
					<
				}
	
				if {[N long 7 0 0 {} {} > 0]} {
					>
						emit {$BS, original size: %i bytes}
					<
				}
	
				if {[N long 15 0 0 {} {} > 30]} {
					>
						emit {$BS, block size: %i bytes}
					<
				}
	
			<
		}
		1302851304 {
			>
				emit {HP-WINDOWS font}
				if {[N byte 8 0 0 {} {} > 0]} {
					>
						emit {- version %d}
					<
				}
	
			<
		}
		1351614727 {
			>
				emit {Pyramid 90x family executable}
			<
		}
		1351614728 {
			>
				emit {Pyramid 90x family pure executable}
				if {[N long 16 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		1351614731 {
			>
				emit {Pyramid 90x family demand paged pure executable}
				if {[N long 16 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		1886817234 {
			>
				emit {CLISP memory image data}
			<
		}
	}
	
	if {[S search 0 0 t 1 eq FiLeStArTfIlEsTaRt]} {
		>
			emit {binscii (apple ][) text}
		<
	}
	
	if {[S string 0 0 {} {} eq \x0aGL]} {
		>
			emit {Binary II (apple ][) data}
		<
	}
	
	if {[S string 0 0 {} {} eq \x76\xff]} {
		>
			emit {Squeezed (apple ][) data}
		<
	}
	
	if {[S string 0 0 {} {} eq NuFile]} {
		>
			emit {NuFile archive (apple ][) data}
		<
	}
	
	if {[S string 0 0 {} {} eq N\xf5F\xe9l\xe5]} {
		>
			emit {NuFile archive (apple ][) data}
		<
	}
	
	if {[S string 0 0 {} {} eq 2IMG]} {
		>
			emit {Apple ][ 2IMG Disk Image}
			if {[S string 4 0 {} {} eq XGS!]} {
				>
					emit {\b, XGS}
				<
			}
	
			if {[S string 4 0 {} {} eq CTKG]} {
				>
					emit {\b, Catakig}
				<
			}
	
			if {[S string 4 0 {} {} eq ShIm]} {
				>
					emit {\b, Sheppy's ImageMaker}
				<
			}
	
			if {[S string 4 0 {} {} eq WOOF]} {
				>
					emit {\b, Sweet 16}
				<
			}
	
			if {[S string 4 0 {} {} eq B2TR]} {
				>
					emit {\b, Bernie ][ the Rescue}
				<
			}
	
			if {[S string 4 0 {} {} ne nfc]} {
				>
					emit {\b, ASIMOV2}
				<
			}
	
			if {[S string 4 0 {} {} x {}]} {
				>
					emit {\b, Unknown Format}
				<
			}
	
			switch [Nv byte 12 0 {} {}] {
				0 {
					>
						emit {\b, DOS 3.3 sector order}
						if {[N byte 16 0 0 {} {} == 0]} {
							>
								emit {\b, Volume 254}
							<
						}
	
						if {[N byte 16 0 0 & 127 x {}]} {
							>
								emit {\b, Volume %u}
							<
						}
	
					<
				}
				1 {
					>
						emit {\b, ProDOS sector order}
						if {[N short 20 0 0 {} {} x {}]} {
							>
								emit {\b, %u Blocks}
							<
						}
	
					<
				}
				2 {
					>
						emit {\b, NIB data}
					<
				}
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq package0]} {
		>
			emit {Newton package, NOS 1.x,}
			if {[N belong 12 0 0 {} {} & -2147483648]} {
				>
					emit AutoRemove,
				<
			}
	
			if {[N belong 12 0 0 {} {} & 1073741824]} {
				>
					emit CopyProtect,
				<
			}
	
			if {[N belong 12 0 0 {} {} & 268435456]} {
				>
					emit NoCompression,
				<
			}
	
			if {[N belong 12 0 0 {} {} & 67108864]} {
				>
					emit Relocation,
				<
			}
	
			if {[N belong 12 0 0 {} {} & 33554432]} {
				>
					emit UseFasterCompression,
				<
			}
	
			if {[N belong 16 0 0 {} {} x {}]} {
				>
					emit {version %d}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq package1]} {
		>
			emit {Newton package, NOS 2.x,}
			if {[N belong 12 0 0 {} {} & -2147483648]} {
				>
					emit AutoRemove,
				<
			}
	
			if {[N belong 12 0 0 {} {} & 1073741824]} {
				>
					emit CopyProtect,
				<
			}
	
			if {[N belong 12 0 0 {} {} & 268435456]} {
				>
					emit NoCompression,
				<
			}
	
			if {[N belong 12 0 0 {} {} & 67108864]} {
				>
					emit Relocation,
				<
			}
	
			if {[N belong 12 0 0 {} {} & 33554432]} {
				>
					emit UseFasterCompression,
				<
			}
	
			if {[N belong 16 0 0 {} {} x {}]} {
				>
					emit {version %d}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq package4]} {
		>
			emit {Newton package,}
			switch [Nv byte 8 0 {} {}] {
				8 {
					>
						emit {NOS 1.x,}
					<
				}
				9 {
					>
						emit {NOS 2.x,}
					<
				}
			}
	
			if {[N belong 12 0 0 {} {} & -2147483648]} {
				>
					emit AutoRemove,
				<
			}
	
			if {[N belong 12 0 0 {} {} & 1073741824]} {
				>
					emit CopyProtect,
				<
			}
	
			if {[N belong 12 0 0 {} {} & 268435456]} {
				>
					emit NoCompression,
				<
			}
	
		<
	}
	
	if {[S string 4 0 {} {} eq O]} {
		>
			if {[N ubequad 84 0 0 {} {} ^ 71494644084571648]} {
				>
					if {[S regex 5 0 s {} eq \[=.<>|!^\x8a\]\{79\}]} {
						>
							emit {AppleWorks Word Processor}
							if {[N ubyte 183 0 0 {} {} == 30]} {
								>
									emit 3.0
								<
							}
	
							if {[N ubyte 183 0 0 {} {} != 30]} {
								>
									if {[N ubyte 183 0 0 {} {} != 0]} {
										>
											emit 0x%x
										<
									}
	
								<
							}
	
							if {[S string 5 0 {} {} x {}]} {
								>
									emit {\b, tabstop ruler "%6.6s"}
								<
							}
	
							if {[N byte 85 0 0 & 1 > 0]} {
								>
									emit {\b, zoomed}
								<
							}
	
							if {[N byte 90 0 0 & 1 > 0]} {
								>
									emit {\b, paginated}
								<
							}
	
							if {[N byte 92 0 0 & 1 > 0]} {
								>
									emit {\b, with mail merge}
								<
							}
	
							if {[N ubyte 91 0 0 {} {} > 0]} {
								>
									if {[N ubyte 91 0 0 {} {} x {}]} {
										>
											emit {\b, %d/10 inch left margin}
										<
									}
	
								<
							}
	
							mime application/x-appleworks3
							ext awp
						<
					}
	
				<
			}
	
		<
	}
	
	if {[N belong 0 0 0 & 16711935 == 524288]} {
		>
			if {[N leshort 2 0 0 {} {} > 0]} {
				>
					emit {Applesoft BASIC program data, first line number %d}
				<
			}
	
		<
	}
	
	switch [Nv belong 0 0 & -16711681] {
		1442840576 {
			>
				if {[S regex 1 0 s {} eq ^\[0-9\]]} {
					>
						emit {ps database}
						if {[S string 1 0 {} {} > \0]} {
							>
								emit {version %s}
							<
						}
	
						if {[S string 4 0 {} {} > \0]} {
							>
								emit {from kernel %s}
							<
						}
	
					<
				}
	
			<
		}
		1677774848 {
			>
				emit {Apple Mechanic font}
			<
		}
	}
	
	if {[S string 0 0 {} {} eq bplist00]} {
		>
			emit {Apple binary property list}
		<
	}
	
	if {[S string 0 0 {} {} eq bplist]} {
		>
			if {[N byte 6 0 0 {} {} x {}]} {
				>
					emit {\bCoreFoundation binary property list data, version 0x%c}
					if {[N byte 7 0 0 {} {} x {}]} {
						>
							emit {\b%c}
						<
					}
	
				<
			}
	
			if {[S string 6 0 {} {} eq 00]} {
				>
					emit {\b}
					switch [Nv byte 8 0 & -16] {
						-128 {
							>
								emit {\b, root type: uid (CORRUPT)}
							<
						}
						-96 {
							>
								emit {\b, root type: array}
							<
						}
						-48 {
							>
								emit {\b, root type: dictionary}
							<
						}
						0 {
							>
								emit {\b}
								switch [Nv byte 8 0 & 15] {
									0 {
										>
											emit {\b, root type: null}
										<
									}
									8 {
										>
											emit {\b, root type: false boolean}
										<
									}
									9 {
										>
											emit {\b, root type: true boolean}
										<
									}
								}
	
							<
						}
						16 {
							>
								emit {\b, root type: integer}
							<
						}
						32 {
							>
								emit {\b, root type: real}
							<
						}
						48 {
							>
								emit {\b, root type: date}
							<
						}
						64 {
							>
								emit {\b, root type: data}
							<
						}
						80 {
							>
								emit {\b, root type: ascii string}
							<
						}
						96 {
							>
								emit {\b, root type: unicode string}
							<
						}
					}
	
				<
			}
	
		<
	}
	
	if {[S string 2 0 {} {} eq typedstream]} {
		>
			emit {NeXT/Apple typedstream data, big endian}
			if {[N byte 0 0 0 {} {} x {}]} {
				>
					emit {\b, version %d}
				<
			}
	
			if {[N byte 0 0 0 {} {} < 5]} {
				>
					emit {\b}
					if {[N byte 13 0 0 {} {} == -127]} {
						>
							emit {\b}
							if {[N ubeshort 14 0 0 {} {} x {}]} {
								>
									emit {\b, system %d}
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 2 0 {} {} eq streamtyped]} {
		>
			emit {NeXT/Apple typedstream data, little endian}
			if {[N byte 0 0 0 {} {} x {}]} {
				>
					emit {\b, version %d}
				<
			}
	
			if {[N byte 0 0 0 {} {} < 5]} {
				>
					emit {\b}
					if {[N byte 13 0 0 {} {} == -127]} {
						>
							emit {\b}
							if {[N uleshort 14 0 0 {} {} x {}]} {
								>
									emit {\b, system %d}
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq caff]} {
		>
			emit {CoreAudio Format audio file}
			if {[N beshort 4 0 0 {} {} < 10]} {
				>
					emit {version %d}
				<
			}
	
			if {[N beshort 6 0 0 {} {} x {}]} {
				>
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq kych]} {
		>
			emit {Mac OS X Keychain File}
		<
	}
	
	if {[S string 4 0 {} {} eq innotek\ VirtualBox\ Disk\ Image]} {
		>
			emit %s
		<
	}
	
	if {[S string 0 0 {} {} eq \0\0\0\1Bud1\0]} {
		>
			emit {Apple Desktop Services Store}
		<
	}
	
	if {[S string 0 0 {} {} eq \000\000\001\000]} {
		>
			if {[N leshort 4 0 0 {} {} == 0]} {
				>
					if {[N lelong 16 0 0 {} {} == 0]} {
						>
							emit {Apple HFS/HFS+ resource fork}
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq FasdUAS]} {
		>
			emit {AppleScript compiled}
		<
	}
	
	if {[S string 4 0 {} {} eq BOBO]} {
		>
			if {[N byte 0 0 0 {} {} > 4]} {
				>
					if {[N belong 12 0 0 {} {} == 0]} {
						>
							if {[N belong 26 0 0 {} {} == 0]} {
								>
									U 12 appleworks 0
	
								<
							}
	
						<
					}
	
				<
			}
	
			if {[N belong 0 0 0 {} {} == 75607296]} {
				>
					U 12 appleworks 0
	
				<
			}
	
		<
	}
	
	if {[S string 32 0 {} {} eq NXSB]} {
		>
			emit {Apple File System (APFS)}
			if {[N ulelong 36 0 0 {} {} x {}]} {
				>
					emit {\b, blocksize %u}
				<
			}
	
		<
	}
	
	if {[S string 4 0 {} {} eq itch]} {
		>
			if {[S string 24 0 {} {} eq artw]} {
				>
					if {[S string 488 0 {} {} eq data]} {
						>
							emit {iTunes cover art}
							if {[S string 493 0 {} {} eq PNG]} {
								>
									emit (PNG)
								<
							}
	
							if {[N beshort 492 0 0 {} {} == -40]} {
								>
									emit (JPEG)
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 65 0 {} {} eq PNTGMPNT]} {
		>
			emit {MacPaint image data}
		<
	}
	
	if {[S string 0 0 {} {} eq PBLAPP\000\000]} {
		>
			emit {Pebble application}
		<
	}
	
	if {[S string 0 0 {} {} eq *BEGIN]} {
		>
			emit Applixware
			if {[S string 7 0 {} {} eq WORDS]} {
				>
					emit {Words Document}
				<
			}
	
			if {[S string 7 0 {} {} eq GRAPHICS]} {
				>
					emit Graphic
				<
			}
	
			if {[S string 7 0 {} {} eq RASTER]} {
				>
					emit Bitmap
				<
			}
	
			if {[S string 7 0 {} {} eq SPREADSHEETS]} {
				>
					emit Spreadsheet
				<
			}
	
			if {[S string 7 0 {} {} eq MACRO]} {
				>
					emit Macro
				<
			}
	
			if {[S string 7 0 {} {} eq BUILDER]} {
				>
					emit {Builder Object}
				<
			}
	
		<
	}
	
	switch [Nv lequad 0 0 {} {}] {
		-9121646941414855425 {
			>
				emit {LLVM indexed profile data,}
				if {[N byte [R 0] 0 0 {} {} x {}]} {
					>
						emit {version %d}
					<
				}
	
			<
		}
		-6518119229588284681 {
			>
				emit {Hash::SharedMem master file, little-endian}
				if {[N lequad 8 0 0 {} {} < 16777216]} {
					>
						if {[N byte 8 0 0 {} {} > 2]} {
							>
								emit {\b, line size 2^%d byte}
							<
						}
	
						if {[N byte 9 0 0 {} {} > 2]} {
							>
								emit {\b, page size 2^%d byte}
							<
						}
	
						if {[N byte 10 0 0 {} {} & 1]} {
							>
								if {[N byte 10 0 0 {} {} > 1]} {
									>
										emit {\b, max fanout %d}
									<
								}
	
							<
						}
	
					<
				}
	
			<
		}
		-4137723088997562430 {
			>
				emit {Hash::SharedMem data file, little-endian}
				if {[N lequad 8 0 0 {} {} < 16777216]} {
					>
						if {[N byte 8 0 0 {} {} > 2]} {
							>
								emit {\b, line size 2^%d byte}
							<
						}
	
						if {[N byte 9 0 0 {} {} > 2]} {
							>
								emit {\b, page size 2^%d byte}
							<
						}
	
						if {[N byte 10 0 0 {} {} & 1]} {
							>
								if {[N byte 10 0 0 {} {} > 1]} {
									>
										emit {\b, max fanout %d}
									<
								}
	
							<
						}
	
					<
				}
	
			<
		}
		-41534659755609471 {
			>
				emit {LLVM raw profile data,}
				if {[N byte [R 0] 0 0 {} {} x {}]} {
					>
						emit {version %d}
					<
				}
	
			<
		}
		2566813404 {
			>
				if {[N uleshort 8 0 0 {} {} < 10]} {
					>
						emit {APT cache data, version %u}
						if {[N leshort 10 0 0 {} {} x {}]} {
							>
								emit {\b.%u, 64 bit little-endian}
							<
						}
	
						U 15 apt-cache-64bit-be 0
	
					<
				}
	
			<
		}
	}
	
	if {[N quad 500 0 0 {} {} == 0]} {
		>
			if {[N ubeshort 0 0 0 {} {} > 7936]} {
				>
					if {[N ubeshort 0 0 0 {} {} < 64765]} {
						>
							if {[N ubelong 508 0 0 & 2342424063 == 0]} {
								>
									if {[N ubyte 100 0 0 & 200 == 0]} {
										>
											if {[N ubyte 101 0 0 & 200 == 0]} {
												>
													if {[N ubyte 155 0 0 & 223 == 0]} {
														>
															if {[N ubyte 148 0 0 & 239 == 32]} {
																>
																	U 16 tar-file 0
	
																<
															}
	
														<
													}
	
												<
											}
	
										<
									}
	
								<
							}
	
						<
					}
	
				<
			}
	
			strength /2
		<
	}
	
	if {[S string 0 0 {} {} eq GNU\ tar-]} {
		>
			emit {GNU tar incremental snapshot data}
			if {[S regex [R 0] 0 {} {} eq \[0-9\].\[0-9\]+-\[0-9\]+]} {
				>
					emit {version %s}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq 070707]} {
		>
			emit {ASCII cpio archive (pre-SVR4 or odc)}
		<
	}
	
	if {[S string 0 0 {} {} eq 070701]} {
		>
			emit {ASCII cpio archive (SVR4 with no CRC)}
		<
	}
	
	if {[S string 0 0 {} {} eq 070702]} {
		>
			emit {ASCII cpio archive (SVR4 with CRC)}
		<
	}
	
	if {[S string 0 0 {} {} eq <ar>]} {
		>
			emit {System V Release 1 ar archive}
			mime application/x-archive
		<
	}
	
	if {[S string 0 0 {} {} eq !<arch>\ndebian]} {
		>
			if {[S string 8 0 {} {} eq debian-split]} {
				>
					emit {part of multipart Debian package}
					mime application/vnd.debian.binary-package
				<
			}
	
			if {[S string 8 0 {} {} eq debian-binary]} {
				>
					emit {Debian binary package}
					mime application/vnd.debian.binary-package
				<
			}
	
			if {[S string 8 0 {} {} ne debian]} {
				>
				<
			}
	
			if {[S string 68 0 {} {} > \0]} {
				>
					emit {(format %s)}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq !<arch>\n__________E]} {
		>
			emit {MIPS archive}
			if {[S string 20 0 {} {} eq U]} {
				>
					emit {with MIPS Ucode members}
				<
			}
	
			if {[S string 21 0 {} {} eq L]} {
				>
					emit {with MIPSEL members}
				<
			}
	
			if {[S string 21 0 {} {} eq B]} {
				>
					emit {with MIPSEB members}
				<
			}
	
			if {[S string 19 0 {} {} eq L]} {
				>
					emit {and an EL hash table}
				<
			}
	
			if {[S string 19 0 {} {} eq B]} {
				>
					emit {and an EB hash table}
				<
			}
	
			if {[S string 22 0 {} {} eq X]} {
				>
					emit {-- out of date}
				<
			}
	
			mime application/x-archive
		<
	}
	
	if {[S search 0 0 {} 1 eq -h-]} {
		>
			emit {Software Tools format archive text}
		<
	}
	
	if {[S string 0 0 {} {} eq !<arch>\n]} {
		>
			emit {current ar archive}
			if {[S string 8 0 {} {} eq __.SYMDEF]} {
				>
					emit {random library}
				<
			}
	
			if {[S string 68 0 {} {} eq __.SYMDEF\ SORTED]} {
				>
					emit {random library}
				<
			}
	
			mime application/x-archive
		<
	}
	
	if {[S string 0 0 {} {} eq !<thin>\n]} {
		>
			emit {thin archive with}
			switch [Nv belong 68 0 {} {}] {
				0 {
					>
						emit {no symbol entries}
					<
				}
				1 {
					>
						emit {%d symbol entry}
					<
				}
			}
	
			if {[N belong 68 0 0 {} {} > 1]} {
				>
					emit {%d symbol entries}
				<
			}
	
		<
	}
	
	switch [Nv lelong 0 0 & -2139029505] {
		538 {
			>
				emit {ARC archive data, uncompressed}
				mime application/x-arc
			<
		}
		794 {
			>
				emit {ARC archive data, packed}
				mime application/x-arc
			<
		}
		1050 {
			>
				emit {ARC archive data, squeezed}
				mime application/x-arc
			<
		}
		1562 {
			>
				emit {ARC archive data, crunched}
				mime application/x-arc
			<
		}
		2074 {
			>
				emit {ARC archive data, dynamic LZW}
				mime application/x-arc
			<
		}
		2330 {
			>
				emit {ARC archive data, squashed}
				mime application/x-arc
			<
		}
		2586 {
			>
				emit {PAK archive data}
				mime application/x-arc
			<
		}
		5146 {
			>
				emit {ARC+ archive data}
				mime application/x-arc
			<
		}
		18458 {
			>
				emit {HYP archive data}
				mime application/x-arc
			<
		}
	}
	
	if {[S string 0 0 {} {} eq \032archive]} {
		>
			emit {RISC OS archive (ArcFS format)}
		<
	}
	
	if {[S string 0 0 {} {} eq Archive\000]} {
		>
			emit {RISC OS archive (ArcFS format)}
		<
	}
	
	if {[S string 0 0 {} {} eq CRUSH]} {
		>
			emit {Crush archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq HLSQZ]} {
		>
			emit {Squeeze It archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq SQWEZ]} {
		>
			emit {SQWEZ archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq HPAK]} {
		>
			emit {HPack archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq \x91\x33HF]} {
		>
			emit {HAP archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq MDmd]} {
		>
			emit {MDCD archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq LIM\x1a]} {
		>
			emit {LIM archive data}
		<
	}
	
	if {[S string 3 0 {} {} eq LH5]} {
		>
			emit {SAR archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq \212\3SB\020\0]} {
		>
			emit {BSArc/BS2 archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq BSA\0]} {
		>
			emit {BSArc archive data}
			if {[N lelong 4 0 0 {} {} x {}]} {
				>
					emit {version %d}
				<
			}
	
		<
	}
	
	if {[S string 2 0 {} {} eq -ah]} {
		>
			emit {MAR archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq JRchive]} {
		>
			emit {JRC archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq DS\0]} {
		>
			emit {Quantum archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq PK\3\6]} {
		>
			emit {ReSOF archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq 7\4]} {
		>
			emit {QuArk archive data}
		<
	}
	
	if {[S string 14 0 {} {} eq YC]} {
		>
			emit {YAC archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq X1]} {
		>
			emit {X1 archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq XhDr]} {
		>
			emit {X1 archive data}
		<
	}
	
	if {[N belong 0 0 0 & -8192 == 1996431360]} {
		>
			emit {CDC Codec archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq \xad6\"]} {
		>
			emit {AMGC archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq N\xc3\xb5F\xc3\xa9lx\xc3\xa5]} {
		>
			emit {NuLIB archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq LEOLZW]} {
		>
			emit {PAKLeo archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq SChF]} {
		>
			emit {ChArc archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq PSA]} {
		>
			emit {PSA archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq DSIGDCC]} {
		>
			emit {CrossePAC archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq \x1f\x9f\x4a\x10\x0a]} {
		>
			emit {Freeze archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq \xc2\xa8MP\xc2\xa8]} {
		>
			emit {KBoom archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq \x76\xff]} {
		>
			emit {NSQ archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq Dirk\ Paehl]} {
		>
			emit {DPA archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq \0\6]} {
		>
			if {[S search 12 0 {} 261 eq DESIGN]} {
				>
				<
			}
	
			if {[D 12]} {
				>
					emit {TTComp archive, binary, 4K dictionary}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq ESP]} {
		>
			emit {ESP archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq \1ZPK\1]} {
		>
			emit {ZPack archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq \xbc\x40]} {
		>
			emit {Sky archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq UFA]} {
		>
			emit {UFA archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq -H2O]} {
		>
			emit {DRY archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq FOXSQZ]} {
		>
			emit {FoxSQZ archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq ,AR7]} {
		>
			emit {AR7 archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq PPMZ]} {
		>
			emit {PPMZ archive data}
		<
	}
	
	if {[S string 4 0 {} {} eq \x88\xf0\x27]} {
		>
			if {[S string 0 0 {} {} eq KWAJ]} {
				>
					emit {MS Compress archive data, KWAJ variant}
					if {[N uleshort 8 0 0 {} {} x {}]} {
						>
							emit {\b, %u method}
						<
					}
	
					if {[N uleshort 10 0 0 {} {} x {}]} {
						>
							emit {\b, 0x%x offset}
						<
					}
	
					if {[N uleshort 12 0 0 {} {} > 0]} {
						>
							emit {\b, 0x%x flags}
						<
					}
	
					if {[N uleshort 12 0 0 {} {} & 1]} {
						>
							if {[N ulelong 14 0 0 {} {} x {}]} {
								>
									emit {\b, original size: %u bytes}
								<
							}
	
						<
					}
	
					if {[N uleshort 12 0 0 {} {} & 8]} {
						>
							if {[N uleshort 12 0 0 {} {} ^ 1]} {
								>
									if {[N uleshort 12 0 0 {} {} ^ 2]} {
										>
											if {[N uleshort 12 0 0 {} {} ^ 4]} {
												>
													if {[N uleshort 12 0 0 {} {} ^ 16]} {
														>
															if {[S string 14 0 {} {} x {}]} {
																>
																	emit {\b, %-.8s}
																<
															}
	
														<
													}
	
													if {[N uleshort 12 0 0 {} {} & 16]} {
														>
															if {[S string 14 0 {} {} x {}]} {
																>
																	emit {\b, %-.8s}
																	if {[S string [R 1] 0 {} {} x {}]} {
																		>
																			emit {\b.%-.3s}
																		<
																	}
	
																<
															}
	
														<
													}
	
												<
											}
	
											if {[N uleshort 12 0 0 {} {} & 4]} {
												>
													if {[N uleshort 12 0 0 {} {} ^ 16]} {
														>
															if {[N uleshort [I 14 uleshort 0 + 0 0] 0 0 {} {} x {}]} {
																>
																	if {[S string [R 14] 0 {} {} x {}]} {
																		>
																			emit {\b, %-.8s}
																		<
																	}
	
																<
															}
	
														<
													}
	
													if {[N uleshort 12 0 0 {} {} & 16]} {
														>
															if {[N uleshort [I 14 uleshort 0 + 0 0] 0 0 {} {} x {}]} {
																>
																	if {[S string [R 14] 0 {} {} x {}]} {
																		>
																			emit {\b, %-.8s}
																			if {[S string [R 1] 0 {} {} x {}]} {
																				>
																					emit {\b.%-.3s}
																				<
																			}
	
																		<
																	}
	
																<
															}
	
														<
													}
	
												<
											}
	
										<
									}
	
									if {[N uleshort 12 0 0 {} {} & 2]} {
										>
											if {[N uleshort 12 0 0 {} {} ^ 4]} {
												>
													if {[N uleshort 12 0 0 {} {} ^ 16]} {
														>
															if {[S string 16 0 {} {} x {}]} {
																>
																	emit {\b, %-.8s}
																<
															}
	
														<
													}
	
													if {[N uleshort 12 0 0 {} {} & 16]} {
														>
															if {[S string 16 0 {} {} x {}]} {
																>
																	emit {\b, %-.8s}
																	if {[S string [R 1] 0 {} {} x {}]} {
																		>
																			emit {\b.%-.3s}
																		<
																	}
	
																<
															}
	
														<
													}
	
												<
											}
	
											if {[N uleshort 12 0 0 {} {} & 4]} {
												>
													if {[N uleshort 12 0 0 {} {} ^ 16]} {
														>
															if {[N uleshort [I 16 uleshort 0 + 0 0] 0 0 {} {} x {}]} {
																>
																	if {[S string [R 16] 0 {} {} x {}]} {
																		>
																			emit {\b, %-.8s}
																		<
																	}
	
																<
															}
	
														<
													}
	
													if {[N uleshort 12 0 0 {} {} & 16]} {
														>
															if {[N uleshort [I 16 uleshort 0 + 0 0] 0 0 {} {} x {}]} {
																>
																<
															}
	
															if {[S string [R 16] 0 {} {} x {}]} {
																>
																	emit %-.8s
																	if {[S string [R 1] 0 {} {} x {}]} {
																		>
																			emit {\b.%-.3s}
																		<
																	}
	
																<
															}
	
														<
													}
	
												<
											}
	
										<
									}
	
								<
							}
	
							if {[N uleshort 12 0 0 {} {} & 1]} {
								>
									if {[N uleshort 12 0 0 {} {} ^ 2]} {
										>
											if {[N uleshort 12 0 0 {} {} ^ 4]} {
												>
													if {[N uleshort 12 0 0 {} {} ^ 16]} {
														>
															if {[S string 18 0 {} {} x {}]} {
																>
																	emit {\b, %-.8s}
																<
															}
	
														<
													}
	
													if {[N uleshort 12 0 0 {} {} & 16]} {
														>
															if {[S string 18 0 {} {} x {}]} {
																>
																	emit {\b, %-.8s}
																	if {[S string [R 1] 0 {} {} x {}]} {
																		>
																			emit {\b.%-.3s}
																		<
																	}
	
																<
															}
	
														<
													}
	
												<
											}
	
											if {[N uleshort 12 0 0 {} {} & 4]} {
												>
													if {[N uleshort 12 0 0 {} {} ^ 16]} {
														>
															if {[N uleshort [I 18 uleshort 0 + 0 0] 0 0 {} {} x {}]} {
																>
																	if {[S string [R 18] 0 {} {} x {}]} {
																		>
																			emit {\b, %-.8s}
																		<
																	}
	
																<
															}
	
														<
													}
	
													if {[N uleshort 12 0 0 {} {} & 16]} {
														>
															if {[N uleshort [I 18 uleshort 0 + 0 0] 0 0 {} {} x {}]} {
																>
																	if {[S string [R 18] 0 {} {} x {}]} {
																		>
																			emit {\b, %-.8s}
																			if {[S string [R 1] 0 {} {} x {}]} {
																				>
																					emit {\b.%-.3s}
																				<
																			}
	
																		<
																	}
	
																<
															}
	
														<
													}
	
												<
											}
	
										<
									}
	
									if {[N uleshort 12 0 0 {} {} & 2]} {
										>
											if {[N uleshort 12 0 0 {} {} ^ 4]} {
												>
													if {[N uleshort 12 0 0 {} {} ^ 16]} {
														>
															if {[S string 20 0 {} {} x {}]} {
																>
																	emit {\b, %-.8s}
																<
															}
	
														<
													}
	
													if {[N uleshort 12 0 0 {} {} & 16]} {
														>
															if {[S string 20 0 {} {} x {}]} {
																>
																	emit {\b, %-.8s}
																	if {[S string [R 1] 0 {} {} x {}]} {
																		>
																			emit {\b.%-.3s}
																		<
																	}
	
																<
															}
	
														<
													}
	
												<
											}
	
											if {[N uleshort 12 0 0 {} {} & 4]} {
												>
													if {[N uleshort 12 0 0 {} {} ^ 16]} {
														>
															if {[N uleshort [I 20 uleshort 0 + 0 0] 0 0 {} {} x {}]} {
																>
																	if {[S string [R 20] 0 {} {} x {}]} {
																		>
																			emit {\b, %-.8s}
																		<
																	}
	
																<
															}
	
														<
													}
	
													if {[N uleshort 12 0 0 {} {} & 16]} {
														>
															if {[N uleshort [I 20 uleshort 0 + 0 0] 0 0 {} {} x {}]} {
																>
																	if {[S string [R 20] 0 {} {} x {}]} {
																		>
																			emit {\b, %-.8s}
																			if {[S string [R 1] 0 {} {} x {}]} {
																				>
																					emit {\b.%-.3s}
																				<
																			}
	
																		<
																	}
	
																<
															}
	
														<
													}
	
												<
											}
	
										<
									}
	
								<
							}
	
						<
					}
	
					mime application/x-ms-compress-kwaj
					ext ??_
				<
			}
	
			if {[S string 0 0 {} {} eq SZDD]} {
				>
					emit {MS Compress archive data, SZDD variant}
					if {[S string 9 0 {} {} > \0]} {
						>
							emit {\b, %-.1s is last character of original name}
						<
					}
	
					if {[S string 8 0 {} {} ne A]} {
						>
							emit {\b, %-.1s method}
						<
					}
	
					if {[N ulelong 10 0 0 {} {} > 0]} {
						>
							emit {\b, original size: %u bytes}
						<
					}
	
					mime application/x-ms-compress-szdd
					ext ??_
				<
			}
	
		<
	}
	
	if {[S string 3 0 {} {} eq \x88\xf0\x27]} {
		>
			if {[S string 0 0 {} {} eq SZ\x20]} {
				>
					emit {MS Compress archive data, QBasic variant}
					if {[N ulelong 8 0 0 {} {} > 0]} {
						>
							emit {\b, original size: %u bytes}
						<
					}
	
					mime application/x-ms-compress-sz
					ext {??$}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq MP3\x1a]} {
		>
			emit {MP3-Archiver archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq OZ\xc3\x9d]} {
		>
			emit {ZET archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq \x65\x5d\x13\x8c\x08\x01\x03\x00]} {
		>
			emit {TSComp archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq gW\4\1]} {
		>
			emit {ARQ archive data}
		<
	}
	
	if {[S string 3 0 {} {} eq OctSqu]} {
		>
			emit {Squash archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq \5\1\1\0]} {
		>
			emit {Terse archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq \x01\x08\x0b\x08\xef\x00\x9e\x32\x30\x36\x31]} {
		>
			emit {PUCrunch archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq UHA]} {
		>
			emit {UHarc archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq \2AB]} {
		>
			emit {ABComp archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq \3AB2]} {
		>
			emit {ABComp archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq CO\0]} {
		>
			emit {CMP archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq \x93\xb9\x06]} {
		>
			emit {Splint archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq \x13\x5d\x65\x8c]} {
		>
			emit {InstallShield Z archive Data}
		<
	}
	
	if {[S string 1 0 {} {} eq GTH]} {
		>
			emit {Gather archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq BOA]} {
		>
			emit {BOA archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq ULEB\xa]} {
		>
			emit {RAX archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq ULEB\0]} {
		>
			emit {Xtreme archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq @\xc3\xa2\1\0]} {
		>
			emit {Pack Magic archive data}
		<
	}
	
	if {[N belong 0 0 0 & -16777217 == 436421733]} {
		>
			emit {BTS archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq Ora\ ]} {
		>
			emit {ELI 5750 archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq \x1aFC\x1a]} {
		>
			emit {QFC archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq \x1aQF\x1a]} {
		>
			emit {QFC archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq RNC]} {
		>
			emit {PRO-PACK archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq 777]} {
		>
			emit {777 archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq sTaC]} {
		>
			emit {LZS221 archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq HPA]} {
		>
			emit {HPA archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq LG]} {
		>
			emit {Arhangel archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq 0123456789012345BZh]} {
		>
			emit {EXP1 archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq IMP\xa]} {
		>
			emit {IMP archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq \x00\x9E\x6E\x72\x76\xFF]} {
		>
			emit {NRV archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq \x73\xb2\x90\xf4]} {
		>
			emit {Squish archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq PHILIPP]} {
		>
			emit {Par archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq PAR]} {
		>
			emit {Par archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq UB]} {
		>
			emit {HIT archive data}
		<
	}
	
	if {[N belong 0 0 0 & -4096 == 1396846592]} {
		>
			emit {SBX archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq NSK]} {
		>
			emit {NaShrink archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq \#\ CAR\ archive\ header]} {
		>
			emit {SAPCAR archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq CAR\ 2.00RG]} {
		>
			emit {SAPCAR archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq DST]} {
		>
			emit {Disintegrator archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq ASD]} {
		>
			emit {ASD archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq ISc(]} {
		>
			emit {InstallShield CAB}
		<
	}
	
	if {[S string 0 0 {} {} eq T4\x1a]} {
		>
			emit {TOP4 archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq BH\5\7]} {
		>
			emit {BlakHole archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq BIX0]} {
		>
			emit {BIX archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq ChfLZ]} {
		>
			emit {ChiefLZA archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq Blink]} {
		>
			emit {Blink archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq \xda\xfa]} {
		>
			emit {Logitech Compress archive data}
		<
	}
	
	if {[S string 1 0 {} {} eq (C)\ STEPANYUK]} {
		>
			emit {ARS-Sfx archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq AKT32]} {
		>
			emit {AKT32 archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq AKT]} {
		>
			emit {AKT archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq MSTSM]} {
		>
			emit {NPack archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq \0\x50\0\x14]} {
		>
			emit {PFT archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq SEM]} {
		>
			emit {SemOne archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq \x8f\xaf\xac\x84]} {
		>
			emit {PPMD archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq FIZ]} {
		>
			emit {FIZ archive data}
		<
	}
	
	if {[N belong 0 0 0 & -3856 == 1297285120]} {
		>
			emit {MSXiE archive data}
		<
	}
	
	switch [Nv belong 0 0 & -16] {
		0 {
			>
				if {[N beshort 4 0 0 {} {} == 2569]} {
					>
						if {[S string 6 0 {} {} eq OSMHeader]} {
							>
								emit {OpenStreetMap Protocolbuffer Binary Format}
							<
						}
	
					<
				}
	
			<
		}
		1612316672 {
			>
				emit {Atari ST M68K contiguous executable}
				if {[N belong 2 0 0 {} {} x {}]} {
					>
						emit (txt=%d,
					<
				}
	
				if {[N belong 6 0 0 {} {} x {}]} {
					>
						emit dat=%d,
					<
				}
	
				if {[N belong 10 0 0 {} {} x {}]} {
					>
						emit bss=%d,
					<
				}
	
				if {[N belong 14 0 0 {} {} x {}]} {
					>
						emit sym=%d)
					<
				}
	
			<
		}
		1612382208 {
			>
				emit {Atari ST M68K non-contig executable}
				if {[N belong 2 0 0 {} {} x {}]} {
					>
						emit (txt=%d,
					<
				}
	
				if {[N belong 6 0 0 {} {} x {}]} {
					>
						emit dat=%d,
					<
				}
	
				if {[N belong 10 0 0 {} {} x {}]} {
					>
						emit bss=%d,
					<
				}
	
				if {[N belong 14 0 0 {} {} x {}]} {
					>
						emit sym=%d)
					<
				}
	
			<
		}
		2038050864 {
			>
				emit {DeepFreezer archive data}
			<
		}
	}
	
	if {[S string 0 0 {} {} eq <DC-]} {
		>
			emit {DC archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq \4TPAC\3]} {
		>
			emit {TPac archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq Ai\1\1\0]} {
		>
			emit {Ai archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq Ai\1\0\0]} {
		>
			emit {Ai archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq Ai\2\0]} {
		>
			emit {Ai32 archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq Ai\2\1]} {
		>
			emit {Ai32 archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq SBC]} {
		>
			emit {SBC archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq YBS]} {
		>
			emit {Ybs archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq \x9e\0\0]} {
		>
			emit {DitPack archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq DMS!]} {
		>
			emit {DMS archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq \x8f\xaf\xac\x8c]} {
		>
			emit {EPC archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq VS\x1a]} {
		>
			emit {VSARC archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq PDZ]} {
		>
			emit {PDZ archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq rdqx]} {
		>
			emit {ReDuq archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq GCAX]} {
		>
			emit {GCA archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq pN]} {
		>
			emit {PPMN archive data}
		<
	}
	
	if {[S string 3 0 {} {} eq WINIMAGE]} {
		>
			emit {WinImage archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq CMP0CMP]} {
		>
			emit {Compressia archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq UHB]} {
		>
			emit {UHBC archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq \x61\x5C\x04\x05]} {
		>
			emit {WinHKI archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq WWP]} {
		>
			emit {WWPack archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq \xffBSG]} {
		>
			emit {BSN archive data}
		<
	}
	
	if {[S string 1 0 {} {} eq \xffBSG]} {
		>
			emit {BSN archive data}
		<
	}
	
	if {[S string 3 0 {} {} eq \xffBSG]} {
		>
			emit {BSN archive data}
		<
	}
	
	if {[S string 1 0 {} {} eq \0\xae\2]} {
		>
			emit {BSN archive data}
		<
	}
	
	if {[S string 1 0 {} {} eq \0\xae\3]} {
		>
			emit {BSN archive data}
		<
	}
	
	if {[S string 1 0 {} {} eq \0\xae\7]} {
		>
			emit {BSN archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq \x33\x18]} {
		>
			emit {AIN archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq \x33\x17]} {
		>
			emit {AIN archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq SZ\x0a\4]} {
		>
			emit {SZip archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq jm]} {
		>
			if {[S string 2 0 {} {} eq \x2\x4]} {
				>
					emit {Xpack DiskImage archive data}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq xpa]} {
		>
			emit XPA
			if {[S string 0 0 {} {} eq xpa\0\1]} {
				>
					emit {\b32 archive data}
				<
			}
	
			if {[N ubeshort 3 0 0 {} {} != 1]} {
				>
					emit {\bck archive data}
				<
			}
	
			ext xpa
		<
	}
	
	if {[S string 0 0 {} {} eq \xcd\ jm]} {
		>
			emit {Xpack single archive data}
			ext xpa
		<
	}
	
	if {[S string 0 0 {} {} eq DZ]} {
		>
			if {[N byte 2 0 0 {} {} < 4]} {
				>
					emit {Dzip archive data}
					if {[N byte 2 0 0 {} {} x {}]} {
						>
							emit {\b, version %i}
						<
					}
	
					if {[N byte 3 0 0 {} {} x {}]} {
						>
							emit {\b.%i}
						<
					}
	
					if {[N ulelong 4 0 0 {} {} x {}]} {
						>
							emit {\b, offset 0x%x}
						<
					}
	
					if {[N ulelong 8 0 0 {} {} x {}]} {
						>
							emit {\b, %u files}
						<
					}
	
					mime application/x-dzip
					ext dz
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq ZZ\ \0\0]} {
		>
			emit {ZZip archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq ZZ0]} {
		>
			emit {ZZip archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq \xaa\x40\x5f\x77\x1f\xe5\x82\x0d]} {
		>
			emit {PAQ archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq PAQ]} {
		>
			emit {PAQ archive data}
			if {[N byte 3 0 0 & -16 == 48]} {
				>
					if {[N byte 3 0 0 {} {} x {}]} {
						>
							emit (v%c)
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 14 0 {} {} eq \x1aJar\x1b]} {
		>
			emit {JAR (ARJ Software, Inc.) archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq JARCS]} {
		>
			emit {JAR (ARJ Software, Inc.) archive data}
		<
	}
	
	switch [Nv leshort 2 0 {} {}] {
		-5536 {
			>
				emit {ARJ archive data}
			<
		}
		14336 {
			>
				emit {BS image,}
				if {[N leshort 6 0 0 {} {} x {}]} {
					>
						emit {Version %d,}
					<
				}
	
				if {[N leshort 4 0 0 {} {} x {}]} {
					>
						emit {Quantization %d,}
					<
				}
	
				if {[N leshort 0 0 0 {} {} x {}]} {
					>
						emit {(Decompresses to %d words)}
					<
				}
	
			<
		}
	}
	
	if {[N belong 0 0 0 & -65284 == 1212219392]} {
		>
			emit {HA archive data}
			if {[N leshort 2 0 0 {} {} == 1]} {
				>
					emit {1 file,}
				<
			}
	
			if {[N leshort 2 0 0 {} {} > 1]} {
				>
					emit {%u files,}
				<
			}
	
			switch [Nv byte 4 0 & 15] {
				0 {
					>
						emit {first is type CPY}
					<
				}
				1 {
					>
						emit {first is type ASC}
					<
				}
				2 {
					>
						emit {first is type HSC}
					<
				}
				14 {
					>
						emit {first is type DIR}
					<
				}
				15 {
					>
						emit {first is type SPECIAL}
					<
				}
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq HPAK]} {
		>
			emit {HPACK archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq \351,\001JAM\ ]} {
		>
			emit {JAM archive,}
			if {[S string 7 0 {} {} > \0]} {
				>
					emit {version %.4s}
				<
			}
	
			if {[N byte 38 0 0 {} {} == 39]} {
				>
					emit -
					if {[S string 43 0 {} {} > \0]} {
						>
							emit {label %.11s,}
						<
					}
	
					if {[N lelong 39 0 0 {} {} x {}]} {
						>
							emit {serial %08x,}
						<
					}
	
					if {[S string 54 0 {} {} > \0]} {
						>
							emit {fstype %.8s}
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 2 0 {} {} eq -lh0-]} {
		>
			U 16 lharc-file 0
	
		<
	}
	
	if {[S string 2 0 {} {} eq -lh1-]} {
		>
			U 16 lharc-file 0
	
		<
	}
	
	if {[S string 2 0 {} {} eq -lz2-]} {
		>
			U 16 lharc-file 0
	
		<
	}
	
	if {[S string 2 0 {} {} eq -lz3-]} {
		>
			U 16 lharc-file 0
	
		<
	}
	
	if {[S string 2 0 {} {} eq -lz4-]} {
		>
			U 16 lharc-file 0
	
		<
	}
	
	if {[S string 2 0 {} {} eq -lz5-]} {
		>
			U 16 lharc-file 0
	
		<
	}
	
	if {[S string 2 0 {} {} eq -lz7-]} {
		>
			U 16 lharc-file 0
	
		<
	}
	
	if {[S string 2 0 {} {} eq -lz8-]} {
		>
			U 16 lharc-file 0
	
		<
	}
	
	if {[S string 2 0 {} {} eq -lzs-]} {
		>
			U 16 lharc-file 0
	
		<
	}
	
	if {[S string 2 0 {} {} eq -lhd-]} {
		>
			U 16 lharc-file 0
	
		<
	}
	
	if {[S string 2 0 {} {} eq -lh2-]} {
		>
			U 16 lharc-file 0
	
		<
	}
	
	if {[S string 2 0 {} {} eq -lh3-]} {
		>
			U 16 lharc-file 0
	
		<
	}
	
	if {[S string 2 0 {} {} eq -lh4-]} {
		>
			U 16 lharc-file 0
	
		<
	}
	
	if {[S string 2 0 {} {} eq -lh5-]} {
		>
			U 16 lharc-file 0
	
		<
	}
	
	if {[S string 2 0 {} {} eq -lh6-]} {
		>
			U 16 lharc-file 0
	
		<
	}
	
	if {[S string 2 0 {} {} eq -lh7-]} {
		>
			U 16 lharc-file 0
	
		<
	}
	
	if {[S string 2 0 {} {} eq -lh8-]} {
		>
			U 16 lharc-file 0
	
		<
	}
	
	if {[S string 2 0 {} {} eq -lh9-]} {
		>
			U 16 lharc-file 0
	
		<
	}
	
	if {[S string 2 0 {} {} eq -lha-]} {
		>
			U 16 lharc-file 0
	
		<
	}
	
	if {[S string 2 0 {} {} eq -lhb-]} {
		>
			U 16 lharc-file 0
	
		<
	}
	
	if {[S string 2 0 {} {} eq -lhc-]} {
		>
			U 16 lharc-file 0
	
		<
	}
	
	if {[S string 2 0 {} {} eq -lhe-]} {
		>
			U 16 lharc-file 0
	
		<
	}
	
	if {[S string 2 0 {} {} eq -lhx-]} {
		>
			U 16 lharc-file 0
	
		<
	}
	
	if {[S string 2 0 {} {} eq -lZ]} {
		>
			emit {PUT archive data}
		<
	}
	
	if {[S string 2 0 {} {} eq -sw1-]} {
		>
			emit {Swag archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq Rar!\x1a\7\0]} {
		>
			emit {RAR archive data}
			switch [Nv byte [I 12 ulelong 0 + 0 9] 0 {} {}] {
				116 {
					>
						U 16 rar-file-header [I 12 ulelong 0 + 0 7]
	
					<
				}
				122 {
					>
						U 16 rar-file-header [I 12 ulelong 0 + 0 7]
	
					<
				}
			}
	
			if {[N byte 9 0 0 {} {} == 115]} {
				>
					U 16 rar-archive-header 7
	
				<
			}
	
			mime application/x-rar
			ext rar/cbr
		<
	}
	
	if {[S string 0 0 {} {} eq Rar!\x1a\7\1\0]} {
		>
			emit {RAR archive data, v5}
			mime application/x-rar
			ext rar
		<
	}
	
	if {[S string 0 0 {} {} eq RE\x7e\x5e]} {
		>
			emit {RAR archive data (<v1.5)}
			mime application/x-rar
			ext rar/cbr
		<
	}
	
	if {[S string 0 0 {} {} eq SQSH]} {
		>
			emit {squished archive data (Acorn RISCOS)}
		<
	}
	
	if {[S string 0 0 {} {} eq UC2\x1a]} {
		>
			emit {UC2 archive data}
		<
	}
	
	if {[S string 0 0 {} {} eq PK\x07\x08PK\x03\x04]} {
		>
			emit {Zip multi-volume archive data, at least PKZIP v2.50 to extract}
			mime application/zip
			ext zip/cbz
		<
	}
	
	if {[S string 0 0 {} {} eq PK\005\006]} {
		>
			emit {Zip archive data (empty)}
			mime application/zip
			ext zip/cbz
		<
	}
	
	if {[S string 0 0 {} {} eq PK\003\004]} {
		>
			if {[S string 26 0 {} {} eq \x8\0\0\0mimetypeapplication/]} {
				>
					if {[S string 50 0 {} {} eq vnd.kde.]} {
						>
							emit {KOffice (>=1.2)}
							if {[S string 58 0 {} {} eq karbon]} {
								>
									emit {Karbon document}
								<
							}
	
							if {[S string 58 0 {} {} eq kchart]} {
								>
									emit {KChart document}
								<
							}
	
							if {[S string 58 0 {} {} eq kformula]} {
								>
									emit {KFormula document}
								<
							}
	
							if {[S string 58 0 {} {} eq kivio]} {
								>
									emit {Kivio document}
								<
							}
	
							if {[S string 58 0 {} {} eq kontour]} {
								>
									emit {Kontour document}
								<
							}
	
							if {[S string 58 0 {} {} eq kpresenter]} {
								>
									emit {KPresenter document}
								<
							}
	
							if {[S string 58 0 {} {} eq kspread]} {
								>
									emit {KSpread document}
								<
							}
	
							if {[S string 58 0 {} {} eq kword]} {
								>
									emit {KWord document}
								<
							}
	
						<
					}
	
					if {[S string 50 0 {} {} eq vnd.sun.xml.]} {
						>
							emit {OpenOffice.org 1.x}
							if {[S string 62 0 {} {} eq writer]} {
								>
									emit Writer
									if {[N byte 68 0 0 {} {} != 46]} {
										>
											emit document
										<
									}
	
									if {[S string 68 0 {} {} eq .template]} {
										>
											emit template
										<
									}
	
									if {[S string 68 0 {} {} eq .global]} {
										>
											emit {global document}
										<
									}
	
								<
							}
	
							if {[S string 62 0 {} {} eq calc]} {
								>
									emit Calc
									if {[N byte 66 0 0 {} {} != 46]} {
										>
											emit spreadsheet
										<
									}
	
									if {[S string 66 0 {} {} eq .template]} {
										>
											emit template
										<
									}
	
								<
							}
	
							if {[S string 62 0 {} {} eq draw]} {
								>
									emit Draw
									if {[N byte 66 0 0 {} {} != 46]} {
										>
											emit document
										<
									}
	
									if {[S string 66 0 {} {} eq .template]} {
										>
											emit template
										<
									}
	
								<
							}
	
							if {[S string 62 0 {} {} eq impress]} {
								>
									emit Impress
									if {[N byte 69 0 0 {} {} != 46]} {
										>
											emit presentation
										<
									}
	
									if {[S string 69 0 {} {} eq .template]} {
										>
											emit template
										<
									}
	
								<
							}
	
							if {[S string 62 0 {} {} eq math]} {
								>
									emit {Math document}
								<
							}
	
							if {[S string 62 0 {} {} eq base]} {
								>
									emit {Database file}
								<
							}
	
						<
					}
	
					if {[S string 50 0 {} {} eq vnd.oasis.opendocument.]} {
						>
							emit OpenDocument
							if {[S string 73 0 {} {} eq text]} {
								>
									if {[N byte 77 0 0 {} {} != 45]} {
										>
											emit Text
											mime application/vnd.oasis.opendocument.text
										<
									}
	
									if {[S string 77 0 {} {} eq -template]} {
										>
											emit {Text Template}
											mime application/vnd.oasis.opendocument.text-template
										<
									}
	
									if {[S string 77 0 {} {} eq -web]} {
										>
											emit {HTML Document Template}
											mime application/vnd.oasis.opendocument.text-web
										<
									}
	
									if {[S string 77 0 {} {} eq -master]} {
										>
											emit {Master Document}
											mime application/vnd.oasis.opendocument.text-master
										<
									}
	
								<
							}
	
							if {[S string 73 0 {} {} eq graphics]} {
								>
									if {[N byte 81 0 0 {} {} != 45]} {
										>
											emit Drawing
											mime application/vnd.oasis.opendocument.graphics
										<
									}
	
									if {[S string 81 0 {} {} eq -template]} {
										>
											emit Template
											mime application/vnd.oasis.opendocument.graphics-template
										<
									}
	
								<
							}
	
							if {[S string 73 0 {} {} eq presentation]} {
								>
									if {[N byte 85 0 0 {} {} != 45]} {
										>
											emit Presentation
											mime application/vnd.oasis.opendocument.presentation
										<
									}
	
									if {[S string 85 0 {} {} eq -template]} {
										>
											emit Template
											mime application/vnd.oasis.opendocument.presentation-template
										<
									}
	
								<
							}
	
							if {[S string 73 0 {} {} eq spreadsheet]} {
								>
									if {[N byte 84 0 0 {} {} != 45]} {
										>
											emit Spreadsheet
											mime application/vnd.oasis.opendocument.spreadsheet
										<
									}
	
									if {[S string 84 0 {} {} eq -template]} {
										>
											emit Template
											mime application/vnd.oasis.opendocument.spreadsheet-template
										<
									}
	
								<
							}
	
							if {[S string 73 0 {} {} eq chart]} {
								>
									if {[N byte 78 0 0 {} {} != 45]} {
										>
											emit Chart
											mime application/vnd.oasis.opendocument.chart
										<
									}
	
									if {[S string 78 0 {} {} eq -template]} {
										>
											emit Template
											mime application/vnd.oasis.opendocument.chart-template
										<
									}
	
								<
							}
	
							if {[S string 73 0 {} {} eq formula]} {
								>
									if {[N byte 80 0 0 {} {} != 45]} {
										>
											emit Formula
											mime application/vnd.oasis.opendocument.formula
										<
									}
	
									if {[S string 80 0 {} {} eq -template]} {
										>
											emit Template
											mime application/vnd.oasis.opendocument.formula-template
										<
									}
	
								<
							}
	
							if {[S string 73 0 {} {} eq database]} {
								>
									emit Database
									mime application/vnd.oasis.opendocument.database
								<
							}
	
							if {[S string 73 0 {} {} eq base]} {
								>
									emit Database
									mime application/vnd.oasis.opendocument.base
								<
							}
	
							if {[S string 73 0 {} {} eq image]} {
								>
									if {[N byte 78 0 0 {} {} != 45]} {
										>
											emit Image
											mime application/vnd.oasis.opendocument.image
										<
									}
	
									if {[S string 78 0 {} {} eq -template]} {
										>
											emit Template
											mime application/vnd.oasis.opendocument.image-template
										<
									}
	
								<
							}
	
						<
					}
	
					if {[S string 50 0 {} {} eq epub+zip]} {
						>
							emit {EPUB document}
							mime application/epub+zip
						<
					}
	
					if {[S string 50 0 {} {} ne epub+zip]} {
						>
							if {[S string 50 0 {} {} ne vnd.oasis.opendocument.]} {
								>
									if {[S string 50 0 {} {} ne vnd.sun.xml.]} {
										>
											if {[S string 50 0 {} {} ne vnd.kde.]} {
												>
													if {[S regex 38 0 {} {} eq \[!-OQ-~\]+]} {
														>
															emit {Zip data (MIME type "%s"?)}
															mime application/zip
														<
													}
	
												<
											}
	
										<
									}
	
								<
							}
	
						<
					}
	
				<
			}
	
			if {[S string 26 0 {} {} eq \x8\0\0\0mimetype]} {
				>
					if {[S string 38 0 {} {} ne application/]} {
						>
							if {[S regex 38 0 {} {} eq \[!-OQ-~\]+]} {
								>
									emit {Zip data (MIME type "%s"?)}
									mime application/zip
								<
							}
	
						<
					}
	
				<
			}
	
			if {[N leshort [I 26 uleshort 0 + 0 30] 0 0 {} {} == -13570]} {
				>
					emit {Java archive data (JAR)}
					mime application/java-archive
				<
			}
	
			if {[N leshort [I 26 uleshort 0 + 0 30] 0 0 {} {} != -13570]} {
				>
					if {[S string 26 0 {} {} ne \x8\0\0\0mimetype]} {
						>
							if {[S string 30 0 {} {} eq Payload/]} {
								>
									if {[S search 38 0 {} 64 eq .app/]} {
										>
											emit {iOS App}
											mime application/x-ios-app
										<
									}
	
								<
							}
	
						<
					}
	
				<
			}
	
			if {[N leshort [I 26 uleshort 0 + 0 30] 0 0 {} {} != -13570]} {
				>
					if {[S string 26 0 {} {} ne \x8\0\0\0mimetype]} {
						>
							emit {Zip archive data}
							if {[N beshort 4 0 0 {} {} x {}]} {
								>
									emit {\b, at least}
								<
							}
	
							U 16 zipversion 4
	
							if {[N beshort 4 0 0 {} {} x {}]} {
								>
									emit {to extract}
								<
							}
	
							if {[S string 353 0 {} {} eq WINZIP]} {
								>
									emit {\b, WinZIP self-extracting}
								<
							}
	
							mime application/zip
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq VCLMTF]} {
		>
			emit {StarView MetaFile}
			if {[N beshort 6 0 0 {} {} x {}]} {
				>
					emit {\b, version %d}
				<
			}
	
			if {[N belong 8 0 0 {} {} x {}]} {
				>
					emit {\b, size %d}
				<
			}
	
		<
	}
	
	if {[N lelong 20 0 0 {} {} == -37443620]} {
		>
			emit {Zoo archive data}
			if {[N byte 4 0 0 {} {} > 48]} {
				>
					emit {\b, v%c.}
					if {[N byte 6 0 0 {} {} > 47]} {
						>
							emit {\b%c}
							if {[N byte 7 0 0 {} {} > 47]} {
								>
									emit {\b%c}
								<
							}
	
						<
					}
	
				<
			}
	
			if {[N byte 32 0 0 {} {} > 0]} {
				>
					emit {\b, modify: v%d}
					if {[N byte 33 0 0 {} {} x {}]} {
						>
							emit {\b.%d+}
						<
					}
	
				<
			}
	
			if {[N lelong 42 0 0 {} {} == -37443620]} {
				>
					emit {\b,}
					if {[N byte 70 0 0 {} {} > 0]} {
						>
							emit {extract: v%d}
							if {[N byte 71 0 0 {} {} x {}]} {
								>
									emit {\b.%d+}
								<
							}
	
						<
					}
	
				<
			}
	
			mime application/x-zoo
		<
	}
	
	if {[S string 10 0 {} {} eq \#\ This\ is\ a\ shell\ archive]} {
		>
			emit {shell archive text}
			mime application/octet-stream
		<
	}
	
	if {[S string 0 0 {} {} eq \0\ \ \ \ \ \ \ \ \ \ \ \0\0]} {
		>
			emit {LBR archive data}
		<
	}
	
	if {[S string 2 0 {} {} eq -pm0-]} {
		>
			U 16 lharc-file 0
	
		<
	}
	
	if {[S string 2 0 {} {} eq -pm1-]} {
		>
			U 16 lharc-file 0
	
		<
	}
	
	if {[S string 2 0 {} {} eq -pm2-]} {
		>
			U 16 lharc-file 0
	
		<
	}
	
	if {[S string 2 0 {} {} eq -pms-]} {
		>
			emit {PMarc SFX archive (CP/M, DOS)}
			ext com
		<
	}
	
	if {[S string 5 0 {} {} eq -pc1-]} {
		>
			emit {PopCom compressed executable (CP/M)}
		<
	}
	
	if {[S string 4 0 {} {} eq gtktalog\ ]} {
		>
			emit {GTKtalog catalog data,}
			if {[S string 13 0 {} {} eq 3]} {
				>
					emit {version 3}
					if {[N beshort 14 0 0 {} {} == 26490]} {
						>
							emit (gzipped)
						<
					}
	
					if {[N beshort 14 0 0 {} {} != 26490]} {
						>
							emit {(not gzipped)}
						<
					}
	
				<
			}
	
			if {[S string 13 0 {} {} > 3]} {
				>
					emit {version %s}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq PAR\0]} {
		>
			emit {PARity archive data}
			if {[N leshort 48 0 0 {} {} == 0]} {
				>
					emit {- Index file}
				<
			}
	
			if {[N leshort 48 0 0 {} {} > 0]} {
				>
					emit {- file number %d}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq d8:announce]} {
		>
			emit {BitTorrent file}
			mime application/x-bittorrent
		<
	}
	
	if {[S string 0 0 {} {} eq d13:announce-list]} {
		>
			emit {BitTorrent file}
			mime application/x-bittorrent
		<
	}
	
	if {[S string 0 0 {} {} eq PK00PK\003\004]} {
		>
			emit {Zip archive data}
			mime application/zip
			ext zip/cbz
		<
	}
	
	if {[S string 7 0 {} {} eq **ACE**]} {
		>
			emit {ACE archive data}
			if {[N byte 15 0 0 {} {} > 0]} {
				>
					emit {version %d}
				<
			}
	
			switch [Nv byte 16 0 {} {}] {
				0 {
					>
						emit {\b, from MS-DOS}
					<
				}
				1 {
					>
						emit {\b, from OS/2}
					<
				}
				2 {
					>
						emit {\b, from Win/32}
					<
				}
				3 {
					>
						emit {\b, from Unix}
					<
				}
				4 {
					>
						emit {\b, from MacOS}
					<
				}
				5 {
					>
						emit {\b, from WinNT}
					<
				}
				6 {
					>
						emit {\b, from Primos}
					<
				}
				7 {
					>
						emit {\b, from AppleGS}
					<
				}
				8 {
					>
						emit {\b, from Atari}
					<
				}
				9 {
					>
						emit {\b, from Vax/VMS}
					<
				}
				10 {
					>
						emit {\b, from Amiga}
					<
				}
				11 {
					>
						emit {\b, from Next}
					<
				}
			}
	
			if {[N byte 14 0 0 {} {} x {}]} {
				>
					emit {\b, version %d to extract}
				<
			}
	
			if {[N leshort 5 0 0 {} {} & 128]} {
				>
					emit {\b, multiple volumes,}
					if {[N byte 17 0 0 {} {} x {}]} {
						>
							emit {\b (part %d),}
						<
					}
	
				<
			}
	
			if {[N leshort 5 0 0 {} {} & 2]} {
				>
					emit {\b, contains comment}
				<
			}
	
			if {[N leshort 5 0 0 {} {} & 512]} {
				>
					emit {\b, sfx}
				<
			}
	
			if {[N leshort 5 0 0 {} {} & 1024]} {
				>
					emit {\b, small dictionary}
				<
			}
	
			if {[N leshort 5 0 0 {} {} & 2048]} {
				>
					emit {\b, multi-volume}
				<
			}
	
			if {[N leshort 5 0 0 {} {} & 4096]} {
				>
					emit {\b, contains AV-String}
					if {[S string 30 0 {} {} eq \x16*UNREGISTERED\x20VERSION*]} {
						>
							emit (unregistered)
						<
					}
	
				<
			}
	
			if {[N leshort 5 0 0 {} {} & 8192]} {
				>
					emit {\b, with recovery record}
				<
			}
	
			if {[N leshort 5 0 0 {} {} & 16384]} {
				>
					emit {\b, locked}
				<
			}
	
			if {[N leshort 5 0 0 {} {} & -32768]} {
				>
					emit {\b, solid}
				<
			}
	
		<
	}
	
	if {[S string 26 0 {} {} eq sfArk]} {
		>
			emit {sfArk compressed Soundfont}
			if {[S string 21 0 {} {} eq 2]} {
				>
					if {[S string 1 0 {} {} > \0]} {
						>
							emit {Version %s}
						<
					}
	
					if {[S string 42 0 {} {} > \0]} {
						>
							emit {: %s}
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq Packed\ File\ ]} {
		>
			emit {Personal NetWare Packed File}
			if {[S string 12 0 {} {} x {}]} {
				>
					emit {\b, was "%.12s"}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq RZIP]} {
		>
			emit {rzip compressed data}
			if {[N byte 4 0 0 {} {} x {}]} {
				>
					emit {- version %d}
				<
			}
	
			if {[N byte 5 0 0 {} {} x {}]} {
				>
					emit {\b.%d}
				<
			}
	
			if {[N belong 6 0 0 {} {} x {}]} {
				>
					emit {(%d bytes)}
				<
			}
	
		<
	}
	
	if {[N lelong 8 0 0 {} {} == 268436505]} {
		>
			emit {Symbian installation file}
			switch [Nv lelong 4 0 {} {}] {
				268435565 {
					>
						emit {(EPOC release 3/4/5)}
					<
				}
				268450322 {
					>
						emit {(EPOC release 6)}
					<
				}
			}
	
			mime application/vnd.symbian.install
		<
	}
	
	if {[S string 0 0 {} {} eq MPQ\032]} {
		>
			emit {MoPaQ (MPQ) archive}
		<
	}
	
	if {[S string 0 0 {} {} eq KGB_arch]} {
		>
			emit {KGB Archiver file}
			if {[S string 10 0 {} {} x {}]} {
				>
					emit {with compression level %.1s}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq xar!]} {
		>
			emit {xar archive}
			if {[N beshort 6 0 0 {} {} x {}]} {
				>
					emit {version %d,}
				<
			}
	
			switch [Nv belong 24 0 {} {}] {
				0 {
					>
						emit {no checksum}
					<
				}
				1 {
					>
						emit {SHA-1 checksum}
					<
				}
				2 {
					>
						emit {MD5 checksum}
					<
				}
			}
	
			mime application/x-xar
		<
	}
	
	if {[S string 0 0 {} {} eq PAR2]} {
		>
			emit {Parity Archive Volume Set}
		<
	}
	
	if {[S string 12 0 {} {} eq BB02]} {
		>
			emit {Bacula volume}
			if {[N bedate 20 0 0 {} {} x {}]} {
				>
					emit {\b, started %s}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq zPQ]} {
		>
			emit {ZPAQ stream}
			if {[N byte 3 0 0 {} {} x {}]} {
				>
					emit {\b, level %d}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq 7kSt]} {
		>
			emit {ZPAQ file}
		<
	}
	
	if {[S string 0 0 {} {} eq L\0R\0F\0\0\0]} {
		>
			emit {BBeB ebook data, unencrypted}
			if {[N beshort 8 0 0 {} {} x {}]} {
				>
					emit {\b, version %d}
				<
			}
	
			switch [Nv byte 36 0 {} {}] {
				1 {
					>
						emit {\b, front-to-back}
					<
				}
				16 {
					>
						emit {\b, back-to-front}
					<
				}
			}
	
			if {[N beshort 42 0 0 {} {} x {}]} {
				>
					emit {\b, (%dx,}
				<
			}
	
			if {[N beshort 44 0 0 {} {} x {}]} {
				>
					emit %d)
				<
			}
	
		<
	}
	
	if {[N ubelong 0 0 0 & 4294965232 == 4277076224]} {
		>
			emit {Norton GHost image}
			switch [Nv ubyte 2 0 & 8] {
				0 {
					>
						emit {\b, first file}
					<
					>
						if {[N ubequad 12 0 0 {} {} != 0]} {
							>
								emit {\b, password protected}
							<
						}
	
						if {[N ubyte 44 0 0 {} {} != 1]} {
							>
								if {[N ubyte 10 0 0 {} {} == 1]} {
									>
										emit {\b, sector copy}
									<
								}
	
								if {[N ubyte 43 0 0 {} {} == 1]} {
									>
										emit {\b, boot track}
									<
								}
	
							<
						}
	
						if {[N ubyte 44 0 0 {} {} == 1]} {
							>
								emit {\b, disc sector copy}
							<
						}
	
						if {[S string 255 0 {} {} > \0]} {
							>
								emit {"%-.254s"}
							<
						}
	
					<
				}
				8 {
					>
						emit {\b, split file}
						if {[N ubyte 4 0 0 {} {} x {}]} {
							>
								emit id=0x%x
							<
						}
	
					<
				}
			}
	
			switch [Nv ubyte 3 0 {} {}] {
				0 {
					>
						emit {\b, no compression}
					<
				}
				2 {
					>
						emit {\b, fast compression (Z1)}
					<
				}
				3 {
					>
						emit {\b, medium compression (Z2)}
					<
				}
			}
	
			if {[N ubyte 3 0 0 {} {} > 3]} {
				>
					if {[N ubyte 3 0 0 {} {} < 11]} {
						>
							emit {\b, compression (Z%d-1)}
						<
					}
	
				<
			}
	
			if {[S search 3592 0 {} 7776 eq \x55\xAA]} {
				>
					emit {\b; contains}
					T [R -512] {}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq Cr24]} {
		>
			emit {Google Chrome extension}
			if {[N ulong 4 0 0 {} {} x {}]} {
				>
					emit {\b, version %u}
				<
			}
	
			mime application/x-chrome-extension
		<
	}
	
	if {[S string 0 0 {} {} eq SBx]} {
		>
			emit SeqBox,
			if {[N byte 3 0 0 {} {} x {}]} {
				>
					emit {version %d}
				<
			}
	
		<
	}
	
	if {[S string 56 0 {} {} eq USE\040LYNX\040TO\040DISSOLVE\040THIS\040FILE]} {
		>
			emit {LyNX archive}
		<
	}
	
	if {[S regex 0 0 {} {} eq ^\[\040\t\]\{0,50\}\\.asciiz]} {
		>
			emit {assembler source text}
			mime text/x-asm
		<
	}
	
	if {[S regex 0 0 {} {} eq ^\[\040\t\]\{0,50\}\\.byte]} {
		>
			emit {assembler source text}
			mime text/x-asm
		<
	}
	
	if {[S regex 0 0 {} {} eq ^\[\040\t\]\{0,50\}\\.even]} {
		>
			emit {assembler source text}
			mime text/x-asm
		<
	}
	
	if {[S regex 0 0 {} {} eq ^\[\040\t\]\{0,50\}\\.globl]} {
		>
			emit {assembler source text}
			mime text/x-asm
		<
	}
	
	if {[S regex 0 0 {} {} eq ^\[\040\t\]\{0,50\}\\.text]} {
		>
			emit {assembler source text}
			mime text/x-asm
		<
	}
	
	if {[S regex 0 0 {} {} eq ^\[\040\t\]\{0,50\}\\.file]} {
		>
			emit {assembler source text}
			mime text/x-asm
		<
	}
	
	if {[S regex 0 0 {} {} eq ^\[\040\t\]\{0,50\}\\.type]} {
		>
			emit {assembler source text}
			mime text/x-asm
		<
	}
	
	if {[S string 0 0 {} {} eq *STA]} {
		>
			emit Aster*x
			if {[S string 7 0 {} {} eq WORD]} {
				>
					emit {Words Document}
				<
			}
	
			if {[S string 7 0 {} {} eq GRAP]} {
				>
					emit Graphic
				<
			}
	
			if {[S string 7 0 {} {} eq SPRE]} {
				>
					emit Spreadsheet
				<
			}
	
			if {[S string 7 0 {} {} eq MACR]} {
				>
					emit Macro
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq 2278]} {
		>
			emit {Aster*x Version 2}
			switch [Nv byte 29 0 {} {}] {
				50 {
					>
						emit Spreadsheet
					<
				}
				53 {
					>
						emit Graphic
					<
				}
				54 {
					>
						emit {Words Document}
					<
				}
				56 {
					>
						emit Macro
					<
				}
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \000\004\036\212\200]} {
		>
			emit {3b2 core file}
			if {[S string 364 0 {} {} > \0]} {
				>
					emit {of '%s'}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq .snd]} {
		>
			emit {Sun/NeXT audio data:}
			switch [Nv belong 12 0 {} {}] {
				1 {
					>
						emit {8-bit ISDN mu-law,}
						mime audio/basic
					<
				}
				2 {
					>
						emit {8-bit linear PCM [REF-PCM],}
						mime audio/basic
					<
				}
				3 {
					>
						emit {16-bit linear PCM,}
						mime audio/basic
					<
				}
				4 {
					>
						emit {24-bit linear PCM,}
						mime audio/basic
					<
				}
				5 {
					>
						emit {32-bit linear PCM,}
						mime audio/basic
					<
				}
				6 {
					>
						emit {32-bit IEEE floating point,}
						mime audio/basic
					<
				}
				7 {
					>
						emit {64-bit IEEE floating point,}
						mime audio/basic
					<
				}
				8 {
					>
						emit {Fragmented sample data,}
					<
				}
				10 {
					>
						emit {DSP program,}
					<
				}
				11 {
					>
						emit {8-bit fixed point,}
					<
				}
				12 {
					>
						emit {16-bit fixed point,}
					<
				}
				13 {
					>
						emit {24-bit fixed point,}
					<
				}
				14 {
					>
						emit {32-bit fixed point,}
					<
				}
				18 {
					>
						emit {16-bit linear with emphasis,}
					<
				}
				19 {
					>
						emit {16-bit linear compressed,}
					<
				}
				20 {
					>
						emit {16-bit linear with emphasis and compression,}
					<
				}
				21 {
					>
						emit {Music kit DSP commands,}
					<
				}
				23 {
					>
						emit {8-bit ISDN mu-law compressed (CCITT G.721 ADPCM voice enc.),}
						mime audio/x-adpcm
					<
				}
				24 {
					>
						emit {compressed (8-bit CCITT G.722 ADPCM)}
					<
				}
				25 {
					>
						emit {compressed (3-bit CCITT G.723.3 ADPCM),}
					<
				}
				26 {
					>
						emit {compressed (5-bit CCITT G.723.5 ADPCM),}
					<
				}
				27 {
					>
						emit {8-bit A-law (CCITT G.711),}
					<
				}
			}
	
			switch [Nv belong 20 0 {} {}] {
				1 {
					>
						emit mono,
					<
				}
				2 {
					>
						emit stereo,
					<
				}
				4 {
					>
						emit quad,
					<
				}
			}
	
			if {[N belong 16 0 0 {} {} > 0]} {
				>
					emit {%d Hz}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq MThd]} {
		>
			emit {Standard MIDI data}
			if {[N beshort 8 0 0 {} {} x {}]} {
				>
					emit {(format %d)}
				<
			}
	
			if {[N beshort 10 0 0 {} {} x {}]} {
				>
					emit {using %d track}
				<
			}
	
			if {[N beshort 10 0 0 {} {} > 1]} {
				>
					emit {\bs}
				<
			}
	
			if {[N beshort 12 0 0 & 32767 x {}]} {
				>
					emit {at 1/%d}
				<
			}
	
			if {[N beshort 12 0 0 & -32768 > 0]} {
				>
					emit SMPTE
				<
			}
	
			mime audio/midi
		<
	}
	
	if {[S string 0 0 {} {} eq CTMF]} {
		>
			emit {Creative Music (CMF) data}
			mime audio/x-unknown
		<
	}
	
	if {[S string 0 0 {} {} eq SBI]} {
		>
			emit {SoundBlaster instrument data}
			mime audio/x-unknown
		<
	}
	
	if {[S string 0 0 {} {} eq Creative\ Voice\ File]} {
		>
			emit {Creative Labs voice data}
			if {[N byte 19 0 0 {} {} == 26]} {
				>
				<
			}
	
			if {[N byte 23 0 0 {} {} > 0]} {
				>
					emit {- version %d}
				<
			}
	
			if {[N byte 22 0 0 {} {} > 0]} {
				>
					emit {\b.%d}
				<
			}
	
			mime audio/x-unknown
		<
	}
	
	if {[S string 0 0 {} {} eq EMOD]} {
		>
			emit {Extended MOD sound data,}
			if {[N byte 4 0 0 & -16 x {}]} {
				>
					emit {version %d}
				<
			}
	
			if {[N byte 4 0 0 & 15 x {}]} {
				>
					emit {\b.%d,}
				<
			}
	
			if {[N byte 45 0 0 {} {} x {}]} {
				>
					emit {%d instruments}
				<
			}
	
			switch [Nv byte 83 0 {} {}] {
				0 {
					>
						emit (module)
					<
				}
				1 {
					>
						emit (song)
					<
				}
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq .RMF\0\0\0]} {
		>
			emit {RealMedia file}
			mime application/vnd.rn-realmedia
		<
	}
	
	if {[S string 0 0 {} {} eq MAS_U]} {
		>
			emit {ULT(imate) Module sound data}
		<
	}
	
	if {[S string 44 0 {} {} eq SCRM]} {
		>
			emit {ScreamTracker III Module sound data}
			if {[S string 0 0 {} {} > \0]} {
				>
					emit {Title: "%s"}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq GF1PATCH110\0ID\#000002\0]} {
		>
			emit {GUS patch}
		<
	}
	
	if {[S string 0 0 {} {} eq GF1PATCH100\0ID\#000002\0]} {
		>
			emit {Old GUS	patch}
		<
	}
	
	if {[S string 0 0 {} {} eq MAS_UTrack_V00]} {
		>
			if {[S string 14 0 {} {} > /0]} {
				>
					emit {ultratracker V1.%.1s module sound data}
					mime audio/x-mod
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq UN05]} {
		>
			emit {MikMod UNI format module sound data}
		<
	}
	
	if {[S string 0 0 {} {} eq Extended\ Module:]} {
		>
			emit {Fasttracker II module sound data}
			if {[S string 17 0 {} {} > \0]} {
				>
					emit {Title: "%s"}
				<
			}
	
			mime audio/x-mod
		<
	}
	
	if {[S string 21 0 c {} eq !SCREAM!]} {
		>
			emit {Screamtracker 2 module sound data}
			mime audio/x-mod
		<
	}
	
	if {[S string 21 0 {} {} eq BMOD2STM]} {
		>
			emit {Screamtracker 2 module sound data}
			mime audio/x-mod
		<
	}
	
	if {[S string 1080 0 {} {} eq M.K.]} {
		>
			emit {4-channel Protracker module sound data}
			if {[S string 0 0 {} {} > \0]} {
				>
					emit {Title: "%s"}
				<
			}
	
			mime audio/x-mod
		<
	}
	
	if {[S string 1080 0 {} {} eq M!K!]} {
		>
			emit {4-channel Protracker module sound data}
			if {[S string 0 0 {} {} > \0]} {
				>
					emit {Title: "%s"}
				<
			}
	
			mime audio/x-mod
		<
	}
	
	if {[S string 1080 0 {} {} eq FLT4]} {
		>
			emit {4-channel Startracker module sound data}
			if {[S string 0 0 {} {} > \0]} {
				>
					emit {Title: "%s"}
				<
			}
	
			mime audio/x-mod
		<
	}
	
	if {[S string 1080 0 {} {} eq FLT8]} {
		>
			emit {8-channel Startracker module sound data}
			if {[S string 0 0 {} {} > \0]} {
				>
					emit {Title: "%s"}
				<
			}
	
			mime audio/x-mod
		<
	}
	
	if {[S string 1080 0 {} {} eq 4CHN]} {
		>
			emit {4-channel Fasttracker module sound data}
			if {[S string 0 0 {} {} > \0]} {
				>
					emit {Title: "%s"}
				<
			}
	
			mime audio/x-mod
		<
	}
	
	if {[S string 1080 0 {} {} eq 6CHN]} {
		>
			emit {6-channel Fasttracker module sound data}
			if {[S string 0 0 {} {} > \0]} {
				>
					emit {Title: "%s"}
				<
			}
	
			mime audio/x-mod
		<
	}
	
	if {[S string 1080 0 {} {} eq 8CHN]} {
		>
			emit {8-channel Fasttracker module sound data}
			if {[S string 0 0 {} {} > \0]} {
				>
					emit {Title: "%s"}
				<
			}
	
			mime audio/x-mod
		<
	}
	
	if {[S string 1080 0 {} {} eq CD81]} {
		>
			emit {8-channel Octalyser module sound data}
			if {[S string 0 0 {} {} > \0]} {
				>
					emit {Title: "%s"}
				<
			}
	
			mime audio/x-mod
		<
	}
	
	if {[S string 1080 0 {} {} eq OKTA]} {
		>
			emit {8-channel Octalyzer module sound data}
			if {[S string 0 0 {} {} > \0]} {
				>
					emit {Title: "%s"}
				<
			}
	
			mime audio/x-mod
		<
	}
	
	if {[S string 1080 0 {} {} eq 16CN]} {
		>
			emit {16-channel Taketracker module sound data}
			if {[S string 0 0 {} {} > \0]} {
				>
					emit {Title: "%s"}
				<
			}
	
			mime audio/x-mod
		<
	}
	
	if {[S string 1080 0 {} {} eq 32CN]} {
		>
			emit {32-channel Taketracker module sound data}
			if {[S string 0 0 {} {} > \0]} {
				>
					emit {Title: "%s"}
				<
			}
	
			mime audio/x-mod
		<
	}
	
	if {[S string 0 0 {} {} eq TOC]} {
		>
			emit {TOC sound file}
		<
	}
	
	if {[S string 0 0 {} {} eq SIDPLAY\ INFOFILE]} {
		>
			emit {Sidplay info file}
		<
	}
	
	if {[S string 0 0 {} {} eq PSID]} {
		>
			emit {PlaySID v2.2+ (AMIGA) sidtune}
			if {[N beshort 4 0 0 {} {} > 0]} {
				>
					emit {w/ header v%d,}
				<
			}
	
			if {[N beshort 14 0 0 {} {} == 1]} {
				>
					emit {single song,}
				<
			}
	
			if {[N beshort 14 0 0 {} {} > 1]} {
				>
					emit {%d songs,}
				<
			}
	
			if {[N beshort 16 0 0 {} {} > 0]} {
				>
					emit {default song: %d}
				<
			}
	
			if {[S string 22 0 {} {} > \0]} {
				>
					emit {name: "%s"}
				<
			}
	
			if {[S string 54 0 {} {} > \0]} {
				>
					emit {author: "%s"}
				<
			}
	
			if {[S string 86 0 {} {} > \0]} {
				>
					emit {copyright: "%s"}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq RSID]} {
		>
			emit {RSID sidtune PlaySID compatible}
			if {[N beshort 4 0 0 {} {} > 0]} {
				>
					emit {w/ header v%d,}
				<
			}
	
			if {[N beshort 14 0 0 {} {} == 1]} {
				>
					emit {single song,}
				<
			}
	
			if {[N beshort 14 0 0 {} {} > 1]} {
				>
					emit {%d songs,}
				<
			}
	
			if {[N beshort 16 0 0 {} {} > 0]} {
				>
					emit {default song: %d}
				<
			}
	
			if {[S string 22 0 {} {} > \0]} {
				>
					emit {name: "%s"}
				<
			}
	
			if {[S string 54 0 {} {} > \0]} {
				>
					emit {author: "%s"}
				<
			}
	
			if {[S string 86 0 {} {} > \0]} {
				>
					emit {copyright: "%s"}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq NIST_1A\n\ \ \ 1024\n]} {
		>
			emit {NIST SPHERE file}
		<
	}
	
	if {[S string 0 0 {} {} eq SOUND\ SAMPLE\ DATA\ ]} {
		>
			emit {Sample Vision file}
		<
	}
	
	if {[S string 0 0 {} {} eq 2BIT]} {
		>
			emit {Audio Visual Research file,}
			switch [Nv beshort 12 0 {} {}] {
				-1 {
					>
						emit stereo,
					<
				}
				0 {
					>
						emit mono,
					<
				}
			}
	
			if {[N beshort 14 0 0 {} {} x {}]} {
				>
					emit {%d bits}
				<
			}
	
			switch [Nv beshort 16 0 {} {}] {
				-1 {
					>
						emit signed,
					<
				}
				0 {
					>
						emit unsigned,
					<
				}
			}
	
			if {[N belong 22 0 0 & 16777215 x {}]} {
				>
					emit {%d Hz,}
				<
			}
	
			switch [Nv beshort 18 0 {} {}] {
				-1 {
					>
						emit loop,
					<
				}
				0 {
					>
						emit {no loop,}
					<
				}
			}
	
			if {[N ubyte 21 0 0 {} {} < 128]} {
				>
					emit {note %d,}
				<
			}
	
			switch [Nv byte 22 0 {} {}] {
				0 {
					>
						emit {replay 5.485 KHz}
					<
				}
				1 {
					>
						emit {replay 8.084 KHz}
					<
				}
				2 {
					>
						emit {replay 10.971 KHz}
					<
				}
				3 {
					>
						emit {replay 16.168 KHz}
					<
				}
				4 {
					>
						emit {replay 21.942 KHz}
					<
				}
				5 {
					>
						emit {replay 32.336 KHz}
					<
				}
				6 {
					>
						emit {replay 43.885 KHz}
					<
				}
				7 {
					>
						emit {replay 47.261 KHz}
					<
				}
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq _SGI_SoundTrack]} {
		>
			emit {SGI SoundTrack project file}
		<
	}
	
	if {[S string 0 0 {} {} eq ID3]} {
		>
			emit {Audio file with ID3 version 2}
			if {[N byte 3 0 0 {} {} x {}]} {
				>
					emit {\b.%d}
				<
			}
	
			if {[N byte 4 0 0 {} {} x {}]} {
				>
					emit {\b.%d}
					if {[N byte 5 0 0 {} {} & -128]} {
						>
							emit {\b, unsynchronized frames}
						<
					}
	
					if {[N byte 5 0 0 {} {} & 64]} {
						>
							emit {\b, extended header}
						<
					}
	
					if {[N byte 5 0 0 {} {} & 32]} {
						>
							emit {\b, experimental}
						<
					}
	
					if {[N byte 5 0 0 {} {} & 16]} {
						>
							emit {\b, footer present}
						<
					}
	
				<
			}
	
			emit {\b, contains:}
			T [I 6 ubeid3 0 + 0 10] {}
	
		<
	}
	
	if {[S string 0 0 {} {} eq NESM\x1a]} {
		>
			emit {NES Sound File}
			if {[S string 14 0 {} {} > \0]} {
				>
					emit {("%s" by}
				<
			}
	
			if {[S string 46 0 {} {} > \0]} {
				>
					emit {%s, copyright}
				<
			}
	
			if {[S string 78 0 {} {} > \0]} {
				>
					emit %s),
				<
			}
	
			if {[N byte 5 0 0 {} {} x {}]} {
				>
					emit {version %d,}
				<
			}
	
			if {[N byte 6 0 0 {} {} x {}]} {
				>
					emit {%d tracks,}
				<
			}
	
			if {[N byte 122 0 0 & 2 == 1]} {
				>
					emit {dual PAL/NTSC}
				<
			}
	
			switch [Nv byte 122 0 & 1] {
				0 {
					>
						emit NTSC
					<
				}
				1 {
					>
						emit PAL
					<
				}
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq NSFE]} {
		>
			emit {Extended NES Sound File}
			if {[S search 48 0 {} 4096 eq auth]} {
				>
					if {[S string [R 0] 0 {} {} > \0]} {
						>
							emit (\"%s\"
							if {[S string [R 1] 0 {} {} > \0]} {
								>
									emit {by %s}
									if {[S string [R 1] 0 {} {} > \0]} {
										>
											emit {\b, copyright %s}
											if {[S string [R 1] 0 {} {} > \0]} {
												>
													emit {\b, ripped by %s}
												<
											}
	
										<
									}
	
								<
							}
	
						<
					}
	
				<
			}
	
			if {[N byte 20 0 0 {} {} x {}]} {
				>
					emit {\b), %d tracks,}
				<
			}
	
			switch [Nv byte 18 0 & 2] {
				0 {
					>
						switch [Nv byte 18 0 & 1] {
							0 {
								>
									emit NTSC
								<
							}
							1 {
								>
									emit PAL
								<
							}
						}
	
					<
				}
				1 {
					>
						emit {dual PAL/NTSC}
					<
				}
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq SNES-SPC700\ Sound\ File\ Data\ v]} {
		>
			emit {SNES SPC700 sound file}
			if {[S string [R 0] 0 {} {} eq 0.30]} {
				>
					emit {\b, version %s}
					switch [Nv byte 35 0 {} {}] {
						26 {
							>
								emit {\b, with ID666 tag}
								if {[S string 46 0 {} {} > \0]} {
									>
										emit {\b, song "%.32s"}
									<
								}
	
								if {[S string 78 0 {} {} > \0]} {
									>
										emit {\b, game "%.32s"}
									<
								}
	
							<
						}
						27 {
							>
								emit {\b, without ID666 tag}
							<
						}
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq IMPM]} {
		>
			emit {Impulse Tracker module sound data -}
			if {[S string 4 0 {} {} > \0]} {
				>
					emit {"%s"}
				<
			}
	
			if {[N leshort 40 0 0 {} {} != 0]} {
				>
					emit {compatible w/ITv%x}
				<
			}
	
			if {[N leshort 42 0 0 {} {} != 0]} {
				>
					emit {created w/ITv%x}
				<
			}
	
			mime audio/x-mod
		<
	}
	
	if {[S string 60 0 {} {} eq IM10]} {
		>
			emit {Imago Orpheus module sound data -}
			if {[S string 0 0 {} {} > \0]} {
				>
					emit {"%s"}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq IMPS]} {
		>
			emit {Impulse Tracker Sample}
			if {[N byte 18 0 0 {} {} & 2]} {
				>
					emit {16 bit}
				<
			}
	
			if {[N byte 18 0 0 {} {} ^ 2]} {
				>
					emit {8 bit}
				<
			}
	
			if {[N byte 18 0 0 {} {} & 4]} {
				>
					emit stereo
				<
			}
	
			if {[N byte 18 0 0 {} {} ^ 4]} {
				>
					emit mono
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq IMPI]} {
		>
			emit {Impulse Tracker Instrument}
			if {[N leshort 28 0 0 {} {} != 0]} {
				>
					emit ITv%x
				<
			}
	
			if {[N byte 30 0 0 {} {} != 0]} {
				>
					emit {%d samples}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq LM8953]} {
		>
			emit {Yamaha TX Wave}
			switch [Nv byte 22 0 {} {}] {
				-55 {
					>
						emit non-looped
					<
				}
				73 {
					>
						emit looped
					<
				}
			}
	
			switch [Nv byte 23 0 {} {}] {
				1 {
					>
						emit 33kHz
					<
				}
				2 {
					>
						emit 50kHz
					<
				}
				3 {
					>
						emit 16kHz
					<
				}
			}
	
		<
	}
	
	if {[S string 76 0 {} {} eq SCRS]} {
		>
			emit {Scream Tracker Sample}
			switch [Nv byte 0 0 {} {}] {
				1 {
					>
						emit sample
					<
				}
				2 {
					>
						emit {adlib melody}
					<
				}
			}
	
			if {[N byte 0 0 0 {} {} > 2]} {
				>
					emit {adlib drum}
				<
			}
	
			if {[N byte 31 0 0 {} {} & 2]} {
				>
					emit stereo
				<
			}
	
			if {[N byte 31 0 0 {} {} ^ 2]} {
				>
					emit mono
				<
			}
	
			if {[N byte 31 0 0 {} {} & 4]} {
				>
					emit {16bit little endian}
				<
			}
	
			if {[N byte 31 0 0 {} {} ^ 4]} {
				>
					emit 8bit
				<
			}
	
			switch [Nv byte 30 0 {} {}] {
				0 {
					>
						emit unpacked
					<
				}
				1 {
					>
						emit packed
					<
				}
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq MMD0]} {
		>
			emit {MED music file, version 0}
		<
	}
	
	if {[S string 0 0 {} {} eq MMD1]} {
		>
			emit {OctaMED Pro music file, version 1}
		<
	}
	
	if {[S string 0 0 {} {} eq MMD3]} {
		>
			emit {OctaMED Soundstudio music file, version 3}
		<
	}
	
	if {[S string 0 0 {} {} eq OctaMEDCmpr]} {
		>
			emit {OctaMED Soundstudio compressed file}
		<
	}
	
	if {[S string 0 0 {} {} eq MED]} {
		>
			emit MED_Song
		<
	}
	
	if {[S string 0 0 {} {} eq SymM]} {
		>
			emit {Symphonie SymMOD music file}
		<
	}
	
	if {[S string 0 0 {} {} eq THX]} {
		>
			emit {AHX version}
			switch [Nv byte 3 0 {} {}] {
				0 {
					>
						emit {1 module data}
					<
				}
				1 {
					>
						emit {2 module data}
					<
				}
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq OKTASONG]} {
		>
			emit {Oktalyzer module data}
		<
	}
	
	if {[S string 0 0 {} {} eq DIGI\ Booster\ module\0]} {
		>
			emit %s
			if {[N byte 20 0 0 {} {} > 0]} {
				>
					emit %c
					if {[N byte 21 0 0 {} {} > 0]} {
						>
							emit {\b%c}
							if {[N byte 22 0 0 {} {} > 0]} {
								>
									emit {\b%c}
									if {[N byte 23 0 0 {} {} > 0]} {
										>
											emit {\b%c}
										<
									}
	
								<
							}
	
						<
					}
	
				<
			}
	
			if {[S string 610 0 {} {} > \0]} {
				>
					emit {\b, "%s"}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq DBM0]} {
		>
			emit {DIGI Booster Pro Module}
			if {[N byte 4 0 0 {} {} > 0]} {
				>
					emit V%X.
					if {[N byte 5 0 0 {} {} x {}]} {
						>
							emit {\b%02X}
						<
					}
	
				<
			}
	
			if {[S string 16 0 {} {} > \0]} {
				>
					emit {\b, "%s"}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq FTMN]} {
		>
			emit {FaceTheMusic module}
			if {[S string 16 0 {} {} > \0d]} {
				>
					emit {\b, "%s"}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq AMShdr\32]} {
		>
			emit {Velvet Studio AMS Module v2.2}
		<
	}
	
	if {[S string 0 0 {} {} eq Extreme]} {
		>
			emit {Extreme Tracker AMS Module v1.3}
		<
	}
	
	if {[S string 0 0 {} {} eq DDMF]} {
		>
			emit {Xtracker DMF Module}
			if {[N byte 4 0 0 {} {} x {}]} {
				>
					emit v%i
				<
			}
	
			if {[S string 13 0 {} {} > \0]} {
				>
					emit {Title: "%s"}
				<
			}
	
			if {[S string 43 0 {} {} > \0]} {
				>
					emit {Composer: "%s"}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq DSM\32]} {
		>
			emit {Dynamic Studio Module DSM}
		<
	}
	
	if {[S string 0 0 {} {} eq SONG]} {
		>
			emit {DigiTrekker DTM Module}
		<
	}
	
	if {[S string 0 0 {} {} eq DMDL]} {
		>
			emit {DigiTrakker MDL Module}
		<
	}
	
	if {[S string 0 0 {} {} eq PSM\32]} {
		>
			emit {Protracker Studio PSM Module}
		<
	}
	
	if {[S string 44 0 {} {} eq PTMF]} {
		>
			emit {Poly Tracker PTM Module}
			if {[S string 0 0 {} {} > \32]} {
				>
					emit {Title: "%s"}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq MT20]} {
		>
			emit {MadTracker 2.0 Module MT2}
		<
	}
	
	if {[S string 0 0 {} {} eq RAD\40by\40REALiTY!!]} {
		>
			emit {RAD Adlib Tracker Module RAD}
		<
	}
	
	if {[S string 0 0 {} {} eq RTMM]} {
		>
			emit {RTM Module}
		<
	}
	
	if {[S string 1062 0 {} {} eq MaDoKaN96]} {
		>
			emit {XMS Adlib Module}
			if {[S string 0 0 {} {} > \0]} {
				>
					emit {Composer: "%s"}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq AMF]} {
		>
			emit {AMF Module}
			if {[S string 4 0 {} {} > \0]} {
				>
					emit {Title: "%s"}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq MODINFO1]} {
		>
			emit {Open Cubic Player Module Inforation MDZ}
		<
	}
	
	if {[S string 0 0 {} {} eq Extended\40Instrument:]} {
		>
			emit {Fast Tracker II Instrument}
		<
	}
	
	if {[S string 0 0 {} {} eq \210NOA\015\012\032]} {
		>
			emit {NOA Nancy Codec Movie file}
		<
	}
	
	if {[S string 0 0 {} {} eq MMMD]} {
		>
			emit {Yamaha SMAF file}
		<
	}
	
	if {[S string 0 0 {} {} eq \001Sharp\040JisakuMelody]} {
		>
			emit {SHARP Cell-Phone ringing Melody}
			if {[S string 20 0 {} {} eq Ver01.00]} {
				>
					emit {Ver. 1.00}
					if {[N byte 32 0 0 {} {} x {}]} {
						>
							emit {, %d tracks}
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq fLaC]} {
		>
			emit {FLAC audio bitstream data}
			if {[N byte 4 0 0 & 127 > 0]} {
				>
					emit {\b, unknown version}
				<
			}
	
			if {[N byte 4 0 0 & 127 == 0]} {
				>
					emit {\b}
					switch [Nv beshort 20 0 & 496] {
						48 {
							>
								emit {\b, 4 bit}
							<
						}
						80 {
							>
								emit {\b, 6 bit}
							<
						}
						112 {
							>
								emit {\b, 8 bit}
							<
						}
						176 {
							>
								emit {\b, 12 bit}
							<
						}
						240 {
							>
								emit {\b, 16 bit}
							<
						}
						368 {
							>
								emit {\b, 24 bit}
							<
						}
					}
	
					switch [Nv byte 20 0 & 14] {
						0 {
							>
								emit {\b, mono}
							<
						}
						2 {
							>
								emit {\b, stereo}
							<
						}
						4 {
							>
								emit {\b, 3 channels}
							<
						}
						6 {
							>
								emit {\b, 4 channels}
							<
						}
						8 {
							>
								emit {\b, 5 channels}
							<
						}
						10 {
							>
								emit {\b, 6 channels}
							<
						}
						12 {
							>
								emit {\b, 7 channels}
							<
						}
						14 {
							>
								emit {\b, 8 channels}
							<
						}
					}
	
					switch [Nv belong 17 0 & 16777200] {
						176400 {
							>
								emit {\b, 11.025 kHz}
							<
						}
						256000 {
							>
								emit {\b, 16 kHz}
							<
						}
						352800 {
							>
								emit {\b, 22.05 kHz}
							<
						}
						384000 {
							>
								emit {\b, 24 kHz}
							<
						}
						512000 {
							>
								emit {\b, 32 kHz}
							<
						}
						705600 {
							>
								emit {\b, 44.1 kHz}
							<
						}
						768000 {
							>
								emit {\b, 48 kHz}
							<
						}
						1024000 {
							>
								emit {\b, 64 kHz}
							<
						}
						1411200 {
							>
								emit {\b, 88.2 kHz}
							<
						}
						1536000 {
							>
								emit {\b, 96 kHz}
							<
						}
						2048000 {
							>
								emit {\b, 128 kHz}
							<
						}
						2822400 {
							>
								emit {\b, 176.4 kHz}
							<
						}
						3072000 {
							>
								emit {\b, 192 kHz}
							<
						}
						4096000 {
							>
								emit {\b, 256 kHz}
							<
						}
						5644800 {
							>
								emit {\b, 352.8 kHz}
							<
						}
						6144000 {
							>
								emit {\b, 384 kHz}
							<
						}
					}
	
					if {[N byte 21 0 0 & 15 > 0]} {
						>
							emit {\b, >4G samples}
						<
					}
	
					if {[N byte 21 0 0 & 15 == 0]} {
						>
							emit {\b}
							if {[N belong 22 0 0 {} {} > 0]} {
								>
									emit {\b, %u samples}
								<
							}
	
							if {[N belong 22 0 0 {} {} == 0]} {
								>
									emit {\b, length unknown}
								<
							}
	
						<
					}
	
				<
			}
	
			mime audio/flac
		<
	}
	
	if {[S string 0 0 {} {} eq VBOX]} {
		>
			emit {VBOX voice message data}
		<
	}
	
	if {[S string 8 0 {} {} eq RB40]} {
		>
			emit {RBS Song file}
			if {[S string 29 0 {} {} eq ReBorn]} {
				>
					emit {created by ReBorn}
				<
			}
	
			if {[S string 37 0 {} {} eq Propellerhead]} {
				>
					emit {created by ReBirth}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq A\#S\#C\#S\#S\#L\#V\#3]} {
		>
			emit {Synthesizer Generator or Kimwitu data}
		<
	}
	
	if {[S string 0 0 {} {} eq A\#S\#C\#S\#S\#L\#HUB]} {
		>
			emit {Kimwitu++ data}
		<
	}
	
	if {[S string 0 0 {} {} eq TFMX-SONG]} {
		>
			emit {TFMX module sound data}
		<
	}
	
	if {[S string 0 0 {} {} eq MAC\040]} {
		>
			emit {Monkey's Audio compressed format}
			if {[N uleshort 4 0 0 {} {} > 3979]} {
				>
					emit {version %d}
					switch [Nv uleshort [I 8 ulelong 0 + 0 0] 0 {} {}] {
						1000 {
							>
								emit {with fast compression}
							<
						}
						2000 {
							>
								emit {with normal compression}
							<
						}
						3000 {
							>
								emit {with high compression}
							<
						}
						4000 {
							>
								emit {with extra high compression}
							<
						}
						5000 {
							>
								emit {with insane compression}
							<
						}
					}
	
					switch [Nv uleshort [I 8 ulelong 0 + 0 18] 0 {} {}] {
						1 {
							>
								emit {\b, mono}
							<
						}
						2 {
							>
								emit {\b, stereo}
							<
						}
					}
	
					if {[N ulelong [I 8 ulelong 0 + 0 20] 0 0 {} {} x {}]} {
						>
							emit {\b, sample rate %d}
						<
					}
	
				<
			}
	
			if {[N uleshort 4 0 0 {} {} < 3980]} {
				>
					emit {version %d}
					switch [Nv uleshort 6 0 {} {}] {
						1000 {
							>
								emit {with fast compression}
							<
						}
						2000 {
							>
								emit {with normal compression}
							<
						}
						3000 {
							>
								emit {with high compression}
							<
						}
						4000 {
							>
								emit {with extra high compression}
							<
						}
						5000 {
							>
								emit {with insane compression}
							<
						}
					}
	
					switch [Nv uleshort 10 0 {} {}] {
						1 {
							>
								emit {\b, mono}
							<
						}
						2 {
							>
								emit {\b, stereo}
							<
						}
					}
	
					if {[N ulelong 12 0 0 {} {} x {}]} {
						>
							emit {\b, sample rate %d}
						<
					}
	
				<
			}
	
			mime audio/x-ape
		<
	}
	
	if {[S string 0 0 {} {} eq RAWADATA]} {
		>
			emit {RdosPlay RAW}
		<
	}
	
	if {[S string 1068 0 {} {} eq RoR]} {
		>
			emit {AMUSIC Adlib Tracker}
		<
	}
	
	if {[S string 0 0 {} {} eq JCH]} {
		>
			emit EdLib
		<
	}
	
	if {[S string 0 0 {} {} eq mpu401tr]} {
		>
			emit {MPU-401 Trakker}
		<
	}
	
	if {[S string 0 0 {} {} eq SAdT]} {
		>
			emit {Surprise! Adlib Tracker}
			if {[N byte 4 0 0 {} {} x {}]} {
				>
					emit {Version %d}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq XAD!]} {
		>
			emit {eXotic ADlib}
		<
	}
	
	if {[S string 0 0 {} {} eq ofTAZ!]} {
		>
			emit {eXtra Simple Music}
		<
	}
	
	if {[S string 0 0 {} {} eq ZXAYEMUL]} {
		>
			emit {Spectrum 128 tune}
		<
	}
	
	if {[S string 0 0 {} {} eq \0BONK]} {
		>
			emit BONK,
			if {[N byte 14 0 0 {} {} x {}]} {
				>
					emit {%d channel(s),}
				<
			}
	
			switch [Nv byte 15 0 {} {}] {
				0 {
					>
						emit lossy,
					<
				}
				1 {
					>
						emit lossless,
					<
				}
			}
	
			if {[N byte 16 0 0 {} {} x {}]} {
				>
					emit mid-side
				<
			}
	
		<
	}
	
	if {[S string 384 0 {} {} eq LockStream]} {
		>
			emit {LockStream Embedded file (mostly MP3 on old Nokia phones)}
		<
	}
	
	if {[S string 0 0 {} {} eq TWIN97012000]} {
		>
			emit {VQF data}
			switch [Nv short 27 0 {} {}] {
				0 {
					>
						emit {\b, Mono}
					<
				}
				1 {
					>
						emit {\b, Stereo}
					<
				}
			}
	
			if {[N short 31 0 0 {} {} > 0]} {
				>
					emit {\b, %d kbit/s}
				<
			}
	
			if {[N short 35 0 0 {} {} > 0]} {
				>
					emit {\b, %d kHz}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq Winamp\ EQ\ library\ file]} {
		>
			emit %s
			if {[S string 23 0 {} {} x {}]} {
				>
					emit {\b%.4s}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \[Equalizer\ preset\]]} {
		>
			emit {XMMS equalizer preset}
		<
	}
	
	if {[S search 0 0 {} 1 eq \#EXTM3U]} {
		>
			emit {M3U playlist text}
		<
	}
	
	if {[S search 0 0 {} 1 eq \[playlist\]]} {
		>
			emit {PLS playlist text}
		<
	}
	
	if {[S string 1 0 {} {} eq \[licq\]]} {
		>
			emit {LICQ configuration file}
		<
	}
	
	if {[S string 0 0 {} {} eq ICE!]} {
		>
			emit {SNDH Atari ST music}
		<
	}
	
	if {[S string 0 0 {} {} eq SC68\ Music-file\ /\ (c)\ (BeN)jami]} {
		>
			emit {sc68 Atari ST music}
		<
	}
	
	if {[S string 0 0 {} {} eq MP+]} {
		>
			emit {Musepack audio (MP+)}
			if {[N byte 3 0 0 {} {} == -1]} {
				>
					emit {\b, SV pre8}
				<
			}
	
			switch [Nv byte 3 0 & 15] {
				6 {
					>
						emit {\b, SV 6}
					<
				}
				7 {
					>
						emit {\b, SV 7}
						switch [Nv byte 3 0 & -16] {
							-16 {
								>
									emit {\b.15}
								<
							}
							0 {
								>
									emit {\b.0}
								<
							}
							16 {
								>
									emit {\b.1}
								<
							}
						}
	
						switch [Nv byte 10 0 & -16] {
							-128 {
								>
									emit {\b, quality 3 (Thumb)}
								<
							}
							-112 {
								>
									emit {\b, quality 4 (Radio)}
								<
							}
							-96 {
								>
									emit {\b, quality 5 (Standard)}
								<
							}
							-80 {
								>
									emit {\b, quality 6 (Xtreme)}
								<
							}
							-64 {
								>
									emit {\b, quality 7 (Insane)}
								<
							}
							-48 {
								>
									emit {\b, quality 8 (BrainDead)}
								<
							}
							-32 {
								>
									emit {\b, quality 9}
								<
							}
							-16 {
								>
									emit {\b, quality 10}
								<
							}
							0 {
								>
									emit {\b, no profile}
								<
							}
							16 {
								>
									emit {\b, profile 'Unstable/Experimental'}
								<
							}
							80 {
								>
									emit {\b, quality 0}
								<
							}
							96 {
								>
									emit {\b, quality 1}
								<
							}
							112 {
								>
									emit {\b, quality 2 (Telephone)}
								<
							}
						}
	
						switch [Nv byte 27 0 {} {}] {
							0 {
								>
									emit {\b, Buschmann 1.7.0-9, Klemm 0.90-1.05}
								<
							}
							102 {
								>
									emit {\b, Beta 1.02}
								<
							}
							104 {
								>
									emit {\b, Beta 1.04}
								<
							}
							105 {
								>
									emit {\b, Alpha 1.05}
								<
							}
							106 {
								>
									emit {\b, Beta 1.06}
								<
							}
							110 {
								>
									emit {\b, Release 1.1}
								<
							}
							111 {
								>
									emit {\b, Alpha 1.11}
								<
							}
							112 {
								>
									emit {\b, Beta 1.12}
								<
							}
							113 {
								>
									emit {\b, Alpha 1.13}
								<
							}
							114 {
								>
									emit {\b, Beta 1.14}
								<
							}
							115 {
								>
									emit {\b, Alpha 1.15}
								<
							}
						}
	
					<
				}
				8 {
					>
						emit {\b, SV 8}
					<
				}
			}
	
			mime audio/x-musepack
		<
	}
	
	if {[S string 0 0 {} {} eq MPCK]} {
		>
			emit {Musepack audio (MPCK)}
			mime audio/x-musepack
		<
	}
	
	if {[S string 0 0 {} {} eq BEGIN:IMELODY]} {
		>
			emit {iMelody Ringtone Format}
		<
	}
	
	if {[S string 0 0 {} {} eq \030FICHIER\ GUITAR\ PRO\ v3.]} {
		>
			emit {Guitar Pro Ver. 3 Tablature}
		<
	}
	
	if {[S string 60 0 {} {} eq SONG]} {
		>
			emit {SoundFX Module sound file}
		<
	}
	
	if {[S string 0 0 {} {} eq \#!AMR]} {
		>
			emit {Adaptive Multi-Rate Codec (GSM telephony)}
		<
	}
	
	if {[S string 0 0 {} {} eq SCgf]} {
		>
			emit {SuperCollider3 Synth Definition file,}
			if {[N belong 4 0 0 {} {} x {}]} {
				>
					emit {version %d}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq TTA1]} {
		>
			emit {True Audio Lossless Audio}
		<
	}
	
	if {[S string 0 0 {} {} eq wvpk]} {
		>
			emit {WavPack Lossless Audio}
		<
	}
	
	if {[S string 0 0 {} {} eq Vgm\040]} {
		>
			if {[N ubyte 9 0 0 {} {} > 0]} {
				>
					emit {VGM Video Game Music dump v}
					if {[N ubyte 9 0 0 / 16 > 0]} {
						>
							emit {\b%d}
						<
					}
	
					if {[N ubyte 9 0 0 & 15 x {}]} {
						>
							emit {\b%d}
						<
					}
	
					if {[N ubyte 8 0 0 / 16 x {}]} {
						>
							emit {\b.%d}
						<
					}
	
					if {[N ubyte 8 0 0 & 15 > 0]} {
						>
							emit {\b%d}
						<
					}
	
					if {[N ubyte 8 0 0 {} {} x {}]} {
						>
							emit {\b, soundchip(s)=}
						<
					}
	
					if {[N ulelong 12 0 0 {} {} > 0]} {
						>
							emit SN76489,
						<
					}
	
					if {[N ulelong 16 0 0 {} {} > 0]} {
						>
							emit YM2413,
						<
					}
	
					if {[N ulelong 44 0 0 {} {} > 0]} {
						>
							emit YM2612,
						<
					}
	
					if {[N ulelong 48 0 0 {} {} > 0]} {
						>
							emit YM2151,
						<
					}
	
					if {[N ulelong 56 0 0 {} {} > 0]} {
						>
							emit {Sega PCM,}
						<
					}
	
					if {[N ulelong 52 0 0 {} {} > 12]} {
						>
							if {[N ulelong 64 0 0 {} {} > 0]} {
								>
									emit RF5C68,
								<
							}
	
						<
					}
	
					if {[N ulelong 52 0 0 {} {} > 16]} {
						>
							if {[N ulelong 68 0 0 {} {} > 0]} {
								>
									emit YM2203,
								<
							}
	
						<
					}
	
					if {[N ulelong 52 0 0 {} {} > 20]} {
						>
							if {[N ulelong 72 0 0 {} {} > 0]} {
								>
									emit YM2608,
								<
							}
	
						<
					}
	
					if {[N ulelong 52 0 0 {} {} > 24]} {
						>
							if {[N lelong 76 0 0 {} {} > 0]} {
								>
									emit YM2610,
								<
							}
	
							if {[N lelong 76 0 0 {} {} < 0]} {
								>
									emit YM2610B,
								<
							}
	
						<
					}
	
					if {[N ulelong 52 0 0 {} {} > 28]} {
						>
							if {[N ulelong 80 0 0 {} {} > 0]} {
								>
									emit YM3812,
								<
							}
	
						<
					}
	
					if {[N ulelong 52 0 0 {} {} > 32]} {
						>
							if {[N ulelong 84 0 0 {} {} > 0]} {
								>
									emit YM3526,
								<
							}
	
						<
					}
	
					if {[N ulelong 52 0 0 {} {} > 36]} {
						>
							if {[N ulelong 88 0 0 {} {} > 0]} {
								>
									emit Y8950,
								<
							}
	
						<
					}
	
					if {[N ulelong 52 0 0 {} {} > 40]} {
						>
							if {[N ulelong 92 0 0 {} {} > 0]} {
								>
									emit YMF262,
								<
							}
	
						<
					}
	
					if {[N ulelong 52 0 0 {} {} > 44]} {
						>
							if {[N ulelong 96 0 0 {} {} > 0]} {
								>
									emit YMF278B,
								<
							}
	
						<
					}
	
					if {[N ulelong 52 0 0 {} {} > 48]} {
						>
							if {[N ulelong 100 0 0 {} {} > 0]} {
								>
									emit YMF271,
								<
							}
	
						<
					}
	
					if {[N ulelong 52 0 0 {} {} > 52]} {
						>
							if {[N ulelong 104 0 0 {} {} > 0]} {
								>
									emit YMZ280B,
								<
							}
	
						<
					}
	
					if {[N ulelong 52 0 0 {} {} > 56]} {
						>
							if {[N ulelong 108 0 0 {} {} > 0]} {
								>
									emit RF5C164,
								<
							}
	
						<
					}
	
					if {[N ulelong 52 0 0 {} {} > 60]} {
						>
							if {[N ulelong 112 0 0 {} {} > 0]} {
								>
									emit PWM,
								<
							}
	
						<
					}
	
					if {[N ulelong 52 0 0 {} {} > 64]} {
						>
							if {[N ulelong 116 0 0 {} {} > 0]} {
								>
									switch [Nv ubyte 120 0 {} {}] {
										0 {
											>
												emit AY-3-8910,
											<
										}
										1 {
											>
												emit AY-3-8912,
											<
										}
										2 {
											>
												emit AY-3-8913,
											<
										}
										3 {
											>
												emit AY-3-8930,
											<
										}
										16 {
											>
												emit YM2149,
											<
										}
										17 {
											>
												emit YM3439,
											<
										}
									}
	
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq SCOW]} {
		>
			switch [Nv byte 4 0 {} {}] {
				-62 {
					>
						emit {GVOX Encore music, version < 5.0}
					<
				}
				-60 {
					>
						emit {GVOX Encore music, version 5.0 or above}
					<
				}
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq ZBOT]} {
		>
			if {[N byte 4 0 0 {} {} == -59]} {
				>
					emit {GVOX Encore music, version < 5.0}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq AUDIMG]} {
		>
			if {[N ubyte 13 0 0 {} {} < 13]} {
				>
					emit {Garmin Voice Processing Module}
					if {[S string 6 0 {} {} x {}]} {
						>
							emit {\b, version %3.3s}
						<
					}
	
					if {[N ubyte 12 0 0 {} {} x {}]} {
						>
							emit {\b, %.2d}
						<
					}
	
					if {[N ubyte 13 0 0 {} {} x {}]} {
						>
							emit {\b.%.2d}
						<
					}
	
					if {[N uleshort 14 0 0 {} {} x {}]} {
						>
							emit {\b.%.4d}
						<
					}
	
					if {[N ubyte 11 0 0 {} {} x {}]} {
						>
							emit %.2d
						<
					}
	
					if {[N ubyte 10 0 0 {} {} x {}]} {
						>
							emit {\b:%.2d}
						<
					}
	
					if {[N ubyte 9 0 0 {} {} x {}]} {
						>
							emit {\b:%.2d}
						<
					}
	
					if {[N ubyte 18 0 0 {} {} x {}]} {
						>
							emit {\b, language ID %d}
						<
					}
	
					if {[N uleshort 16 0 0 {} {} > 0]} {
						>
							if {[N ulelong [I 16 uleshort 0 + 0 0] 0 0 {} {} > 0]} {
								>
									emit {\b, at offset 0x%x}
									if {[N ulelong [I 16 uleshort 0 + 0 4] 0 0 {} {} > 0]} {
										>
											emit {%d Bytes}
											if {[S string [I [R -8] ulelong 0 + 0 0] 0 {} {} eq RIFF]} {
												>
													emit {\b}
													T [R -4] {}
	
												<
											}
	
										<
									}
	
								<
							}
	
						<
					}
	
					mime audio/x-vpm-wav-garmin
					ext vpm
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq GDM]} {
		>
			if {[N byte 3 0 0 {} {} == -2]} {
				>
					emit {General Digital Music.}
				<
			}
	
			if {[S string 4 0 {} {} > \0]} {
				>
					emit {title: "%s"}
				<
			}
	
			if {[S string 36 0 {} {} > \0]} {
				>
					emit {musician: "%s"}
					if {[N beshort 68 0 0 {} {} == 3338]} {
						>
							if {[N byte 70 0 0 {} {} == 26]} {
								>
									if {[S string 71 0 {} {} eq GMFS]} {
										>
											emit Version
										<
									}
	
									if {[N byte 75 0 0 {} {} x {}]} {
										>
											emit %d.
										<
									}
	
									if {[N byte 76 0 0 {} {} x {}]} {
										>
											emit {\b%02d}
										<
									}
	
									if {[N beshort 77 0 0 {} {} == 0]} {
										>
											emit {(2GDM v}
										<
									}
	
									if {[N byte 79 0 0 {} {} x {}]} {
										>
											emit {\b%d.}
											if {[N byte 80 0 0 {} {} x {}]} {
												>
													emit {\b%d)}
												<
											}
	
										<
									}
	
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq MTM]} {
		>
			emit Multitracker
			if {[N byte 3 0 0 / 16 x {}]} {
				>
					emit {Version %d.}
				<
			}
	
			if {[N byte 3 0 0 & 15 x {}]} {
				>
					emit {\b%02d}
					if {[S string 4 0 {} {} > \0]} {
						>
							emit {title: "%s"}
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq HVL]} {
		>
			if {[N byte 3 0 0 {} {} < 2]} {
				>
					emit {Hively Tracker Song}
				<
			}
	
			switch [Nv byte 3 0 {} {}] {
				0 {
					>
						emit {1 module data}
					<
				}
				1 {
					>
						emit {2 module data}
					<
				}
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq MO3]} {
		>
			if {[N ubyte 3 0 0 {} {} < 6]} {
				>
					emit {MOdule with MP3}
					switch [Nv byte 3 0 {} {}] {
						0 {
							>
								emit {Version	0	(With MP3 and lossless)}
							<
						}
						1 {
							>
								emit {Version	1	(With ogg and lossless)}
							<
						}
						3 {
							>
								emit {Version 2.2}
							<
						}
						4 {
							>
								emit {(With no LAME header)}
							<
						}
						5 {
							>
								emit {Version 2.4}
							<
						}
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq ADRVPACK]} {
		>
			emit {AProSys	module}
		<
	}
	
	if {[S string 0 0 {} {} eq AON]} {
		>
			if {[S string 4 0 {} {} eq \"ArtOfNoise]} {
				>
					emit {by Bastian Spiegel(twice/lego)"}
				<
			}
	
			if {[S string 46 0 {} {} eq NAME]} {
				>
					emit {Art of Noise Tracker Song}
				<
			}
	
			if {[S string 3 0 {} {} < 9]} {
				>
				<
			}
	
			if {[S string 3 0 {} {} eq 4]} {
				>
					emit {(4 voices)}
				<
			}
	
			if {[S string 3 0 {} {} eq 8]} {
				>
					emit {(8 voices)}
					if {[S string 54 0 {} {} > \0]} {
						>
							emit {Title: "%s"}
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq FAR]} {
		>
			if {[N byte 44 0 0 {} {} == 13]} {
				>
				<
			}
	
			if {[N byte 45 0 0 {} {} == 10]} {
				>
				<
			}
	
			if {[N byte 46 0 0 {} {} == 26]} {
				>
					if {[N byte 3 0 0 {} {} == -2]} {
						>
							emit {Farandole Tracker Song}
							if {[N byte 49 0 0 / 16 x {}]} {
								>
									emit {Version %d.}
								<
							}
	
							if {[N byte 49 0 0 & 15 x {}]} {
								>
									emit {\b%02d}
									if {[S string 4 0 {} {} > \0]} {
										>
											emit {\b, title: "%s"}
										<
									}
	
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq cyd!song]} {
		>
			emit {Klystrack song}
			if {[N byte 8 0 0 {} {} > 0]} {
				>
					emit {\b, version %u}
				<
			}
	
			if {[N byte 8 0 0 {} {} > 26]} {
				>
					if {[S pstring 149 0 {} {} x {}]} {
						>
							emit {\b, title %s}
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq cyd!inst]} {
		>
			emit {Klystrack instrument}
		<
	}
	
	if {[S string 0 0 {} {} eq WOPL3-INST\0]} {
		>
			emit {WOPL instrument}
			if {[N leshort 11 0 0 {} {} x {}]} {
				>
					emit {\b, version %u}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq WOPL3-BANK\0]} {
		>
			emit {WOPL instrument bank}
			if {[N leshort 11 0 0 {} {} x {}]} {
				>
					emit {\b, version %u}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq Junglevision\ Patch\ File]} {
		>
			emit {Junglevision instrument data}
		<
	}
	
	if {[S string 0 0 {} {} eq \#OPL_II\#]} {
		>
			emit {DMX OP2 instrument data}
		<
	}
	
	if {[S string 0 0 {} {} eq IBK\x1a]} {
		>
			emit {IBK instrument data}
		<
	}
	
	if {[S string 0 0 {} {} eq 2OP\x1a]} {
		>
			emit {IBK instrument data, 2 operators}
		<
	}
	
	if {[S string 0 0 {} {} eq 4OP\x1a]} {
		>
			emit {IBK instrument data, 4 operators}
		<
	}
	
	if {[S string 2 0 {} {} eq ADLIB-]} {
		>
			emit {AdLib instrument data}
			if {[N byte 0 0 0 {} {} x {}]} {
				>
					emit {\b, version %u}
				<
			}
	
			if {[N byte 1 0 0 {} {} x {}]} {
				>
					emit {\b.%u}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq LA]} {
		>
			if {[S string 2 0 {} {} eq 03]} {
				>
					emit {Lossless audio version 0.3}
				<
			}
	
			if {[S string 2 0 {} {} eq 04]} {
				>
					emit {Lossless audio version 0.4}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \074\074bbx\076\076]} {
		>
			emit BBx
			if {[S string 7 0 {} {} eq \000]} {
				>
					emit {indexed file}
				<
			}
	
			if {[S string 7 0 {} {} eq \001]} {
				>
					emit {serial file}
				<
			}
	
			if {[S string 7 0 {} {} eq \002]} {
				>
					emit {keyed file}
					if {[N short 13 0 0 {} {} == 0]} {
						>
							emit (sort)
						<
					}
	
				<
			}
	
			if {[S string 7 0 {} {} eq \004]} {
				>
					emit program
					if {[N byte 18 0 0 {} {} x {}]} {
						>
							emit {(LEVEL %d)}
							if {[S string 23 0 {} {} > \000]} {
								>
									emit psaved
								<
							}
	
						<
					}
	
				<
			}
	
			if {[S string 7 0 {} {} eq \006]} {
				>
					emit {mkeyed file}
					if {[N short 13 0 0 {} {} == 0]} {
						>
							emit (sort)
						<
					}
	
					if {[S string 8 0 {} {} eq \000]} {
						>
							emit (mkey)
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq BEETLE\000]} {
		>
			emit {Beetle VM object file}
		<
	}
	
	switch [Nv byte 0 0 {} {}] {
		-128 {
			>
				if {[N uleshort 1 0 0 {} {} < 1022]} {
					>
						if {[N uleshort 1 0 0 {} {} > 0]} {
							>
								if {[N ubyte 3 0 0 {} {} > 0]} {
									>
										if {[S regex 4 0 {} {} eq \[a-zA-Z_/\]\{1,8\}\[.\]]} {
											>
												emit {8086 relocatable (Microsoft)}
												if {[S pstring 3 0 {} {} x {}]} {
													>
														emit {\b, "%s"}
													<
												}
	
												mime application/x-object
												ext o/a
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
			<
		}
		-116 {
			>
				emit {PGP symmetric key encrypted data -}
				switch [Nv byte 1 0 {} {}] {
					12 {
						>
						<
					}
					13 {
						>
						<
					}
				}
	
				if {[N byte 2 0 0 {} {} == 4]} {
					>
					<
				}
	
				U 199 crypto 3
	
				switch [Nv byte 4 0 {} {}] {
					1 {
						>
							emit {salted -}
							U 199 hash 5
	
							switch [Nv byte 14 0 {} {}] {
								-55 {
									>
										emit .
									<
								}
								-46 {
									>
										emit .
									<
								}
							}
	
						<
					}
					3 {
						>
							emit {salted & iterated -}
							U 199 hash 5
	
							switch [Nv byte 15 0 {} {}] {
								-55 {
									>
										emit .
									<
								}
								-46 {
									>
										emit .
									<
								}
							}
	
						<
					}
				}
	
			<
		}
		-107 {
			>
				emit {PGP	Secret Key -}
				U 199 pgpkey 1
	
			<
		}
		-105 {
			>
				emit {PGP	Secret Sub-key -}
				U 199 pgpkey 1
	
			<
		}
		-103 {
			>
				if {[N ubyte 3 0 0 {} {} < 5]} {
					>
						if {[N ubyte [I 1 ubeshort 0 + 0 3] 0 0 {} {} > 127]} {
							>
								if {[N ubyte 3 0 0 {} {} < 4]} {
									>
										emit {PGP key public ring (v%u)}
										if {[N beldate 4 0 0 {} {} x {}]} {
											>
												emit {created %s}
											<
										}
	
										if {[N ubeshort 8 0 0 {} {} > 0]} {
											>
												emit {\b, %u days valid}
											<
										}
	
										if {[N ubeshort 8 0 0 {} {} == 0]} {
											>
												emit {\b, not expire}
											<
										}
	
										U 199 key_algo 10
	
										if {[N ubeshort 11 0 0 {} {} x {}]} {
											>
												emit {%u bits}
											<
										}
	
										if {[N ubequad 13 0 0 {} {} x {}]} {
											>
												emit MPI=0x%16.16llx...
											<
										}
	
										mime application/pgp-keys
										ext pgp/ASD
									<
								}
	
								if {[N ubyte 3 0 0 {} {} > 3]} {
									>
										emit {PGP/GPG key public ring (v%u)}
										if {[N beldate 4 0 0 {} {} x {}]} {
											>
												emit {created %s}
											<
										}
	
										U 199 key_algo 8
	
										if {[N ubeshort 9 0 0 {} {} x {}]} {
											>
												emit {%u bits}
											<
										}
	
										if {[N ubequad 11 0 0 {} {} x {}]} {
											>
												emit MPI=0x%16.16llx...
											<
										}
	
										mime application/pgp-keys
										ext pgp/gpg/pkr/asd
									<
								}
	
							<
						}
	
					<
				}
	
			<
		}
		-99 {
			>
				if {[N ubeshort 1 0 0 {} {} > 0]} {
					>
						if {[N ubyte 3 0 0 {} {} > 0]} {
							>
								if {[N ubyte 3 0 0 {} {} < 5]} {
									>
										emit {PGP Secret Sub-key}
										if {[N ubyte 3 0 0 {} {} x {}]} {
											>
												emit (v%d)
											<
										}
	
										if {[N ubyte 3 0 0 {} {} x {}]} {
											>
												emit -
											<
										}
	
										if {[N ubyte 3 0 0 {} {} < 4]} {
											>
												if {[N ubeshort 11 0 0 {} {} x {}]} {
													>
														emit %db
													<
												}
	
												if {[N beldate 4 0 0 {} {} x {}]} {
													>
														emit {created on %s -}
													<
												}
	
												U 199 key_algo 10
	
												if {[N ubequad [I 11 ubeshort 0 / 0 8] 0 0 {} {} x {}]} {
													>
														U 199 keyend [R 5]
	
													<
												}
	
											<
										}
	
										if {[N ubyte 3 0 0 {} {} > 3]} {
											>
												if {[N ubeshort 9 0 0 {} {} x {}]} {
													>
														emit %db
													<
												}
	
												if {[N beldate 4 0 0 {} {} x {}]} {
													>
														emit {created on %s -}
													<
												}
	
												U 199 key_algo 8
	
												if {[N ubequad [I 9 ubeshort 0 / 0 8] 0 0 {} {} x {}]} {
													>
														U 199 keyend [R 3]
	
													<
												}
	
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
			<
		}
		-23 {
			>
				if {[N short 1 0 0 {} {} > -1]} {
					>
						if {[N byte [I 1 uleshort 0 + 0 3] 0 0 {} {} x {}]} {
							>
								U 163 msdos-com 0
	
							<
						}
	
					<
				}
	
				if {[N short 1 0 0 {} {} < -259]} {
					>
						if {[N byte [I 1 leshort 0 + 0 65539] 0 0 {} {} x {}]} {
							>
								U 163 msdos-com 0
	
							<
						}
	
					<
				}
	
			<
		}
		-21 {
			>
				if {[N byte 1 0 0 {} {} > -1]} {
					>
						if {[N byte [I 1 ubyte 0 + 0 2] 0 0 {} {} x {}]} {
							>
								U 163 msdos-com 0
	
							<
						}
	
					<
				}
	
			<
		}
		-2 {
			>
				if {[N uleshort 1 0 0 {} {} == 1]} {
					>
						if {[N uleshort 5 0 0 {} {} == 65535]} {
							>
								if {[N byte 6 0 0 {} {} == 10]} {
									>
										emit {MSX Mega-Assembler source}
									<
								}
	
							<
						}
	
					<
				}
	
			<
		}
		-1 {
			>
				if {[N uleshort 3 0 0 {} {} == 10]} {
					>
						if {[N uleshort 1 0 0 {} {} > 32768]} {
							>
								emit {MSX-BASIC program}
							<
						}
	
					<
				}
	
			<
		}
		0 {
			>
				if {[N ubyte 1 0 0 {} {} > 0]} {
					>
						if {[N ubyte 1 0 0 {} {} < 64]} {
							>
								if {[N ubelong 2 0 0 {} {} > 520093696]} {
									>
										if {[N byte 74 0 0 {} {} == 0]} {
											>
												if {[N byte 82 0 0 {} {} == 0]} {
													>
														switch [Nv ubeshort 122 0 {} {}] {
															0 {
																>
																	U 136 mac-bin 0
	
																<
															}
															33153 {
																>
																	U 136 mac-bin 0
	
																<
															}
														}
	
													<
												}
	
												if {[N ubeshort 122 0 0 {} {} == 33409]} {
													>
														U 136 mac-bin 0
	
													<
												}
	
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
			<
			>
				if {[S string 12 0 {} {} eq \x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x40\x00]} {
					>
						emit {Soundtrakker 128 ST2 music,}
						if {[S string 1 0 {} {} x {}]} {
							>
								emit {name: %s}
							<
						}
	
					<
				}
	
			<
		}
		4 {
			>
				if {[N beshort 10 0 0 {} {} == 4064]} {
					>
						if {[N belong 12 0 0 {} {} == -250544146]} {
							>
								if {[N beshort 520 0 0 {} {} == 256]} {
									>
										if {[N byte 522 0 0 {} {} == 15]} {
											>
												if {[N bequad 524 0 0 {} {} == 18773704704]} {
													>
														if {[N byte 91 0 0 {} {} == 2]} {
															>
																if {[N belong 84 0 0 {} {} x {}]} {
																	>
																		emit {Nintendo amiibo NFC dump - amiibo ID: %08X-}
																	<
																}
	
																if {[N belong 88 0 0 {} {} x {}]} {
																	>
																		emit {\b%08X}
																	<
																}
	
															<
														}
	
													<
												}
	
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
			<
		}
		32 {
			>
				if {[N leshort 1 0 0 {} {} == 7]} {
					>
						if {[N byte 118 0 0 {} {} == 32]} {
							>
								if {[N leshort 119 0 0 {} {} == 117]} {
									>
										emit {TomTom activity file, v7}
										if {[N leldate 8 0 0 {} {} x {}]} {
											>
												emit (%s,
											<
										}
	
										if {[N byte 3 0 0 {} {} x {}]} {
											>
												emit {device firmware %d.}
											<
										}
	
										if {[N byte 4 0 0 {} {} x {}]} {
											>
												emit {\b%d.}
											<
										}
	
										if {[N byte 5 0 0 {} {} x {}]} {
											>
												emit {\b%d,}
											<
										}
	
										if {[N leshort 6 0 0 {} {} x {}]} {
											>
												emit {product ID %04d)}
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
			<
		}
		38 {
			>
				if {[S regex 16 0 s {} eq ^\[0-78\]\[0-9.\]\{4\}]} {
					>
						emit {Sendmail frozen configuration}
						if {[S string 16 0 {} {} > \0]} {
							>
								emit {- version %s}
							<
						}
	
						ext fc
					<
				}
	
			<
		}
		97 {
			>
				if {[S search [R 1] 0 b 5 eq \x64]} {
					>
						if {[S search [R 1] 0 b 8 eq \x5f\x81\x44]} {
							>
								if {[S search [R 64] 0 b 64 eq \x5f\x81\x49\x01\x03\x5f\x81\x3d\x01]} {
									>
										if {[N byte [R 0] 0 0 {} {} x {}]} {
											>
												emit {TAP 3.%d Batch (TD.57, Transferred Account)}
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
			<
			>
				if {[S search [R 1] 0 b 8 eq \x5f\x29\x01\x02\x5f\x25\x01]} {
					>
						if {[N byte [R 0] 0 0 {} {} x {}]} {
							>
								emit {NRT 2.%d (TD.35, Near Real Time Roaming Data Exchange)}
							<
						}
	
					<
				}
	
			<
		}
		98 {
			>
				if {[S search 2 0 b 8 eq \x5f\x81\x44]} {
					>
						if {[S search [R 64] 0 b 64 eq \x5f\x81\x49\x01\x03\x5f\x81\x3d\x01]} {
							>
								if {[N byte [R 0] 0 0 {} {} x {}]} {
									>
										emit {TAP 3.%d Notification (TD.57, Transferred Account)}
									<
								}
	
							<
						}
	
					<
				}
	
			<
		}
	}
	
	if {[S string 0 0 {} {} eq \x7f\x84\x16]} {
		>
			if {[S search [R 1] 0 b 8 eq \x7f\x84\x19]} {
				>
					if {[S search [R 64] 0 b 64 eq \x5f\x81\x49\x01\x03\x5f\x81\x3d\x01]} {
						>
							if {[S string [R 1] 0 b {} eq \x5f\x84\x20\x01\x01\x5f\x84\x1f\x01]} {
								>
									if {[N byte [R 0] 0 0 {} {} x {}]} {
										>
											emit {RAP 1.%d Batch (TD.32, Returned Account Procedure),}
										<
									}
	
								<
							}
	
							if {[N byte [R 0] 0 0 {} {} x {}]} {
								>
									emit {TAP 3.%d}
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \x7f\x84\x17]} {
		>
			if {[S search [R 1] 0 b 5 eq \x5f\x81\x44]} {
				>
					emit {RAP Acknowledgement (TD.32, Returned Account Procedure)}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq bFLT]} {
		>
			emit {BFLT executable}
			if {[N belong 4 0 0 {} {} x {}]} {
				>
					emit {- version %d}
				<
			}
	
			if {[N belong 4 0 0 {} {} == 4]} {
				>
					if {[N belong 36 0 0 & 1 == 1]} {
						>
							emit ram
						<
					}
	
					if {[N belong 36 0 0 & 2 == 2]} {
						>
							emit gotpic
						<
					}
	
					if {[N belong 36 0 0 & 4 == 4]} {
						>
							emit gzip
						<
					}
	
					if {[N belong 36 0 0 & 8 == 8]} {
						>
							emit gzdata
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq BlockHashLoc\x1a]} {
		>
			emit {BlockHashLoc recovery info,}
			if {[N byte 13 0 0 {} {} x {}]} {
				>
					emit {version %d}
					ext bhl
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \037\213]} {
		>
			if {[N byte 3 0 0 {} {} & 4]} {
				>
					if {[S string 12 0 {} {} eq BC]} {
						>
							if {[N leshort 14 0 0 {} {} & 2]} {
								>
									emit {Blocked GNU Zip Format (BGZF; gzip compatible)}
									if {[N leshort 16 0 0 {} {} x {}]} {
										>
											emit {\b, block length %d}
											mime application/x-gzip
										<
									}
	
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq TBI\1]} {
		>
			emit {SAMtools TBI (Tabix index format)}
			if {[N lelong 4 0 0 {} {} == 1]} {
				>
					emit {\b, with %d reference sequence}
				<
			}
	
			if {[N lelong 4 0 0 {} {} > 1]} {
				>
					emit {\b, with %d reference sequences}
				<
			}
	
			if {[N lelong 8 0 0 {} {} & 65536]} {
				>
					emit {\b, using half-closed-half-open coordinates (BED style)}
				<
			}
	
			if {[N lelong 8 0 0 {} {} ^ 65536]} {
				>
					switch [Nv lelong 8 0 {} {}] {
						0 {
							>
								emit {\b, using closed and one based coordinates (GFF style)}
							<
						}
						1 {
							>
								emit {\b, using SAM format}
							<
						}
						2 {
							>
								emit {\b, using VCF format}
							<
						}
					}
	
				<
			}
	
			if {[N lelong 12 0 0 {} {} x {}]} {
				>
					emit {\b, sequence name column: %d}
				<
			}
	
			if {[N lelong 16 0 0 {} {} x {}]} {
				>
					emit {\b, region start column: %d}
				<
			}
	
			if {[N lelong 8 0 0 {} {} == 0]} {
				>
					if {[N lelong 20 0 0 {} {} x {}]} {
						>
							emit {\b, region end column: %d}
						<
					}
	
				<
			}
	
			if {[N byte 24 0 0 {} {} x {}]} {
				>
					emit {\b, comment character: %c}
				<
			}
	
			if {[N lelong 28 0 0 {} {} x {}]} {
				>
					emit {\b, skip line count: %d}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq BAM\1]} {
		>
			emit {SAMtools BAM (Binary Sequence Alignment/Map)}
			if {[N lelong 4 0 0 {} {} > 0]} {
				>
					if {[S regex [R 0] 0 {} {} eq ^\[@\]HD\t.*VN:]} {
						>
							emit {\b, with SAM header}
							if {[S regex [R 0] 0 {} {} eq \[0-9.\]+]} {
								>
									emit {\b version %s}
								<
							}
	
						<
					}
	
					if {[N lelong [R [I 4 long 0 + 0 0]] 0 0 {} {} > 0]} {
						>
							emit {\b, with %d reference sequences}
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq BAI\1]} {
		>
			emit {SAMtools BAI (BAM indexing format)}
			if {[N lelong 4 0 0 {} {} > 0]} {
				>
					emit {\b, with %d reference sequences}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq CRAM]} {
		>
			emit CRAM
			if {[N byte 4 0 0 {} {} > -1]} {
				>
					emit {version %d.}
				<
			}
	
			if {[N byte 5 0 0 {} {} > -1]} {
				>
					emit {\b%d}
				<
			}
	
			if {[S string 6 0 {} {} > \0]} {
				>
					emit {(identified as %s)}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq BCF\4]} {
		>
			if {[N lelong [R 0] 0 0 {} {} > 0]} {
				>
					if {[N lelong [R [I [R -4] long 0 + 0 0]] 0 0 {} {} > 0]} {
						>
							emit {SAMtools BCF (Binary Call Format)}
							if {[N lelong [R [I [R -4] long 0 + 0 0]] 0 0 {} {} > 0]} {
								>
									if {[S search [R 0] 0 {} 100 eq \#\#samtoolsVersion=]} {
										>
											if {[S string [R 0] 0 {} {} x {}]} {
												>
													emit {\b, generated by SAMtools version %s}
												<
											}
	
										<
									}
	
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq BCF\2\1]} {
		>
			emit {Binary Call Format (BCF) version 2.1}
			if {[N lelong [R 0] 0 0 {} {} > 0]} {
				>
					if {[S search [R 0] 0 {} 100 eq \#\#samtoolsVersion=]} {
						>
							if {[S string [R 0] 0 {} {} x {}]} {
								>
									emit {\b, generated by SAMtools version %s}
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq BCF\2\2]} {
		>
			emit {Binary Call Format (BCF) version 2.2}
			if {[N lelong [R 0] 0 0 {} {} > 0]} {
				>
					if {[S search [R 0] 0 {} 100 eq \#\#samtoolsVersion=]} {
						>
							if {[S string [R 0] 0 {} {} x {}]} {
								>
									emit {\b, generated by SAMtools version %s}
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S search 0 0 {} 100 eq \#\#fileformat=VCFv]} {
		>
			emit {Variant Call Format (VCF)}
			if {[S string [R 0] 0 {} {} x {}]} {
				>
					emit {\b version %s}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq @HD\t]} {
		>
			if {[S search 4 0 {} 100 eq VN:]} {
				>
					emit {Sequence Alignment/Map (SAM), with header}
					if {[S regex [R 0] 0 {} {} eq \[0-9.\]+]} {
						>
							emit {\b version %s}
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S regex 0 0 {} {} eq ^\[!-?A-~\]\{1,255\}(\t\[^\t\]+)\{11\}]} {
		>
			if {[S regex 0 0 {} {} eq ^(\[^\t\]+\t)\{1\}\[0-9\]\{1,5\}\t]} {
				>
					if {[S regex 0 0 {} {} eq ^(\[^\t\]+\t)\{2\}\\*|\[^*=\]*\t]} {
						>
							if {[S regex 0 0 {} {} eq ^(\[^\t\]+\t)\{3\}\[0-9\]\{1,9\}\t]} {
								>
									if {[S regex 0 0 {} {} eq ^(\[^\t\]+\t)\{4\}\[0-9\]\{1,3\}\t]} {
										>
											if {[S regex 0 0 {} {} eq \t(\\*|(\[0-9\]+\[MIDNSHPX=\])+)\t]} {
												>
													if {[S regex 0 0 {} {} eq \t(\\*|=|\[!-()+->?-~\]\[!-~\]*)\t]} {
														>
															if {[S regex 0 0 {} {} eq ^(\[^\t\]+\t)\{7\}\[0-9\]\{1,9\}\t]} {
																>
																	if {[S regex 0 0 {} {} eq \t\[+-\]\{0,1\}\[0-9\]\{1,9\}\t.*\t]} {
																		>
																			if {[S regex 0 0 {} {} eq ^(\[^\t\]+\t)\{9\}(\\*|\[A-Za-z=.\]+)\t]} {
																				>
																					if {[S regex 0 0 {} {} eq ^(\[^\t\]+\t)\{10\}\[!-~\]+]} {
																						>
																							emit {Sequence Alignment/Map (SAM)}
																							if {[S regex 0 0 {} {} eq ^\[@\]HD\t.*VN:]} {
																								>
																									emit {\b, with header}
																									if {[S regex [R 0] 0 {} {} eq \[0-9.\]+]} {
																										>
																											emit {\b version %s}
																										<
																									}
	
																								<
																							}
	
																						<
																					}
	
																				<
																			}
	
																		<
																	}
	
																<
															}
	
														<
													}
	
												<
											}
	
										<
									}
	
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[N belong 5 0 0 {} {} == 0]} {
		>
			if {[N belong 8 0 0 {} {} == 2101256]} {
				>
					emit {BlackBerry RIM ETP file}
					if {[S string 22 0 {} {} x {}]} {
						>
							emit {\b for %s}
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq C\0\0\0R\0\0\0]} {
		>
			emit BLCR
			switch [Nv lelong 16 0 {} {}] {
				1 {
					>
						emit x86
					<
				}
				3 {
					>
						emit alpha
					<
				}
				5 {
					>
						emit x86-64
					<
				}
				7 {
					>
						emit ARM
					<
				}
			}
	
			if {[N lelong 8 0 0 {} {} x {}]} {
				>
					emit {context data (little endian, version %d)}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \0\0\0C\0\0\0R]} {
		>
			emit BLCR
			switch [Nv belong 16 0 {} {}] {
				2 {
					>
						emit SPARC
					<
				}
				4 {
					>
						emit ppc
					<
				}
				6 {
					>
						emit ppc64
					<
				}
				7 {
					>
						emit ARMEB
					<
				}
				8 {
					>
						emit SPARC64
					<
				}
			}
	
			if {[N belong 8 0 0 {} {} x {}]} {
				>
					emit {context data (big endian, version %d)}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq BLENDER]} {
		>
			emit Blender3D,
			if {[S string 7 0 {} {} eq _]} {
				>
					emit {saved as 32-bits}
					if {[S string 8 0 {} {} eq v]} {
						>
							emit {little endian}
							if {[N byte 9 0 0 {} {} x {}]} {
								>
									emit {with version %c.}
								<
							}
	
							if {[N byte 10 0 0 {} {} x {}]} {
								>
									emit {\b%c}
								<
							}
	
							if {[N byte 11 0 0 {} {} x {}]} {
								>
									emit {\b%c}
								<
							}
	
							if {[S string 64 0 {} {} eq GLOB]} {
								>
									emit {\b.}
									if {[N leshort 88 0 0 {} {} x {}]} {
										>
											emit {\b%.4d}
										<
									}
	
								<
							}
	
						<
					}
	
					if {[S string 8 0 {} {} eq V]} {
						>
							emit {big endian}
							if {[N byte 9 0 0 {} {} x {}]} {
								>
									emit {with version %c.}
								<
							}
	
							if {[N byte 10 0 0 {} {} x {}]} {
								>
									emit {\b%c}
								<
							}
	
							if {[N byte 11 0 0 {} {} x {}]} {
								>
									emit {\b%c}
								<
							}
	
							if {[S string 64 0 {} {} eq GLOB]} {
								>
									emit {\b.}
									if {[N beshort 88 0 0 {} {} x {}]} {
										>
											emit {\b%.4d}
										<
									}
	
								<
							}
	
						<
					}
	
				<
			}
	
			if {[S string 7 0 {} {} eq -]} {
				>
					emit {saved as 64-bits}
					if {[S string 8 0 {} {} eq v]} {
						>
							emit {little endian}
						<
					}
	
					if {[N byte 9 0 0 {} {} x {}]} {
						>
							emit {with version %c.}
						<
					}
	
					if {[N byte 10 0 0 {} {} x {}]} {
						>
							emit {\b%c}
						<
					}
	
					if {[N byte 11 0 0 {} {} x {}]} {
						>
							emit {\b%c}
						<
					}
	
					if {[S string 68 0 {} {} eq GLOB]} {
						>
							emit {\b.}
							if {[N leshort 96 0 0 {} {} x {}]} {
								>
									emit {\b%.4d}
								<
							}
	
						<
					}
	
					if {[S string 8 0 {} {} eq V]} {
						>
							emit {big endian}
							if {[N byte 9 0 0 {} {} x {}]} {
								>
									emit {with version %c.}
								<
							}
	
							if {[N byte 10 0 0 {} {} x {}]} {
								>
									emit {\b%c}
								<
							}
	
							if {[N byte 11 0 0 {} {} x {}]} {
								>
									emit {\b%c}
								<
							}
	
							if {[S string 68 0 {} {} eq GLOB]} {
								>
									emit {\b.}
									if {[N beshort 96 0 0 {} {} x {}]} {
										>
											emit {\b%.4d}
										<
									}
	
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \#!BPY]} {
		>
			emit {Blender3D BPython script}
		<
	}
	
	if {[S string 0 0 {} {} eq !<bout>]} {
		>
			emit {b.out archive}
			if {[S string 8 0 {} {} eq __.SYMDEF]} {
				>
					emit {random library}
				<
			}
	
		<
	}
	
	switch [Nv belong 0 0 & 16777215] {
		65799 {
			>
				emit {a.out SunOS mc68010}
				if {[N byte 0 0 0 {} {} & -128]} {
					>
						emit {dynamically linked executable}
					<
				}
	
				if {[N byte 0 0 0 {} {} ^ -128]} {
					>
						emit executable
					<
				}
	
				if {[N belong 16 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		65800 {
			>
				emit {a.out SunOS mc68010 pure}
				if {[N byte 0 0 0 {} {} & -128]} {
					>
						emit {dynamically linked executable}
					<
				}
	
				if {[N byte 0 0 0 {} {} ^ -128]} {
					>
						emit executable
					<
				}
	
				if {[N belong 16 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		65803 {
			>
				emit {a.out SunOS mc68010 demand paged}
				if {[N byte 0 0 0 {} {} & -128]} {
					>
						if {[N belong 20 0 0 {} {} < 4096]} {
							>
								emit {shared library}
							<
						}
	
						if {[N belong 20 0 0 {} {} == 4096]} {
							>
								emit {dynamically linked executable}
							<
						}
	
						if {[N belong 20 0 0 {} {} > 4096]} {
							>
								emit {dynamically linked executable}
							<
						}
	
					<
				}
	
				if {[N byte 0 0 0 {} {} ^ -128]} {
					>
						emit executable
					<
				}
	
				if {[N belong 16 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		131335 {
			>
				emit {a.out SunOS mc68020}
				if {[N byte 0 0 0 {} {} & -128]} {
					>
						emit {dynamically linked executable}
					<
				}
	
				if {[N byte 0 0 0 {} {} ^ -128]} {
					>
						emit executable
					<
				}
	
				if {[N belong 16 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		131336 {
			>
				emit {a.out SunOS mc68020 pure}
				if {[N byte 0 0 0 {} {} & -128]} {
					>
						emit {dynamically linked executable}
					<
				}
	
				if {[N byte 0 0 0 {} {} ^ -128]} {
					>
						emit executable
					<
				}
	
				if {[N belong 16 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		131339 {
			>
				emit {a.out SunOS mc68020 demand paged}
				if {[N byte 0 0 0 {} {} & -128]} {
					>
						if {[N belong 20 0 0 {} {} < 4096]} {
							>
								emit {shared library}
							<
						}
	
						if {[N belong 20 0 0 {} {} == 4096]} {
							>
								emit {dynamically linked executable}
							<
						}
	
						if {[N belong 20 0 0 {} {} > 4096]} {
							>
								emit {dynamically linked executable}
							<
						}
	
					<
				}
	
				if {[N byte 0 0 0 {} {} ^ -128]} {
					>
						emit executable
					<
				}
	
				if {[N belong 16 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		196871 {
			>
				emit SPARC
				if {[N byte 0 0 0 {} {} & -128]} {
					>
						emit {dynamically linked executable}
					<
				}
	
				if {[N byte 0 0 0 {} {} ^ -128]} {
					>
						emit executable
					<
				}
	
				if {[N belong 16 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				if {[N belong 36 0 0 {} {} == -1274019839]} {
					>
						emit {(uses shared libs)}
					<
				}
	
			<
			>
				emit {a.out SunOS SPARC}
				if {[N byte 0 0 0 {} {} & -128]} {
					>
						emit {dynamically linked executable}
					<
				}
	
				if {[N byte 0 0 0 {} {} ^ -128]} {
					>
						emit executable
					<
				}
	
				if {[N belong 16 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		196872 {
			>
				emit {SPARC pure}
				if {[N byte 0 0 0 {} {} & -128]} {
					>
						emit {dynamically linked executable}
					<
				}
	
				if {[N byte 0 0 0 {} {} ^ -128]} {
					>
						emit executable
					<
				}
	
				if {[N belong 16 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				if {[N belong 36 0 0 {} {} == -1274019839]} {
					>
						emit {(uses shared libs)}
					<
				}
	
			<
			>
				emit {a.out SunOS SPARC pure}
				if {[N byte 0 0 0 {} {} & -128]} {
					>
						emit {dynamically linked executable}
					<
				}
	
				if {[N byte 0 0 0 {} {} ^ -128]} {
					>
						emit executable
					<
				}
	
				if {[N belong 16 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		196875 {
			>
				emit {SPARC demand paged}
				if {[N byte 0 0 0 {} {} & -128]} {
					>
						if {[N belong 20 0 0 {} {} < 4096]} {
							>
								emit {shared library}
							<
						}
	
						if {[N belong 20 0 0 {} {} == 4096]} {
							>
								emit {dynamically linked executable}
							<
						}
	
						if {[N belong 20 0 0 {} {} > 4096]} {
							>
								emit {dynamically linked executable}
							<
						}
	
					<
				}
	
				if {[N byte 0 0 0 {} {} ^ -128]} {
					>
						emit executable
					<
				}
	
				if {[N belong 16 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
				if {[N belong 36 0 0 {} {} == -1274019839]} {
					>
						emit {(uses shared libs)}
					<
				}
	
			<
			>
				emit {a.out SunOS SPARC demand paged}
				if {[N byte 0 0 0 {} {} & -128]} {
					>
						if {[N belong 20 0 0 {} {} < 4096]} {
							>
								emit {shared library}
							<
						}
	
						if {[N belong 20 0 0 {} {} == 4096]} {
							>
								emit {dynamically linked executable}
							<
						}
	
						if {[N belong 20 0 0 {} {} > 4096]} {
							>
								emit {dynamically linked executable}
							<
						}
	
					<
				}
	
				if {[N byte 0 0 0 {} {} ^ -128]} {
					>
						emit executable
					<
				}
	
				if {[N belong 16 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
	}
	
	if {[S string 0 0 {} {} eq XIA1]} {
		>
			emit {Chiasmus encrypted data}
		<
	}
	
	if {[S string 0 0 {} {} eq XIS]} {
		>
			emit {Chiasmus key}
		<
	}
	
	if {[S string 0 0 {} {} eq btsnoop\0]} {
		>
			emit BTSnoop
			if {[N belong 8 0 0 {} {} x {}]} {
				>
					emit {version %d,}
				<
			}
	
			switch [Nv belong 12 0 {} {}] {
				1001 {
					>
						emit {Unencapsulated HCI}
					<
				}
				1002 {
					>
						emit {HCI UART (H4)}
					<
				}
				1003 {
					>
						emit {HCI BCSP}
					<
				}
				1004 {
					>
						emit {HCI Serial (H5)}
						if {[N belong 12 0 0 {} {} x {}]} {
							>
								emit {type %d}
							<
						}
	
					<
				}
			}
	
		<
	}
	
	switch [Nv belong 91392 0 {} {}] {
		302072064 {
			>
				emit {D64 Image}
			<
		}
		302072192 {
			>
				emit {D71 Image}
			<
		}
	}
	
	if {[N belong 399360 0 0 {} {} == 671302656]} {
		>
			emit {D81 Image}
		<
	}
	
	if {[S string 0 0 {} {} eq C64\40CARTRIDGE]} {
		>
			emit {CCS C64 Emultar Cartridge Image}
		<
	}
	
	if {[S string 0 0 {} {} eq GCR-1541]} {
		>
			emit {GCR Image}
			if {[N byte 8 0 0 {} {} x {}]} {
				>
					emit {version: %i}
				<
			}
	
			if {[N byte 9 0 0 {} {} x {}]} {
				>
					emit {tracks: %i}
				<
			}
	
		<
	}
	
	if {[S string 9 0 {} {} eq PSUR]} {
		>
			emit {ARC archive (c64)}
		<
	}
	
	if {[S string 2 0 {} {} eq -LH1-]} {
		>
			emit {LHA archive (c64)}
		<
	}
	
	if {[S string 0 0 {} {} eq C64File]} {
		>
			emit {PC64 Emulator file}
			if {[S string 8 0 {} {} > \0]} {
				>
					emit {"%s"}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq C64Image]} {
		>
			emit {PC64 Freezer Image}
		<
	}
	
	if {[S string 0 0 {} {} eq CBM\144\0\0]} {
		>
			emit {Power 64 C64 Emulator Snapshot}
		<
	}
	
	if {[S string 0 0 {} {} eq C64S\x20tape\x20file]} {
		>
			emit {T64 tape Image}
			if {[N leshort 32 0 0 {} {} x {}]} {
				>
					emit Version:0x%x
				<
			}
	
			if {[N leshort 36 0 0 {} {} != 0]} {
				>
					emit Entries:%i
				<
			}
	
			if {[S string 40 0 {} {} x {}]} {
				>
					emit Name:%.24s
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq C64\x20tape\x20image\x20file\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0]} {
		>
			emit {T64 tape Image}
			if {[N leshort 32 0 0 {} {} x {}]} {
				>
					emit Version:0x%x
				<
			}
	
			if {[N leshort 36 0 0 {} {} != 0]} {
				>
					emit Entries:%i
				<
			}
	
			if {[S string 40 0 {} {} x {}]} {
				>
					emit Name:%.24s
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq C64S\x20tape\x20image\x20file\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0]} {
		>
			emit {T64 tape Image}
			if {[N leshort 32 0 0 {} {} x {}]} {
				>
					emit Version:0x%x
				<
			}
	
			if {[N leshort 36 0 0 {} {} != 0]} {
				>
					emit Entries:%i
				<
			}
	
			if {[S string 40 0 {} {} x {}]} {
				>
					emit Name:%.24s
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq C64-TAPE-RAW]} {
		>
			emit {C64 Raw Tape File (.tap),}
			if {[N byte 12 0 0 {} {} x {}]} {
				>
					emit Version:%u,
				<
			}
	
			if {[N lelong 16 0 0 {} {} x {}]} {
				>
					emit {Length:%u cycles}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq GTS5]} {
		>
			emit {GoatTracker 2 song}
			if {[S string 4 0 {} {} > \0]} {
				>
					emit {\b, "%s"}
				<
			}
	
			if {[S string 36 0 {} {} > \0]} {
				>
					emit {\b by %s}
				<
			}
	
			if {[S string 68 0 {} {} > \0]} {
				>
					emit {\b (C) %s}
				<
			}
	
			if {[N byte 100 0 0 {} {} > 0]} {
				>
					emit {\b, %u subsong(s)}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \010\011\376]} {
		>
			emit Microstation
			if {[S string 3 0 {} {} eq \002]} {
				>
					if {[S string 30 0 {} {} eq \026\105]} {
						>
							emit DGNFile
						<
					}
	
					if {[S string 30 0 {} {} eq \034\105]} {
						>
							emit DGNFile
						<
					}
	
					if {[S string 30 0 {} {} eq \073\107]} {
						>
							emit DGNFile
						<
					}
	
					if {[S string 30 0 {} {} eq \073\110]} {
						>
							emit DGNFile
						<
					}
	
					if {[S string 30 0 {} {} eq \106\107]} {
						>
							emit DGNFile
						<
					}
	
					if {[S string 30 0 {} {} eq \110\103]} {
						>
							emit DGNFile
						<
					}
	
					if {[S string 30 0 {} {} eq \120\104]} {
						>
							emit DGNFile
						<
					}
	
					if {[S string 30 0 {} {} eq \172\104]} {
						>
							emit DGNFile
						<
					}
	
					if {[S string 30 0 {} {} eq \172\105]} {
						>
							emit DGNFile
						<
					}
	
					if {[S string 30 0 {} {} eq \172\106]} {
						>
							emit DGNFile
						<
					}
	
					if {[S string 30 0 {} {} eq \234\106]} {
						>
							emit DGNFile
						<
					}
	
					if {[S string 30 0 {} {} eq \273\105]} {
						>
							emit DGNFile
						<
					}
	
					if {[S string 30 0 {} {} eq \306\106]} {
						>
							emit DGNFile
						<
					}
	
					if {[S string 30 0 {} {} eq \310\104]} {
						>
							emit DGNFile
						<
					}
	
					if {[S string 30 0 {} {} eq \341\104]} {
						>
							emit DGNFile
						<
					}
	
					if {[S string 30 0 {} {} eq \372\103]} {
						>
							emit DGNFile
						<
					}
	
					if {[S string 30 0 {} {} eq \372\104]} {
						>
							emit DGNFile
						<
					}
	
					if {[S string 30 0 {} {} eq \372\106]} {
						>
							emit DGNFile
						<
					}
	
					if {[S string 30 0 {} {} eq \376\103]} {
						>
							emit DGNFile
						<
					}
	
				<
			}
	
			if {[S string 4 0 {} {} eq \030\000\000]} {
				>
					emit CITFile
				<
			}
	
			if {[S string 4 0 {} {} eq \030\000\003]} {
				>
					emit CITFile
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq MC0.0]} {
		>
			emit {DWG AutoDesk AutoCAD Release 1.0}
			mime image/vnd.dwg
		<
	}
	
	if {[S string 0 0 {} {} eq AC1.2]} {
		>
			emit {DWG AutoDesk AutoCAD Release 1.2}
			mime image/vnd.dwg
		<
	}
	
	if {[S string 0 0 {} {} eq AC1.3]} {
		>
			emit {DWG AutoDesk AutoCAD Release 1.3}
			mime image/vnd.dwg
		<
	}
	
	if {[S string 0 0 {} {} eq AC1.40]} {
		>
			emit {DWG AutoDesk AutoCAD Release 1.40}
			mime image/vnd.dwg
		<
	}
	
	if {[S string 0 0 {} {} eq AC1.50]} {
		>
			emit {DWG AutoDesk AutoCAD Release 2.05}
			mime image/vnd.dwg
		<
	}
	
	if {[S string 0 0 {} {} eq AC2.10]} {
		>
			emit {DWG AutoDesk AutoCAD Release 2.10}
			mime image/vnd.dwg
		<
	}
	
	if {[S string 0 0 {} {} eq AC2.21]} {
		>
			emit {DWG AutoDesk AutoCAD Release 2.21}
			mime image/vnd.dwg
		<
	}
	
	if {[S string 0 0 {} {} eq AC2.22]} {
		>
			emit {DWG AutoDesk AutoCAD Release 2.22}
			mime image/vnd.dwg
		<
	}
	
	if {[S string 0 0 {} {} eq AC1001]} {
		>
			emit {DWG AutoDesk AutoCAD Release 2.22}
			mime image/vnd.dwg
		<
	}
	
	if {[S string 0 0 {} {} eq AC1002]} {
		>
			emit {DWG AutoDesk AutoCAD Release 2.50}
			mime image/vnd.dwg
		<
	}
	
	if {[S string 0 0 {} {} eq AC1003]} {
		>
			emit {DWG AutoDesk AutoCAD Release 2.60}
			mime image/vnd.dwg
		<
	}
	
	if {[S string 0 0 {} {} eq AC1004]} {
		>
			emit {DWG AutoDesk AutoCAD Release 9}
			mime image/vnd.dwg
		<
	}
	
	if {[S string 0 0 {} {} eq AC1006]} {
		>
			emit {DWG AutoDesk AutoCAD Release 10}
			mime image/vnd.dwg
		<
	}
	
	if {[S string 0 0 {} {} eq AC1009]} {
		>
			emit {DWG AutoDesk AutoCAD Release 11/12}
			mime image/vnd.dwg
		<
	}
	
	if {[S string 0 0 {} {} eq AC1012]} {
		>
			emit {DWG AutoDesk AutoCAD Release 13}
			mime image/vnd.dwg
		<
	}
	
	if {[S string 0 0 {} {} eq AC1014]} {
		>
			emit {DWG AutoDesk AutoCAD Release 14}
			mime image/vnd.dwg
		<
	}
	
	if {[S string 0 0 {} {} eq AC1015]} {
		>
			emit {DWG AutoDesk AutoCAD 2000/2002}
			mime image/vnd.dwg
		<
	}
	
	if {[S string 0 0 {} {} eq AC1018]} {
		>
			emit {DWG AutoDesk AutoCAD 2004/2005/2006}
			mime image/vnd.dwg
		<
	}
	
	if {[S string 0 0 {} {} eq AC1021]} {
		>
			emit {DWG AutoDesk AutoCAD 2007/2008/2009}
			mime image/vnd.dwg
		<
	}
	
	if {[S string 0 0 {} {} eq AC1024]} {
		>
			emit {DWG AutoDesk AutoCAD 2010/2011/2012}
			mime image/vnd.dwg
		<
	}
	
	if {[S string 0 0 {} {} eq AC1027]} {
		>
			emit {DWG AutoDesk AutoCAD 2013/2014}
			mime image/vnd.dwg
		<
	}
	
	if {[S string 0 0 {} {} eq KF]} {
		>
			switch [Nv belong 2 0 {} {}] {
				-201293819 {
					>
						emit {Kompas drawing 5.9R01.003}
					<
				}
				83886087 {
					>
						emit {Kompas drawing 7.0}
					<
				}
				83886089 {
					>
						emit {Kompas drawing 9.0}
					<
				}
				134217737 {
					>
						emit {Kompas drawing 9.0 SP1}
					<
				}
				150994950 {
					>
						emit {Kompas drawing 6.0}
					<
				}
				285245445 {
					>
						emit {Kompas drawing 5.8R01.003}
					<
				}
				419467269 {
					>
						emit {Kompas drawing 5.10R01}
					<
				}
				436207624 {
					>
						emit {Kompas drawing 8.0}
					<
				}
				469794821 {
					>
						emit {Kompas drawing 5.9R01.002}
					<
				}
				553684997 {
					>
						emit {Kompas drawing 5.10R02 febr}
					<
				}
				554696714 {
					>
						emit {Kompas drawing 10.0}
					<
				}
				570462213 {
					>
						emit {Kompas drawing 5.10R03}
					<
					>
						emit {Kompas drawing 5.10R02 mar}
					<
				}
				588251146 {
					>
						emit {Kompas drawing 10.0 SP1}
					<
				}
				738263303 {
					>
						emit {Kompas drawing 7+}
					<
				}
				822083595 {
					>
						emit {Kompas drawing 11.0}
					<
				}
				838860806 {
					>
						emit {Kompas drawing 6+}
					<
				}
				838860811 {
					>
						emit {Kompas drawing 11.0 SP1}
					<
				}
				855703560 {
					>
						emit {Kompas drawing 8+}
					<
				}
				1291845644 {
					>
						emit {Kompas drawing 12.0}
					<
				}
				1308622860 {
					>
						emit {Kompas drawing 12.0 SP1}
					<
				}
				1358991365 {
					>
						emit {Kompas drawing 5.11R01}
					<
				}
				1409323013 {
					>
						emit {Kompas drawing 5.11R02}
					<
				}
				1543540741 {
					>
						emit {Kompas drawing 5.11R03}
					<
				}
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq MegaCad23\0]} {
		>
			emit {MegaCAD 2D/3D drawing}
		<
	}
	
	if {[S string 0 0 {} {} eq \;\;\020HSF\020V]} {
		>
			emit {OpenHSF (Hoops Stream Format)}
			if {[S regex 7 0 {} 9 eq V\[.0-9\]\{4,5\}\020]} {
				>
					emit %s
					ext hsf
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \xd9\xd9\xf7]} {
		>
			emit {Concise Binary Object Representation (CBOR) container}
			if {[N ubyte 3 0 0 {} {} < 32]} {
				>
					emit {(positive integer)}
				<
			}
	
			if {[N ubyte 3 0 0 {} {} < 64]} {
				>
					if {[N ubyte 3 0 0 {} {} > 31]} {
						>
							emit {(negative integer)}
						<
					}
	
				<
			}
	
			if {[N ubyte 3 0 0 {} {} < 96]} {
				>
					if {[N ubyte 3 0 0 {} {} > 63]} {
						>
							emit {(byte string)}
						<
					}
	
				<
			}
	
			if {[N ubyte 3 0 0 {} {} < 128]} {
				>
					if {[N ubyte 3 0 0 {} {} > 95]} {
						>
							emit {(text string)}
						<
					}
	
				<
			}
	
			if {[N ubyte 3 0 0 {} {} < 160]} {
				>
				<
			}
	
			if {[N ubyte 3 0 0 {} {} > 127]} {
				>
					emit (array)
				<
			}
	
			if {[N ubyte 3 0 0 {} {} < 192]} {
				>
					if {[N ubyte 3 0 0 {} {} > 159]} {
						>
							emit (map)
						<
					}
	
				<
			}
	
			if {[N ubyte 3 0 0 {} {} < 224]} {
				>
					if {[N ubyte 3 0 0 {} {} > 191]} {
						>
							emit (tagged)
						<
					}
	
				<
			}
	
			if {[N ubyte 3 0 0 {} {} > 223]} {
				>
					emit (other)
				<
			}
	
			mime application/cbor
		<
	}
	
	if {[S search 0 0 w 1 eq \#\040xmcd]} {
		>
			emit {CDDB(tm) format CD text data}
		<
	}
	
	if {[S string 0 0 {} {} eq \{title]} {
		>
			emit {Chord text file}
		<
	}
	
	if {[S string 0 0 {} {} eq ptab\003\000]} {
		>
			emit {Power-Tab v3 Tablature File}
		<
	}
	
	if {[S string 0 0 {} {} eq ptab\004\000]} {
		>
			emit {Power-Tab v4 Tablature File}
		<
	}
	
	if {[S string 0 0 {} {} eq RuneCT]} {
		>
			emit {Citrus locale declaration for LC_CTYPE}
		<
	}
	
	if {[S search 0 0 {} 8192 eq \"libhdr\"]} {
		>
			emit {BCPL source text}
			mime text/x-bcpl
		<
	}
	
	if {[S search 0 0 {} 8192 eq \"LIBHDR\"]} {
		>
			emit {BCPL source text}
			mime text/x-bcpl
		<
	}
	
	if {[S regex 0 0 {} {} eq ^\#include]} {
		>
			emit C
			if {[S regex 0 0 {} {} eq ^class\[\[:space:\]\]+]} {
				>
					if {[S regex [R 0] 0 {} {} eq \\\{\[.*\]\\\}(\;)?\$]} {
						>
							emit {\b++}
						<
					}
	
				<
			}
	
			if {[S clear [R 0] 0 {} {} x {}]} {
				>
					emit {source text}
					mime text/x-c
					strength {+ 13}
				<
			}
	
		<
	}
	
	if {[S regex 0 0 {} {} eq ^\#\[\[:space:\]\]*pragma]} {
		>
			emit {C source text}
			mime text/x-c
		<
	}
	
	if {[S regex 0 0 {} {} eq ^\#\[\[:space:\]\]*(if|ifn)def]} {
		>
			if {[S regex [R 0] 0 {} {} eq ^\#\[\[:space:\]\]*endif\$]} {
				>
					emit {C source text}
					mime text/x-c
				<
			}
	
		<
	}
	
	if {[S regex 0 0 {} {} eq ^\#\[\[:space:\]\]*(if|ifn)def]} {
		>
			if {[S regex [R 0] 0 {} {} eq ^\#\[\[:space:\]\]*define]} {
				>
					emit {C source text}
					mime text/x-c
				<
			}
	
		<
	}
	
	if {[S regex 0 0 {} {} eq ^\[\[:space:\]\]*char(\ \\*|\\*)(.+)(=.*)?\;\[\[:space:\]\]*\$]} {
		>
			emit {C source text}
			mime text/x-c
		<
	}
	
	if {[S regex 0 0 {} {} eq ^\[\[:space:\]\]*double(\ \\*|\\*)(.+)(=.*)?\;\[\[:space:\]\]*\$]} {
		>
			emit {C source text}
			mime text/x-c
		<
	}
	
	if {[S regex 0 0 {} {} eq ^\[\[:space:\]\]*extern\[\[:space:\]\]+]} {
		>
			emit {C source text}
			mime text/x-c
		<
	}
	
	if {[S regex 0 0 {} {} eq ^\[\[:space:\]\]*float(\ \\*|\\*)(.+)(=.*)?\;\[\[:space:\]\]*\$]} {
		>
			emit {C source text}
			mime text/x-c
		<
	}
	
	if {[S regex 0 0 {} {} eq ^struct\[\[:space:\]\]+]} {
		>
			emit {C source text}
			mime text/x-c
		<
	}
	
	if {[S regex 0 0 {} {} eq ^union\[\[:space:\]\]+]} {
		>
			emit {C source text}
			mime text/x-c
		<
	}
	
	if {[S search 0 0 {} 8192 eq main(]} {
		>
			if {[S regex [R 0] 0 {} {} eq \\)\[\[:space:\]\]*\\\{]} {
				>
					emit {C source text}
					mime text/x-c
				<
			}
	
		<
	}
	
	if {[S regex 0 0 {} {} eq ^namespace\[\[:space:\]\]+\[_\[:alpha:\]\]\{1,30\}\[\[:space:\]\]*\\\{]} {
		>
			emit {C++ source text}
			mime text/x-c++
			strength {+ 30}
		<
	}
	
	if {[S regex 0 0 {} {} eq ^using\[\[:space:\]\]+(namespace\ )?std(::)?\[\[:alpha:\]\]*\[\[:space:\]\]*\;]} {
		>
			emit {C++ source text}
			mime text/x-c++
			strength {+ 30}
		<
	}
	
	if {[S regex 0 0 {} {} eq ^\[\[:space:\]\]*template\[\[:space:\]\]*<.*>\[\[:space:\]\]*\$]} {
		>
			emit {C++ source text}
			mime text/x-c++
			strength {+ 30}
		<
	}
	
	if {[S regex 0 0 {} {} eq ^\[\[:space:\]\]*virtual\[\[:space:\]\]+.*\[\}\;\]\[\[:space:\]\]*\$]} {
		>
			emit {C++ source text}
			mime text/x-c++
			strength {+ 30}
		<
	}
	
	if {[S regex 0 0 {} {} eq ^\[\[:space:\]\]*class\[\[:space:\]\]+\[\[:digit:\]\[:alpha:\]:_\]+\[\[:space:\]\]*\\\{(.*\[\n\]*)*\\\}(\;)?\$]} {
		>
			emit {C++ source text}
			mime text/x-c++
			strength {+ 13}
		<
	}
	
	if {[S regex 0 0 {} {} eq ^\[\[:space:\]\]*public:]} {
		>
			emit {C++ source text}
			mime text/x-c++
			strength {+ 30}
		<
	}
	
	if {[S regex 0 0 {} {} eq ^\[\[:space:\]\]*private:]} {
		>
			emit {C++ source text}
			mime text/x-c++
			strength {+ 30}
		<
	}
	
	if {[S regex 0 0 {} {} eq ^\[\[:space:\]\]*protected:]} {
		>
			emit {C++ source text}
			mime text/x-c++
			strength {+ 30}
		<
	}
	
	if {[S regex 0 0 {} {} eq ^\#import]} {
		>
			emit {Objective-C source text}
			mime text/x-objective-c
			strength {+ 25}
		<
	}
	
	if {[S string 0 0 {} {} eq cscope]} {
		>
			emit {cscope reference data}
			if {[S string 7 0 {} {} x {}]} {
				>
					emit {version %.2s}
				<
			}
	
			if {[S string 7 0 {} {} > 14]} {
				>
					if {[S search 10 0 {} 100 eq \ -q\ ]} {
						>
							emit {with inverted index}
						<
					}
	
				<
			}
	
			if {[S search 10 0 {} 100 eq \ -c\ ]} {
				>
					emit {text (non-compressed)}
				<
			}
	
		<
	}
	
	if {[S string 514 0 {} {} eq \377\377\377\377\000]} {
		>
			if {[S string 0 0 {} {} eq \0\0\0\0\0\0\0\0\0\0\0\0\0]} {
				>
					emit {Claris clip art}
				<
			}
	
		<
	}
	
	if {[S string 514 0 {} {} eq \377\377\377\377\001]} {
		>
			if {[S string 0 0 {} {} eq \0\0\0\0\0\0\0\0\0\0\0\0\0]} {
				>
					emit {Claris clip art}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \020\341\000\000\010\010]} {
		>
			emit {Claris Works palette files .plt}
		<
	}
	
	if {[S string 0 0 {} {} eq \002\271\262\000\040\002\000\164]} {
		>
			emit {Claris works dictionary}
		<
	}
	
	if {[S string 4 0 {} {} eq pipe]} {
		>
			emit {CLIPPER instruction trace}
		<
	}
	
	if {[S string 4 0 {} {} eq prof]} {
		>
			emit {CLIPPER instruction profile}
		<
	}
	
	if {[S string 0 0 {w t} {} eq \#!\ /bin/sh]} {
		>
			emit {POSIX shell script text executable}
			mime text/x-shellscript
		<
	}
	
	if {[S string 0 0 {w b} {} eq \#!\ /bin/sh]} {
		>
			emit {POSIX shell script executable (binary data)}
			mime text/x-shellscript
		<
	}
	
	if {[S string 0 0 {w t} {} eq \#!\ /bin/csh]} {
		>
			emit {C shell script text executable}
			mime text/x-shellscript
		<
	}
	
	if {[S string 0 0 {w t} {} eq \#!\ /bin/ksh]} {
		>
			emit {Korn shell script text executable}
			mime text/x-shellscript
		<
	}
	
	if {[S string 0 0 {w b} {} eq \#!\ /bin/ksh]} {
		>
			emit {Korn shell script executable (binary data)}
			mime text/x-shellscript
		<
	}
	
	if {[S string 0 0 {w t} {} eq \#!\ /bin/tcsh]} {
		>
			emit {Tenex C shell script text executable}
			mime text/x-shellscript
		<
	}
	
	if {[S string 0 0 {w t} {} eq \#!\ /usr/bin/tcsh]} {
		>
			emit {Tenex C shell script text executable}
			mime text/x-shellscript
		<
	}
	
	if {[S string 0 0 {w t} {} eq \#!\ /usr/local/tcsh]} {
		>
			emit {Tenex C shell script text executable}
			mime text/x-shellscript
		<
	}
	
	if {[S string 0 0 {w t} {} eq \#!\ /usr/local/bin/tcsh]} {
		>
			emit {Tenex C shell script text executable}
			mime text/x-shellscript
		<
	}
	
	if {[S string 0 0 {w t} {} eq \#!\ /bin/zsh]} {
		>
			emit {Paul Falstad's zsh script text executable}
			mime text/x-shellscript
		<
	}
	
	if {[S string 0 0 {w t} {} eq \#!\ /usr/bin/zsh]} {
		>
			emit {Paul Falstad's zsh script text executable}
			mime text/x-shellscript
		<
	}
	
	if {[S string 0 0 {w t} {} eq \#!\ /usr/local/bin/zsh]} {
		>
			emit {Paul Falstad's zsh script text executable}
			mime text/x-shellscript
		<
	}
	
	if {[S string 0 0 {w t} {} eq \#!\ /usr/local/bin/ash]} {
		>
			emit {Neil Brown's ash script text executable}
			mime text/x-shellscript
		<
	}
	
	if {[S string 0 0 {w t} {} eq \#!\ /usr/local/bin/ae]} {
		>
			emit {Neil Brown's ae script text executable}
			mime text/x-shellscript
		<
	}
	
	if {[S string 0 0 {w t} {} eq \#!\ /bin/nawk]} {
		>
			emit {new awk script text executable}
			mime text/x-nawk
		<
	}
	
	if {[S string 0 0 {w t} {} eq \#!\ /usr/bin/nawk]} {
		>
			emit {new awk script text executable}
			mime text/x-nawk
		<
	}
	
	if {[S string 0 0 {w t} {} eq \#!\ /usr/local/bin/nawk]} {
		>
			emit {new awk script text executable}
			mime text/x-nawk
		<
	}
	
	if {[S string 0 0 {w t} {} eq \#!\ /bin/gawk]} {
		>
			emit {GNU awk script text executable}
			mime text/x-gawk
		<
	}
	
	if {[S string 0 0 {w t} {} eq \#!\ /usr/bin/gawk]} {
		>
			emit {GNU awk script text executable}
			mime text/x-gawk
		<
	}
	
	if {[S string 0 0 {w t} {} eq \#!\ /usr/local/bin/gawk]} {
		>
			emit {GNU awk script text executable}
			mime text/x-gawk
		<
	}
	
	if {[S string 0 0 {w t} {} eq \#!\ /bin/awk]} {
		>
			emit {awk script text executable}
			mime text/x-awk
		<
	}
	
	if {[S string 0 0 {w t} {} eq \#!\ /usr/bin/awk]} {
		>
			emit {awk script text executable}
			mime text/x-awk
		<
	}
	
	if {[S regex 0 0 {} 4096 eq ^\[\040\t\f\r\n\]\{0,100\}BEGIN\[\040\t\f\r\n\]\{0,100\}\[\{\]]} {
		>
			emit {awk or perl script text}
		<
	}
	
	if {[S string 0 0 {w t} {} eq \#!\ /bin/rc]} {
		>
			emit {Plan 9 rc shell script text executable}
		<
	}
	
	if {[S string 0 0 {w t} {} eq \#!\ /bin/bash]} {
		>
			emit {Bourne-Again shell script text executable}
			mime text/x-shellscript
		<
	}
	
	if {[S string 0 0 {w b} {} eq \#!\ /bin/bash]} {
		>
			emit {Bourne-Again shell script executable (binary data)}
			mime text/x-shellscript
		<
	}
	
	if {[S string 0 0 {w t} {} eq \#!\ /usr/bin/bash]} {
		>
			emit {Bourne-Again shell script text executable}
			mime text/x-shellscript
		<
	}
	
	if {[S string 0 0 {w b} {} eq \#!\ /usr/bin/bash]} {
		>
			emit {Bourne-Again shell script executable (binary data)}
			mime text/x-shellscript
		<
	}
	
	if {[S string 0 0 {w t} {} eq \#!\ /usr/local/bash]} {
		>
			emit {Bourne-Again shell script text executable}
			mime text/x-shellscript
		<
	}
	
	if {[S string 0 0 {w b} {} eq \#!\ /usr/local/bash]} {
		>
			emit {Bourne-Again shell script executable (binary data)}
			mime text/x-shellscript
		<
	}
	
	if {[S string 0 0 {w t} {} eq \#!\ /usr/local/bin/bash]} {
		>
			emit {Bourne-Again shell script text executable}
			mime text/x-shellscript
		<
	}
	
	if {[S string 0 0 {w b} {} eq \#!\ /usr/local/bin/bash]} {
		>
			emit {Bourne-Again shell script executable (binary data)}
			mime text/x-shellscript
		<
	}
	
	if {[S string 0 0 {w t} {} eq \#!\ /usr/bin/env\ bash]} {
		>
			emit {Bourne-Again shell script text executable}
			mime text/x-shellscript
		<
	}
	
	if {[S search 0 0 c 1 eq <?php]} {
		>
			emit {PHP script text}
			mime text/x-php
			strength {+ 30}
		<
	}
	
	if {[S search 0 0 {} 1 eq <?\n]} {
		>
			emit {PHP script text}
			mime text/x-php
		<
	}
	
	if {[S search 0 0 {} 1 eq <?\r]} {
		>
			emit {PHP script text}
			mime text/x-php
		<
	}
	
	if {[S search 0 0 w 1 eq \#!\ /usr/local/bin/php]} {
		>
			emit {PHP script text executable}
			mime text/x-php
			strength {+ 10}
		<
	}
	
	if {[S search 0 0 w 1 eq \#!\ /usr/bin/php]} {
		>
			emit {PHP script text executable}
			mime text/x-php
			strength {+ 10}
		<
	}
	
	if {[S string 0 0 {} {} eq <?php]} {
		>
			if {[S regex 5 0 {} {} eq \[\ \n\]]} {
				>
					if {[S string 6 0 {} {} eq /*\ Smarty\ version]} {
						>
							emit {Smarty compiled template}
							if {[S regex 24 0 {} {} eq \[0-9.\]+]} {
								>
									emit {\b, version %s}
									mime text/x-php
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq Zend\x00]} {
		>
			emit {PHP script Zend Optimizer data}
		<
	}
	
	if {[S string 0 0 t {} eq \$!]} {
		>
			emit {DCL command file}
		<
	}
	
	if {[S string 0 0 {} {} eq \#!/usr/bin/pdmenu]} {
		>
			emit {Pdmenu configuration file text}
		<
	}
	
	if {[S string 0 0 {} {} eq \x0b\x13\x08\x00]} {
		>
			if {[N uleshort 4 0 0 {} {} < 4]} {
				>
					emit {ksh byte-code version %d}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \$Suite]} {
		>
			emit {TTCN Abstract Test Suite}
			if {[S string [R 1] 0 {} {} eq \$SuiteId]} {
				>
					if {[S string [R 1] 0 {} {} > \n]} {
						>
							emit %s
						<
					}
	
				<
			}
	
			if {[S string [R 2] 0 {} {} eq \$SuiteId]} {
				>
					if {[S string [R 1] 0 {} {} > \n]} {
						>
							emit %s
						<
					}
	
				<
			}
	
			if {[S string [R 3] 0 {} {} eq \$SuiteId]} {
				>
					if {[S string [R 1] 0 {} {} > \n]} {
						>
							emit %s
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq mscdocument]} {
		>
			emit {Message Sequence Chart (document)}
		<
	}
	
	if {[S string 0 0 {} {} eq msc]} {
		>
			emit {Message Sequence Chart (chart)}
		<
	}
	
	if {[S string 0 0 {} {} eq submsc]} {
		>
			emit {Message Sequence Chart (subchart)}
		<
	}
	
	if {[S string 0 0 {} {} eq \037\235]} {
		>
			emit {compress'd data}
			if {[N byte 2 0 0 & -128 > 0]} {
				>
					emit {block compressed}
				<
			}
	
			if {[N byte 2 0 0 & 31 x {}]} {
				>
					emit {%d bits}
				<
			}
	
			mime application/x-compress
		<
	}
	
	if {[S string 0 0 {} {} eq \037\213]} {
		>
			emit {gzip compressed data}
			if {[N byte 2 0 0 {} {} < 8]} {
				>
					emit {\b, reserved method}
				<
			}
	
			if {[N byte 2 0 0 {} {} > 8]} {
				>
					emit {\b, unknown method}
				<
			}
	
			if {[N byte 3 0 0 {} {} & 1]} {
				>
					emit {\b, ASCII}
				<
			}
	
			if {[N byte 3 0 0 {} {} & 2]} {
				>
					emit {\b, has CRC}
				<
			}
	
			if {[N byte 3 0 0 {} {} & 4]} {
				>
					emit {\b, extra field}
				<
			}
	
			if {[N byte 3 0 0 & 12 == 8]} {
				>
					if {[S string 10 0 {} {} x {}]} {
						>
							emit {\b, was "%s"}
						<
					}
	
				<
			}
	
			if {[N byte 3 0 0 {} {} & 16]} {
				>
					emit {\b, has comment}
				<
			}
	
			if {[N byte 3 0 0 {} {} & 32]} {
				>
					emit {\b, encrypted}
				<
			}
	
			if {[N ledate 4 0 0 {} {} > 0]} {
				>
					emit {\b, last modified: %s}
				<
			}
	
			switch [Nv byte 8 0 {} {}] {
				2 {
					>
						emit {\b, max compression}
					<
				}
				4 {
					>
						emit {\b, max speed}
					<
				}
			}
	
			switch [Nv byte 9 0 {} {}] {
				0 {
					>
						emit {\b, from FAT filesystem (MS-DOS, OS/2, NT)}
					<
				}
				1 {
					>
						emit {\b, from Amiga}
					<
				}
				2 {
					>
						emit {\b, from VMS}
					<
				}
				3 {
					>
						emit {\b, from Unix}
					<
				}
				4 {
					>
						emit {\b, from VM/CMS}
					<
				}
				5 {
					>
						emit {\b, from Atari}
					<
				}
				6 {
					>
						emit {\b, from HPFS filesystem (OS/2, NT)}
					<
				}
				7 {
					>
						emit {\b, from MacOS}
					<
				}
				8 {
					>
						emit {\b, from Z-System}
					<
				}
				9 {
					>
						emit {\b, from CP/M}
					<
				}
				10 {
					>
						emit {\b, from TOPS/20}
					<
				}
				11 {
					>
						emit {\b, from NTFS filesystem (NT)}
					<
				}
				12 {
					>
						emit {\b, from QDOS}
					<
				}
				13 {
					>
						emit {\b, from Acorn RISCOS}
					<
				}
			}
	
			if {[N lelong -4 0 0 {} {} x {}]} {
				>
					emit {\b, original size %d}
				<
			}
	
			mime application/x-gzip
			strength {* 2}
		<
	}
	
	if {[S string 0 0 {} {} eq \037\036]} {
		>
			emit {packed data}
			if {[N belong 2 0 0 {} {} > 1]} {
				>
					emit {\b, %d characters originally}
				<
			}
	
			if {[N belong 2 0 0 {} {} == 1]} {
				>
					emit {\b, %d character originally}
				<
			}
	
			mime application/octet-stream
		<
	}
	
	if {[S string 0 0 {} {} eq \377\037]} {
		>
			emit {compacted data}
			mime application/octet-stream
		<
	}
	
	if {[S string 0 0 {} {} eq BZh]} {
		>
			emit {bzip2 compressed data}
			if {[N byte 3 0 0 {} {} > 47]} {
				>
					emit {\b, block size = %c00k}
				<
			}
	
			mime application/x-bzip2
		<
	}
	
	if {[S string 0 0 {} {} eq BZ0]} {
		>
			emit {bzip compressed data}
			if {[N byte 3 0 0 {} {} > 47]} {
				>
					emit {\b, block size = %c00k}
				<
			}
	
			mime application/x-bzip
		<
	}
	
	if {[S string 0 0 {} {} eq LZIP]} {
		>
			emit {lzip compressed data}
			if {[N byte 4 0 0 {} {} x {}]} {
				>
					emit {\b, version: %d}
				<
			}
	
			mime application/x-lzip
		<
	}
	
	if {[S string 0 0 {} {} eq \037\237]} {
		>
			emit {frozen file 2.1}
		<
	}
	
	if {[S string 0 0 {} {} eq \037\236]} {
		>
			emit {frozen file 1.0 (or gzip 0.5)}
		<
	}
	
	if {[S string 0 0 {} {} eq \037\240]} {
		>
			emit {SCO compress -H (LZH) data}
		<
	}
	
	if {[S string 0 0 {} {} eq \x89\x4c\x5a\x4f\x00\x0d\x0a\x1a\x0a]} {
		>
			emit {lzop compressed data}
			if {[N beshort 9 0 0 {} {} < 2368]} {
				>
					if {[N byte 9 0 0 & -16 == 0]} {
						>
							emit {- version 0.}
						<
					}
	
					if {[N beshort 9 0 0 & 4095 x {}]} {
						>
							emit {\b%03x,}
						<
					}
	
					switch [Nv byte 13 0 {} {}] {
						1 {
							>
								emit LZO1X-1,
							<
						}
						2 {
							>
								emit LZO1X-1(15),
							<
						}
						3 {
							>
								emit LZO1X-999,
							<
						}
					}
	
					switch [Nv byte 14 0 {} {}] {
						0 {
							>
								emit {os: MS-DOS}
							<
						}
						1 {
							>
								emit {os: Amiga}
							<
						}
						2 {
							>
								emit {os: VMS}
							<
						}
						3 {
							>
								emit {os: Unix}
							<
						}
						5 {
							>
								emit {os: Atari}
							<
						}
						6 {
							>
								emit {os: OS/2}
							<
						}
						7 {
							>
								emit {os: MacOS}
							<
						}
						10 {
							>
								emit {os: Tops/20}
							<
						}
						11 {
							>
								emit {os: WinNT}
							<
						}
						14 {
							>
								emit {os: Win32}
							<
						}
					}
	
				<
			}
	
			if {[N beshort 9 0 0 {} {} > 2361]} {
				>
					switch [Nv byte 9 0 & -16] {
						0 {
							>
								emit {- version 0.}
							<
						}
						16 {
							>
								emit {- version 1.}
							<
						}
						32 {
							>
								emit {- version 2.}
							<
						}
					}
	
					if {[N beshort 9 0 0 & 4095 x {}]} {
						>
							emit {\b%03x,}
						<
					}
	
					switch [Nv byte 15 0 {} {}] {
						1 {
							>
								emit LZO1X-1,
							<
						}
						2 {
							>
								emit LZO1X-1(15),
							<
						}
						3 {
							>
								emit LZO1X-999,
							<
						}
					}
	
					switch [Nv byte 17 0 {} {}] {
						0 {
							>
								emit {os: MS-DOS}
							<
						}
						1 {
							>
								emit {os: Amiga}
							<
						}
						2 {
							>
								emit {os: VMS}
							<
						}
						3 {
							>
								emit {os: Unix}
							<
						}
						5 {
							>
								emit {os: Atari}
							<
						}
						6 {
							>
								emit {os: OS/2}
							<
						}
						7 {
							>
								emit {os: MacOS}
							<
						}
						10 {
							>
								emit {os: Tops/20}
							<
						}
						11 {
							>
								emit {os: WinNT}
							<
						}
						14 {
							>
								emit {os: Win32}
							<
						}
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \037\241]} {
		>
			emit {Quasijarus strong compressed data}
		<
	}
	
	if {[S string 0 0 {} {} eq XPKF]} {
		>
			emit {Amiga xpkf.library compressed data}
		<
	}
	
	if {[S string 0 0 {} {} eq PP11]} {
		>
			emit {Power Packer 1.1 compressed data}
		<
	}
	
	if {[S string 0 0 {} {} eq PP20]} {
		>
			emit {Power Packer 2.0 compressed data,}
			switch [Nv belong 4 0 {} {}] {
				151587081 {
					>
						emit {fast compression}
					<
				}
				151652874 {
					>
						emit {mediocre compression}
					<
				}
				151653131 {
					>
						emit {good compression}
					<
				}
				151653388 {
					>
						emit {very good compression}
					<
				}
				151653389 {
					>
						emit {best compression}
					<
				}
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq 7z\274\257\047\034]} {
		>
			emit {7-zip archive data,}
			if {[N byte 6 0 0 {} {} x {}]} {
				>
					emit {version %d}
				<
			}
	
			if {[N byte 7 0 0 {} {} x {}]} {
				>
					emit {\b.%d}
					mime application/x-7z-compressed
					ext 7z/cb7
				<
			}
	
		<
	}
	
	if {[N lelong 0 0 0 & 16777215 == 93]} {
		>
			switch [Nv leshort 12 0 {} {}] {
				0 {
					>
						emit {LZMA compressed data,}
						if {[N lequad 5 0 0 {} {} == -1]} {
							>
								emit streamed
							<
						}
	
						if {[N lequad 5 0 0 {} {} != -1]} {
							>
								emit {non-streamed, size %lld}
							<
						}
	
					<
				}
				255 {
					>
						emit {LZMA compressed data,}
						mime application/x-lzma
						if {[N lequad 5 0 0 {} {} == -1]} {
							>
								emit streamed
							<
						}
	
						if {[N lequad 5 0 0 {} {} != -1]} {
							>
								emit {non-streamed, size %lld}
							<
						}
	
					<
				}
			}
	
		<
	}
	
	if {[S ustring 0 0 {} {} eq \xFD7zXZ\x00]} {
		>
			emit {XZ compressed data}
			mime application/x-xz
			strength {* 2}
		<
	}
	
	if {[S string 0 0 {} {} eq LRZI]} {
		>
			emit {LRZIP compressed data}
			if {[N byte 4 0 0 {} {} x {}]} {
				>
					emit {- version %d}
				<
			}
	
			if {[N byte 5 0 0 {} {} x {}]} {
				>
					emit {\b.%d}
					mime application/x-lrzip
				<
			}
	
		<
	}
	
	if {[N lelong 0 0 0 & -16 == 407710288]} {
		>
			T [I 4 ulelong 0 + 0 8] {}
	
		<
	}
	
	if {[S string 2 0 {} {} eq -afx-]} {
		>
			emit {AFX compressed file data}
		<
	}
	
	if {[S string 0 0 {} {} eq RZIP]} {
		>
			emit {rzip compressed data}
			if {[N byte 4 0 0 {} {} x {}]} {
				>
					emit {- version %d}
				<
			}
	
			if {[N byte 5 0 0 {} {} x {}]} {
				>
					emit {\b.%d}
				<
			}
	
			if {[N belong 6 0 0 {} {} x {}]} {
				>
					emit {(%d bytes)}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq ArC\x01]} {
		>
			emit {FreeArc archive <http://freearc.org>}
		<
	}
	
	if {[S string 0 0 {} {} eq \377\006\0\0sNaPpY]} {
		>
			emit {snappy framed data}
			mime application/x-snappy-framed
		<
	}
	
	if {[S string 0 0 {} {} eq qpress10]} {
		>
			emit {qpress compressed data}
			mime application/x-qpress
		<
	}
	
	if {[S string 0 0 b {} x {}]} {
		>
			if {[N beshort 0 0 0 % 31 == 0]} {
				>
					if {[N byte 0 0 0 & 15 == 8]} {
						>
							if {[N byte 0 0 0 & -128 == 0]} {
								>
									emit {zlib compressed data}
									mime application/zlib
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq BWC]} {
		>
			if {[N byte 3 0 0 {} {} == 0]} {
				>
					emit {BWC compressed data}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq SLIB]} {
		>
			emit {Softlib archive}
			if {[N leshort 4 0 0 {} {} x {}]} {
				>
					emit {\b, version %d}
				<
			}
	
			if {[N leshort 6 0 0 {} {} x {}]} {
				>
					emit {(contains %d files)}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq bvx-]} {
		>
			emit {lzfse encoded, no compression}
		<
	}
	
	if {[S string 0 0 {} {} eq bvx1]} {
		>
			emit {lzfse compressed, uncompressed tables}
		<
	}
	
	if {[S string 0 0 {} {} eq bvx2]} {
		>
			emit {lzfse compressed, compressed tables}
		<
	}
	
	if {[S string 0 0 {} {} eq bvxn]} {
		>
			emit {lzfse encoded, lzvn compressed}
		<
	}
	
	if {[S string 0 0 {} {} eq NES\x1A]} {
		>
			emit {NES ROM image (iNES)}
			U 51 nes-rom-image-ines 0
	
			mime application/x-nes-rom
		<
	}
	
	if {[S string 0 0 {} {} eq UNIF]} {
		>
			if {[N lelong 4 0 0 {} {} < 16]} {
				>
					emit {NES ROM image (UNIF v%d format)}
					mime application/x-nes-rom
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq FDS\x1A]} {
		>
			if {[S string 17 0 {} {} eq *NINTENDO-HVC*]} {
				>
					emit {Famicom Disk System disk image:}
					U 51 nintendo-fds-disk-info-block 16
	
					mime application/x-fds-disk
				<
			}
	
			if {[N byte 4 0 0 {} {} == 1]} {
				>
					emit {(%u side)}
				<
			}
	
			if {[N byte 4 0 0 {} {} != 1]} {
				>
					emit {(%u sides)}
				<
			}
	
		<
	}
	
	if {[S string 1 0 {} {} eq *NINTENDO-HVC*]} {
		>
			emit {Famicom Disk System disk image:}
			U 51 nintendo-fds-disk-info-block 0
	
			mime application/x-fds-disk
		<
	}
	
	if {[S string 0 0 {} {} eq TNES]} {
		>
			emit {NES ROM image (Nintendo 3DS Virtual Console)}
			if {[N byte 4 0 0 {} {} == 100]} {
				>
					emit {\b: FDS,}
					U 51 nintendo-fds-disk-info-block 8208
	
				<
			}
	
			if {[N byte 4 0 0 {} {} != 100]} {
				>
					emit {\b: TNES mapper %u}
					if {[N byte 5 0 0 {} {} x {}]} {
						>
							emit {\b, %ux8k PRG}
						<
					}
	
					if {[N byte 6 0 0 {} {} x {}]} {
						>
							emit {\b, %ux8k CHR}
						<
					}
	
					if {[N byte 7 0 0 & 8 == 1]} {
						>
							emit {[WRAM]}
						<
					}
	
					switch [Nv byte 8 0 & 9] {
						1 {
							>
								emit {[H-mirror]}
							<
						}
						2 {
							>
								emit {[V-mirror]}
							<
						}
					}
	
					if {[N byte 8 0 0 & 2 == 3]} {
						>
							emit {[VRAM]}
						<
					}
	
				<
			}
	
			mime application/x-nes-rom
		<
	}
	
	if {[N bequad 260 0 0 {} {} == -3536057540719869941]} {
		>
			emit {Game Boy ROM image}
			if {[N byte 323 0 0 & -128 == -128]} {
				>
					if {[S string 308 0 {} {} > \0]} {
						>
							emit {\b: "%.15s"}
						<
					}
	
				<
			}
	
			if {[N byte 323 0 0 & -128 != -128]} {
				>
					if {[S string 308 0 {} {} > \0]} {
						>
							emit {\b: "%.16s"}
						<
					}
	
				<
			}
	
			if {[N byte 332 0 0 {} {} x {}]} {
				>
					emit (Rev.%02u)
				<
			}
	
			if {[N byte 331 0 0 {} {} == 51]} {
				>
					if {[N byte 326 0 0 {} {} == 3]} {
						>
							if {[N byte 323 0 0 & -128 == -128]} {
								>
									emit {[SGB+CGB]}
								<
							}
	
							if {[N byte 323 0 0 & -128 != -128]} {
								>
									emit {[SGB]}
								<
							}
	
						<
					}
	
					if {[N byte 326 0 0 {} {} != 3]} {
						>
							switch [Nv byte 323 0 & -64] {
								-128 {
									>
										emit {[CGB]}
									<
								}
								-64 {
									>
										emit {[CGB ONLY]}
									<
								}
							}
	
						<
					}
	
				<
			}
	
			if {[N byte 331 0 0 {} {} != 51]} {
				>
				<
			}
	
			switch [Nv byte 327 0 {} {}] {
				-4 {
					>
						emit {[Pocket Camera]}
					<
				}
				-3 {
					>
						emit {[Bandai TAMA5]}
					<
				}
				-2 {
					>
						emit {[Hudson HuC-3]}
					<
				}
				-1 {
					>
						emit {[Hudson HuC-1]}
					<
				}
				0 {
					>
						emit {[ROM ONLY]}
					<
				}
				1 {
					>
						emit {[MBC1]}
					<
				}
				2 {
					>
						emit {[MBC1+RAM]}
					<
				}
				3 {
					>
						emit {[MBC1+RAM+BATT]}
					<
				}
				5 {
					>
						emit {[MBC2]}
					<
				}
				6 {
					>
						emit {[MBC2+BATTERY]}
					<
				}
				8 {
					>
						emit {[ROM+RAM]}
					<
				}
				9 {
					>
						emit {[ROM+RAM+BATTERY]}
					<
				}
				11 {
					>
						emit {[MMM01]}
					<
				}
				12 {
					>
						emit {[MMM01+SRAM]}
					<
				}
				13 {
					>
						emit {[MMM01+SRAM+BATT]}
					<
				}
				15 {
					>
						emit {[MBC3+TIMER+BATT]}
					<
				}
				16 {
					>
						emit {[MBC3+TIMER+RAM+BATT]}
					<
				}
				17 {
					>
						emit {[MBC3]}
					<
				}
				18 {
					>
						emit {[MBC3+RAM]}
					<
				}
				19 {
					>
						emit {[MBC3+RAM+BATT]}
					<
				}
				25 {
					>
						emit {[MBC5]}
					<
				}
				26 {
					>
						emit {[MBC5+RAM]}
					<
				}
				27 {
					>
						emit {[MBC5+RAM+BATT]}
					<
				}
				28 {
					>
						emit {[MBC5+RUMBLE]}
					<
				}
				29 {
					>
						emit {[MBC5+RUMBLE+SRAM]}
					<
				}
				30 {
					>
						emit {[MBC5+RUMBLE+SRAM+BATT]}
					<
				}
			}
	
			switch [Nv byte 328 0 {} {}] {
				0 {
					>
						emit {\b, ROM: 256Kbit}
					<
				}
				1 {
					>
						emit {\b, ROM: 512Kbit}
					<
				}
				2 {
					>
						emit {\b, ROM: 1Mbit}
					<
				}
				3 {
					>
						emit {\b, ROM: 2Mbit}
					<
				}
				4 {
					>
						emit {\b, ROM: 4Mbit}
					<
				}
				5 {
					>
						emit {\b, ROM: 8Mbit}
					<
				}
				6 {
					>
						emit {\b, ROM: 16Mbit}
					<
				}
				7 {
					>
						emit {\b, ROM: 32Mbit}
					<
				}
				82 {
					>
						emit {\b, ROM: 9Mbit}
					<
				}
				83 {
					>
						emit {\b, ROM: 10Mbit}
					<
				}
				84 {
					>
						emit {\b, ROM: 12Mbit}
					<
				}
			}
	
			switch [Nv byte 329 0 {} {}] {
				1 {
					>
						emit {\b, RAM: 16Kbit}
					<
				}
				2 {
					>
						emit {\b, RAM: 64Kbit}
					<
				}
				3 {
					>
						emit {\b, RAM: 128Kbit}
					<
				}
				4 {
					>
						emit {\b, RAM: 1Mbit}
					<
				}
				5 {
					>
						emit {\b, RAM: 512Kbit}
					<
				}
			}
	
			mime application/x-gameboy-rom
		<
	}
	
	if {[S string 0 0 {} {} eq SEGADISCSYSTEM\ \ ]} {
		>
			emit {Sega Mega CD disc image}
			U 51 sega-mega-drive-header 0
	
			if {[N byte 0 0 0 {} {} x {}]} {
				>
					emit {\b, 2048-byte sectors}
				<
			}
	
			mime application/x-sega-cd-rom
		<
	}
	
	if {[S string 0 0 {} {} eq SEGABOOTDISC\ \ \ \ ]} {
		>
			emit {Sega Mega CD disc image}
			U 51 sega-mega-drive-header 0
	
			if {[N byte 0 0 0 {} {} x {}]} {
				>
					emit {\b, 2048-byte sectors}
				<
			}
	
			mime application/x-sega-cd-rom
		<
	}
	
	if {[S string 16 0 {} {} eq SEGADISCSYSTEM\ \ ]} {
		>
			emit {Sega Mega CD disc image}
			U 51 sega-mega-drive-header 16
	
			if {[N byte 0 0 0 {} {} x {}]} {
				>
					emit {\b, 2352-byte sectors}
				<
			}
	
			mime application/x-sega-cd-rom
		<
	}
	
	if {[S string 16 0 {} {} eq SEGABOOTDISC\ \ \ \ ]} {
		>
			emit {Sega Mega CD disc image}
			U 51 sega-mega-drive-header 16
	
			if {[N byte 0 0 0 {} {} x {}]} {
				>
					emit {\b, 2352-byte sectors}
				<
			}
	
			mime application/x-sega-cd-rom
		<
	}
	
	if {[S string 256 0 {} {} eq SEGA]} {
		>
			if {[N bequad 960 0 0 {} {} == 5566821131383687237]} {
				>
					emit {Sega 32X ROM image}
					U 51 sega-mega-drive-header 0
	
					mime application/x-genesis-32x-rom
				<
			}
	
			if {[N bequad 960 0 0 {} {} != 5566821131383687237]} {
				>
					if {[N belong 261 0 0 {} {} == 1346978639]} {
						>
							emit {Sega Pico ROM image}
							U 51 sega-mega-drive-header 0
	
							mime application/x-sega-pico-rom
						<
					}
	
					if {[N belong 261 0 0 {} {} != 1346978639]} {
						>
							if {[N beshort 384 0 0 {} {} == 16978]} {
								>
									emit {Sega Mega CD Boot ROM image}
									mime application/x-genesis-rom
								<
							}
	
							if {[N beshort 384 0 0 {} {} != 16978]} {
								>
									emit {Sega Mega Drive / Genesis ROM image}
									mime application/x-genesis-rom
								<
							}
	
							U 51 sega-mega-drive-header 0
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 640 0 {} {} eq EAGN]} {
		>
			if {[N beshort 8 0 0 {} {} == -21829]} {
				>
					emit {Sega Mega Drive / Genesis ROM image (SMD format):}
					U 51 sega-genesis-smd-header 0
	
					mime application/x-genesis-rom
				<
			}
	
		<
	}
	
	if {[S string 640 0 {} {} eq EAMG]} {
		>
			if {[N beshort 8 0 0 {} {} == -21829]} {
				>
					emit {Sega Mega Drive / Genesis ROM image (SMD format):}
					U 51 sega-genesis-smd-header 0
	
					mime application/x-genesis-rom
				<
			}
	
		<
	}
	
	if {[S string 32752 0 {} {} eq TMR\ SEGA]} {
		>
			U 51 sega-master-system-rom-header 32752
	
		<
	}
	
	if {[S string 16368 0 {} {} eq TMR\ SEGA]} {
		>
			U 51 sega-master-system-rom-header 16368
	
		<
	}
	
	if {[S string 8176 0 {} {} eq TMR\ SEGA]} {
		>
			U 51 sega-master-system-rom-header 8176
	
		<
	}
	
	if {[S string 0 0 {} {} eq SEGA\ SEGASATURN\ ]} {
		>
			emit {Sega Saturn disc image}
			U 51 sega-saturn-disc-header 0
	
			if {[N byte 0 0 0 {} {} x {}]} {
				>
					emit {(2048-byte sectors)}
				<
			}
	
			mime application/x-saturn-rom
		<
	}
	
	if {[S string 16 0 {} {} eq SEGA\ SEGASATURN\ ]} {
		>
			emit {Sega Saturn disc image}
			U 51 sega-saturn-disc-header 16
	
			if {[N byte 0 0 0 {} {} x {}]} {
				>
					emit {(2352-byte sectors)}
				<
			}
	
			mime application/x-saturn-rom
		<
	}
	
	if {[S string 0 0 {} {} eq SEGA\ SEGAKATANA\ ]} {
		>
			emit {Sega Dreamcast disc image}
			U 51 sega-dreamcast-disc-header 0
	
			if {[N byte 0 0 0 {} {} x {}]} {
				>
					emit {(2048-byte sectors)}
				<
			}
	
			mime application/x-dc-rom
		<
	}
	
	if {[S string 16 0 {} {} eq SEGA\ SEGAKATANA\ ]} {
		>
			emit {Sega Dreamcast disc image}
			U 51 sega-dreamcast-disc-header 16
	
			if {[N byte 0 0 0 {} {} x {}]} {
				>
					emit {(2352-byte sectors)}
				<
			}
	
			mime application/x-dc-rom
		<
	}
	
	if {[S string 0 0 {} {} eq LCDi]} {
		>
			emit {Dream Animator file}
		<
	}
	
	if {[N bequad 4 0 0 {} {} == 2666041169113948705]} {
		>
			emit {Game Boy Advance ROM image}
			if {[S string 160 0 {} {} > \0]} {
				>
					emit {\b: "%.12s"}
				<
			}
	
			if {[S string 172 0 {} {} x {}]} {
				>
					emit (%.6s
				<
			}
	
			if {[N byte 188 0 0 {} {} x {}]} {
				>
					emit {\b, Rev.%02u)}
				<
			}
	
			mime application/x-gba-rom
		<
	}
	
	switch [Nv bequad 192 0 {} {}] {
		-4008115836254384158 {
			>
				emit {Nintendo DS Slot-2 ROM image (PassMe)}
				mime application/x-nintendo-ds-rom
			<
		}
		2666041169113948705 {
			>
				emit {Nintendo DS ROM image}
				mime application/x-nintendo-ds-rom
				if {[S string 0 0 {} {} > \0]} {
					>
						emit {\b: "%.12s"}
					<
				}
	
				if {[S string 12 0 {} {} x {}]} {
					>
						emit (%.6s
					<
				}
	
				if {[N byte 30 0 0 {} {} x {}]} {
					>
						emit {\b, Rev.%02u)}
					<
				}
	
				switch [Nv byte 18 0 {} {}] {
					2 {
						>
							emit {(DSi enhanced)}
						<
					}
					3 {
						>
							emit {(DSi only)}
						<
					}
				}
	
				if {[N lelong 32 0 0 {} {} < 16384]} {
					>
						emit (homebrew)
					<
				}
	
				if {[N lelong 32 0 0 {} {} > 16383]} {
					>
						if {[N lequad 16384 0 0 {} {} == 0]} {
							>
								emit (multiboot)
							<
						}
	
						if {[N lequad 16384 0 0 {} {} != 0]} {
							>
								if {[N lequad 16384 0 0 {} {} == -1729418541196648705]} {
									>
										emit (decrypted)
									<
								}
	
								if {[N lequad 16384 0 0 {} {} != -1729418541196648705]} {
									>
										if {[N lequad 4096 0 0 {} {} == 0]} {
											>
												emit (encrypted)
											<
										}
	
										if {[N lequad 4096 0 0 {} {} != 0]} {
											>
												emit {(mask ROM)}
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
			<
		}
	}
	
	if {[S string 10 0 {} {} eq BY\ SNK\ CORPORATION]} {
		>
			emit {Neo Geo Pocket}
			if {[N byte 35 0 0 {} {} == 16]} {
				>
					emit Color
				<
			}
	
			if {[N byte 0 0 0 {} {} x {}]} {
				>
					emit {ROM image}
				<
			}
	
			if {[S string 36 0 {} {} > \0]} {
				>
					emit {\b: "%.12s"}
				<
			}
	
			if {[N byte 31 0 0 {} {} == -1]} {
				>
					emit {(debug mode enabled)}
				<
			}
	
			mime application/x-neo-geo-pocket-rom
		<
	}
	
	if {[S string 0 0 {} {} eq PS-X\ EXE]} {
		>
			emit {Sony Playstation executable}
			if {[N lelong 16 0 0 {} {} x {}]} {
				>
					emit PC=0x%08x,
				<
			}
	
			if {[N lelong 20 0 0 {} {} != 0]} {
				>
					emit GP=0x%08x,
				<
			}
	
			if {[N lelong 24 0 0 {} {} != 0]} {
				>
					emit {.text=[0x%08x,}
					if {[N lelong 28 0 0 {} {} x {}]} {
						>
							emit {\b0x%x],}
						<
					}
	
				<
			}
	
			if {[N lelong 32 0 0 {} {} != 0]} {
				>
					emit {.data=[0x%08x,}
					if {[N lelong 36 0 0 {} {} x {}]} {
						>
							emit {\b0x%x],}
						<
					}
	
				<
			}
	
			if {[N lelong 40 0 0 {} {} != 0]} {
				>
					emit {.bss=[0x%08x,}
					if {[N lelong 44 0 0 {} {} x {}]} {
						>
							emit {\b0x%x],}
						<
					}
	
				<
			}
	
			if {[N lelong 48 0 0 {} {} != 0]} {
				>
					emit Stack=0x%08x,
				<
			}
	
			if {[N lelong 48 0 0 {} {} == 0]} {
				>
					emit {No Stack!,}
				<
			}
	
			if {[N lelong 52 0 0 {} {} != 0]} {
				>
					emit StackSize=0x%x,
				<
			}
	
			if {[S string 113 0 {} {} x {}]} {
				>
					emit (%s)
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq CPE]} {
		>
			emit {CPE executable}
			if {[N byte 3 0 0 {} {} x {}]} {
				>
					emit {(version %d)}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq XBEH]} {
		>
			emit {XBE, Microsoft Xbox executable}
			if {[N ulelong 4 0 0 {} {} == 0]} {
				>
					if {[N ulelong [R 2] 0 0 {} {} == 0]} {
						>
							if {[N ulelong [R 2] 0 0 {} {} == 0]} {
								>
									emit {\b, not signed}
								<
							}
	
						<
					}
	
				<
			}
	
			if {[N ulelong 4 0 0 {} {} > 0]} {
				>
					if {[N ulelong [R 2] 0 0 {} {} > 0]} {
						>
							if {[N ulelong [R 2] 0 0 {} {} > 0]} {
								>
									emit {\b, signed}
								<
							}
	
						<
					}
	
				<
			}
	
			if {[N ulelong 260 0 0 {} {} == 65536]} {
				>
					if {[N ulelong [I 280 long 0 - 0 65376] 0 0 & 2147483655 == 2147483655]} {
						>
							emit {\b, all regions}
						<
					}
	
					if {[N ulelong [I 280 long 0 - 0 65376] 0 0 & 2147483655 != 2147483655]} {
						>
							if {[N ulelong [I 280 long 0 - 0 65376] 0 0 {} {} > 0]} {
								>
									emit (regions:
									if {[N ulelong [I 280 long 0 - 0 65376] 0 0 {} {} & 1]} {
										>
											emit NA
										<
									}
	
									if {[N ulelong [I 280 long 0 - 0 65376] 0 0 {} {} & 2]} {
										>
											emit Japan
										<
									}
	
									if {[N ulelong [I 280 long 0 - 0 65376] 0 0 {} {} & 4]} {
										>
											emit Rest_of_World
										<
									}
	
									if {[N ulelong [I 280 long 0 - 0 65376] 0 0 {} {} & 2147483648]} {
										>
											emit Manufacturer
										<
									}
	
								<
							}
	
							if {[N ulelong [I 280 long 0 - 0 65376] 0 0 {} {} > 0]} {
								>
									emit {\b)}
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq XIP0]} {
		>
			emit {XIP, Microsoft Xbox data}
		<
	}
	
	if {[S string 0 0 {} {} eq XTF0]} {
		>
			emit {XTF, Microsoft Xbox data}
		<
	}
	
	if {[S string 0 0 {} {} eq \x01ZZZZZ\x01]} {
		>
			emit {3DO "Opera" file system}
		<
	}
	
	if {[S string 0 0 {} {} eq GBS]} {
		>
			emit {Nintendo Gameboy Music/Audio Data}
			if {[S string 16 0 {} {} > \0]} {
				>
					emit {("%.32s" by}
				<
			}
	
			if {[S string 48 0 {} {} > \0]} {
				>
					emit {%.32s, copyright}
				<
			}
	
			if {[S string 80 0 {} {} > \0]} {
				>
					emit %.32s),
				<
			}
	
			if {[N byte 3 0 0 {} {} x {}]} {
				>
					emit {version %u,}
				<
			}
	
			if {[N byte 4 0 0 {} {} x {}]} {
				>
					emit {%u tracks}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq PATCH]} {
		>
			emit {IPS patch file}
		<
	}
	
	if {[S string 0 0 {} {} eq PPF30]} {
		>
			emit {Playstation Patch File version 3.0}
			switch [Nv byte 5 0 {} {}] {
				0 {
					>
						emit {\b, PPF 1.0 patch}
					<
				}
				1 {
					>
						emit {\b, PPF 2.0 patch}
					<
				}
				2 {
					>
						emit {\b, PPF 3.0 patch}
						switch [Nv byte 56 0 {} {}] {
							0 {
								>
									emit {\b, Imagetype BIN (any)}
								<
							}
							1 {
								>
									emit {\b, Imagetype GI (PrimoDVD)}
								<
							}
						}
	
						switch [Nv byte 57 0 {} {}] {
							0 {
								>
									emit {\b, Blockcheck disabled}
								<
							}
							1 {
								>
									emit {\b, Blockcheck enabled}
								<
							}
						}
	
						switch [Nv byte 58 0 {} {}] {
							0 {
								>
									emit {\b, Undo data not available}
								<
							}
							1 {
								>
									emit {\b, Undo data available}
								<
							}
						}
	
					<
				}
			}
	
			if {[S string 6 0 {} {} x {}]} {
				>
					emit {\b, description: %s}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq PPF20]} {
		>
			emit {Playstation Patch File version 2.0}
			switch [Nv byte 5 0 {} {}] {
				0 {
					>
						emit {\b, PPF 1.0 patch}
					<
				}
				1 {
					>
						emit {\b, PPF 2.0 patch}
						if {[N lelong 56 0 0 {} {} > 0]} {
							>
								emit {\b, size of file to patch %d}
							<
						}
	
					<
				}
			}
	
			if {[S string 6 0 {} {} x {}]} {
				>
					emit {\b, description: %s}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq PPF10]} {
		>
			emit {Playstation Patch File version 1.0}
			if {[N byte 5 0 0 {} {} == 0]} {
				>
					emit {\b, Simple Encoding}
				<
			}
	
			if {[S string 6 0 {} {} x {}]} {
				>
					emit {\b, description: %s}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq SMV\x1A]} {
		>
			emit {SNES9x input recording}
			if {[N lelong 4 0 0 {} {} x {}]} {
				>
					emit {\b, version %d}
				<
			}
	
			if {[N lelong 4 0 0 {} {} < 5]} {
				>
					if {[N ledate 8 0 0 {} {} x {}]} {
						>
							emit {\b, recorded at %s}
						<
					}
	
					if {[N lelong 12 0 0 {} {} > 0]} {
						>
							emit {\b, rerecorded %d times}
						<
					}
	
					if {[N lelong 16 0 0 {} {} x {}]} {
						>
							emit {\b, %d frames long}
						<
					}
	
					if {[N byte 20 0 0 {} {} > 0]} {
						>
							emit {\b, data for controller(s):}
							if {[N byte 20 0 0 {} {} & 1]} {
								>
									emit {#1}
								<
							}
	
							if {[N byte 20 0 0 {} {} & 2]} {
								>
									emit {#2}
								<
							}
	
							if {[N byte 20 0 0 {} {} & 4]} {
								>
									emit {#3}
								<
							}
	
							if {[N byte 20 0 0 {} {} & 8]} {
								>
									emit {#4}
								<
							}
	
							if {[N byte 20 0 0 {} {} & 16]} {
								>
									emit {#5}
								<
							}
	
						<
					}
	
					if {[N byte 21 0 0 {} {} ^ 1]} {
						>
							emit {\b, begins from snapshot}
						<
					}
	
					if {[N byte 21 0 0 {} {} & 1]} {
						>
							emit {\b, begins from reset}
						<
					}
	
					if {[N byte 21 0 0 {} {} ^ 2]} {
						>
							emit {\b, NTSC standard}
						<
					}
	
					if {[N byte 21 0 0 {} {} & 2]} {
						>
							emit {\b, PAL standard}
						<
					}
	
					if {[N byte 23 0 0 {} {} & 1]} {
						>
							emit {\b, settings:}
							if {[N lelong 4 0 0 {} {} < 4]} {
								>
									if {[N byte 23 0 0 {} {} & 2]} {
										>
											emit WIP1Timing
										<
									}
	
								<
							}
	
							if {[N byte 23 0 0 {} {} & 4]} {
								>
									emit Left+Right
								<
							}
	
							if {[N byte 23 0 0 {} {} & 8]} {
								>
									emit VolumeEnvX
								<
							}
	
							if {[N byte 23 0 0 {} {} & 16]} {
								>
									emit FakeMute
								<
							}
	
							if {[N byte 23 0 0 {} {} & 32]} {
								>
									emit SyncSound
								<
							}
	
							if {[N lelong 4 0 0 {} {} > 3]} {
								>
									if {[N byte 23 0 0 {} {} & -128]} {
										>
											emit NoCPUShutdown
										<
									}
	
								<
							}
	
						<
					}
	
					if {[N lelong 4 0 0 {} {} < 4]} {
						>
							if {[N lelong 24 0 0 {} {} > 35]} {
								>
									if {[N leshort 32 0 0 {} {} != 0]} {
										>
											if {[S lestring16 32 0 {} {} x {}]} {
												>
													emit {\b, metadata: "%s"}
												<
											}
	
										<
									}
	
								<
							}
	
						<
					}
	
					if {[N lelong 4 0 0 {} {} > 3]} {
						>
							if {[N byte 36 0 0 {} {} > 0]} {
								>
									emit {\b, port 1:}
									switch [Nv byte 36 0 {} {}] {
										1 {
											>
												emit joypad
											<
										}
										2 {
											>
												emit mouse
											<
										}
										3 {
											>
												emit SuperScope
											<
										}
										4 {
											>
												emit Justifier
											<
										}
										5 {
											>
												emit multitap
											<
										}
									}
	
								<
							}
	
							if {[N byte 36 0 0 {} {} > 0]} {
								>
									emit {\b, port 2:}
									switch [Nv byte 37 0 {} {}] {
										1 {
											>
												emit joypad
											<
										}
										2 {
											>
												emit mouse
											<
										}
										3 {
											>
												emit SuperScope
											<
										}
										4 {
											>
												emit Justifier
											<
										}
										5 {
											>
												emit multitap
											<
										}
									}
	
								<
							}
	
							if {[N lelong 24 0 0 {} {} > 67]} {
								>
									if {[N leshort 64 0 0 {} {} != 0]} {
										>
											if {[S lestring16 64 0 {} {} x {}]} {
												>
													emit {\b, metadata: "%s"}
												<
											}
	
										<
									}
	
								<
							}
	
						<
					}
	
					if {[N byte 23 0 0 {} {} & 64]} {
						>
							emit {\b, ROM:}
							if {[N lelong [I 24 ulelong 0 - 0 26] 0 0 {} {} x {}]} {
								>
									emit {CRC32 0x%08x}
								<
							}
	
							if {[S string [I 24 ulelong 0 - 0 23] 0 {} {} x {}]} {
								>
									emit {"%s"}
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq SCVM]} {
		>
			emit {ScummVM savegame}
			if {[S string 12 0 {} {} > \0]} {
				>
					emit {"%s"}
				<
			}
	
		<
	}
	
	if {[N belong 28 0 0 {} {} == -1036804291]} {
		>
			emit {Nintendo GameCube disc image:}
			U 51 nintendo-gcn-disc-common 0
	
			mime application/x-gamecube-rom
		<
	}
	
	switch [Nv belong 24 0 {} {}] {
		60011 {
			>
				emit {old-fs dump file (big endian),}
				U 68 old-dump-be 0
	
			<
		}
		60012 {
			>
				emit {new-fs dump file (big endian),}
				U 68 new-dump-be 0
	
			<
		}
		60013 {
			>
				emit {dump format, 4.2 or 4.3 BSD (IDC compatible)}
			<
		}
		60014 {
			>
				emit {dump format, Convex Storage Manager by-reference dump}
			<
		}
		424935705 {
			>
				emit {new-fs dump file (ufs2, big endian),}
				U 68 ufs2-dump-be 0
	
			<
		}
		1562156707 {
			>
				emit {Nintendo Wii disc image:}
				U 51 nintendo-gcn-disc-common 0
	
			<
		}
	}
	
	if {[S string 0 0 {} {} eq WBFS]} {
		>
			if {[N belong 536 0 0 {} {} == 1562156707]} {
				>
					emit {Nintendo Wii disc image (WBFS format):}
					U 51 nintendo-gcn-disc-common 512
	
					mime application/x-wii-rom
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq CISO]} {
		>
			if {[N lelong 4 0 0 {} {} == 2097152]} {
				>
					if {[N byte 8 0 0 {} {} == 1]} {
						>
							if {[N belong 32796 0 0 {} {} == -1036804291]} {
								>
									emit {Nintendo GameCube disc image (CISO format):}
									U 51 nintendo-gcn-disc-common 32768
	
									mime application/x-wii-rom
								<
							}
	
							if {[N belong 32792 0 0 {} {} == 1562156707]} {
								>
									emit {Nintendo Wii disc image (CISO format):}
									U 51 nintendo-gcn-disc-common 32768
	
									mime application/x-wii-rom
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq WII\001DISC]} {
		>
			switch [Nv belong 8 0 {} {}] {
				1 {
					>
						if {[N belong 84 0 0 {} {} == -1036804291]} {
							>
								emit {Nintendo GameCube disc image (WDFv1 format):}
								U 51 nintendo-gcn-disc-common 56
	
								mime application/x-gamecube-rom
							<
						}
	
						if {[N belong 88 0 0 {} {} == 1562156707]} {
							>
								emit {Nintendo Wii disc image (WDFv1 format):}
								U 51 nintendo-gcn-disc-common 56
	
								mime application/x-wii-rom
							<
						}
	
					<
				}
				2 {
					>
						if {[N belong [I 12 ubelong 0 + 0 28] 0 0 {} {} == -1036804291]} {
							>
								emit {Nintendo GameCube disc image (WDFv2 format):}
								U 51 nintendo-gcn-disc-common [I 12 ubelong 0 + 0 0]
	
								mime application/x-gamecube-rom
							<
						}
	
						if {[N belong [I 12 ubelong 0 + 0 24] 0 0 {} {} == 1562156707]} {
							>
								emit {Nintendo Wii disc image (WDFv2 format):}
								U 51 nintendo-gcn-disc-common [I 12 ubelong 0 + 0 0]
	
								mime application/x-wii-rom
							<
						}
	
					<
				}
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq WIA\001]} {
		>
			emit Nintendo
			switch [Nv belong 72 0 {} {}] {
				1 {
					>
						emit GameCube
						mime application/x-gamecube-rom
					<
				}
				2 {
					>
						emit Wii
						mime application/x-wii-rom
					<
				}
			}
	
			if {[D 72]} {
				>
					emit GameCube/Wii
				<
			}
	
			if {[N belong 72 0 0 {} {} x {}]} {
				>
					emit {disc image (WIA format):}
					U 51 nintendo-gcn-disc-common 88
	
				<
			}
	
		<
	}
	
	if {[S string 256 0 {} {} eq NCSD]} {
		>
			if {[N lequad 280 0 0 {} {} == 0]} {
				>
					emit {Nintendo 3DS Game Card image}
					if {[S string 4432 0 {} {} > \0]} {
						>
							emit {\b: "%.16s"}
						<
					}
	
					if {[N byte 786 0 0 {} {} x {}]} {
						>
							emit (Rev.%02u)
						<
					}
	
					if {[N byte 4492 0 0 {} {} == 2]} {
						>
							emit {(New3DS only)}
						<
					}
	
					switch [Nv byte 397 0 {} {}] {
						0 {
							>
								emit {(inner device)}
							<
						}
						1 {
							>
								emit (Card1)
							<
						}
						2 {
							>
								emit (Card2)
							<
						}
						3 {
							>
								emit {(extended device)}
							<
						}
					}
	
				<
			}
	
			switch [Nv bequad 280 0 {} {}] {
				72622751638093824 {
					>
						emit {Nintendo 3DS eMMC dump (Old3DS)}
					<
				}
				72622751654871040 {
					>
						emit {Nintendo 3DS eMMC dump (New3DS)}
					<
				}
			}
	
		<
	}
	
	if {[S string 256 0 {} {} eq NCCH]} {
		>
			emit {Nintendo 3DS}
			switch [Nv byte 397 0 & 2] {
				0 {
					>
						emit {File Archive (CFA)}
					<
				}
				2 {
					>
						emit {Executable Image (CXI)}
					<
				}
			}
	
			if {[S string 336 0 {} {} > \0]} {
				>
					emit {\b: "%.16s"}
				<
			}
	
			switch [Nv byte 397 0 {} {}] {
				5 {
					>
						if {[N leshort 270 0 0 {} {} x {}]} {
							>
								emit {(Old3DS System Update v}
							<
						}
	
						U 51 nintendo-3ds-version-code 270
	
						if {[N leshort 270 0 0 {} {} x {}]} {
							>
								emit {\b)}
							<
						}
	
					<
				}
				21 {
					>
						if {[N leshort 270 0 0 {} {} x {}]} {
							>
								emit {(New3DS System Update v}
							<
						}
	
						U 51 nintendo-3ds-version-code 270
	
						if {[N leshort 270 0 0 {} {} x {}]} {
							>
								emit {\b)}
							<
						}
	
					<
				}
			}
	
			if {[N byte 397 0 0 {} {} != 5]} {
				>
					if {[N byte 397 0 0 {} {} != 21]} {
						>
							if {[N byte 274 0 0 {} {} x {}]} {
								>
									emit (v
								<
							}
	
							U 51 nintendo-3ds-version-code 274
	
							if {[N byte 274 0 0 {} {} x {}]} {
								>
									emit {\b)}
								<
							}
	
						<
					}
	
				<
			}
	
			if {[N byte 396 0 0 {} {} == 2]} {
				>
					emit {(New3DS only)}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq SMDH]} {
		>
			emit {Nintendo 3DS SMDH file}
			if {[N leshort 520 0 0 {} {} != 0]} {
				>
					if {[S lestring16 520 0 {} {} x {}]} {
						>
							emit {\b: "%.128s"}
						<
					}
	
					if {[N leshort 904 0 0 {} {} != 0]} {
						>
							if {[S lestring16 904 0 {} {} x {}]} {
								>
									emit {by %.128s}
								<
							}
	
						<
					}
	
				<
			}
	
			if {[N leshort 520 0 0 {} {} == 0]} {
				>
					if {[N leshort 8 0 0 {} {} != 0]} {
						>
							if {[S lestring16 8 0 {} {} x {}]} {
								>
									emit {\b: "%.128s"}
								<
							}
	
							if {[N leshort 392 0 0 {} {} != 0]} {
								>
									if {[S lestring16 392 0 {} {} x {}]} {
										>
											emit {by %.128s}
										<
									}
	
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq 3DSX]} {
		>
			emit {Nintendo 3DS Homebrew Application (3DSX)}
		<
	}
	
	if {[N byte 0 0 0 {} {} > 0]} {
		>
			if {[N byte 0 0 0 {} {} < 3]} {
				>
					if {[S string 1 0 {} {} eq ATARI7800]} {
						>
							emit {Atari 7800 ROM image}
							if {[S string 17 0 {} {} > \0]} {
								>
									emit {\b: "%.32s"}
								<
							}
	
							switch [Nv byte 57 0 {} {}] {
								0 {
									>
										emit (NTSC)
									<
								}
								1 {
									>
										emit (PAL)
									<
								}
							}
	
							if {[N byte 54 0 0 & 1 == 1]} {
								>
									emit (POKEY)
								<
							}
	
							mime application/x-atari-7800-rom
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq g\ GCE]} {
		>
			emit {Vectrex ROM image}
			if {[S string 17 0 {} {} > \0]} {
				>
					emit {\b: "%.16s"}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq TN:]} {
		>
			if {[S search [R 0] 0 {} 64 eq \nSF:/]} {
				>
					emit {LCOV coverage tracefile}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \x20\x20\x20\x20\x20\x20\x20\x20-:\x20\x20\x20\ 0:Source:]} {
		>
			if {[S search [R 0] 0 {} 128 eq \x20\x20\x20\x20\x20\x20\x20\x20-:\x20\x20\x20\ 0:Graph:]} {
				>
					if {[S search [R 0] 0 {} 128 eq \x20\x20\x20\x20\x20\x20\x20\x20-:\x20\x20\x20\ 0:Data:]} {
						>
							emit {GCOV coverage report}
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S search 0 0 {} 1 eq \0\0\0\0pwV1]} {
		>
			emit {Cracklib password index, big endian ("64-bit")}
			if {[N belong 12 0 0 {} {} > 0]} {
				>
					emit {(%i words)}
				<
			}
	
		<
	}
	
	if {[S search 0 0 {} 1 eq !_TAG]} {
		>
			emit {Exuberant Ctags tag file text}
		<
	}
	
	if {[S string 0 0 {} {} eq /*\x20CTF\x20]} {
		>
			emit {Common Trace Format (CTF) plain text metadata}
			if {[S regex [R 0] 0 {} {} eq \[0-9\]+.\[0-9\]+]} {
				>
					emit {\b, v%s}
				<
			}
	
			strength {+ 5			# this is to make sure we beat C}
		<
	}
	
	if {[S string 0 0 {} {} eq ACMP]} {
		>
			emit {Map file for the AssaultCube FPS game}
		<
	}
	
	if {[S string 0 0 {} {} eq CUBE]} {
		>
			emit {Map file for cube and cube2 engine games}
		<
	}
	
	if {[S string 0 0 {} {} eq MAPZ)]} {
		>
			emit {Map file for the Blood Frontier/Red Eclipse FPS games}
		<
	}
	
	if {[S string 0 0 {} {} eq RaS]} {
		>
			if {[S string 3 0 {} {} eq t]} {
				>
					emit {Cups Raster version 1, Big Endian}
				<
			}
	
			if {[S string 3 0 {} {} eq 2]} {
				>
					emit {Cups Raster version 2, Big Endian}
				<
			}
	
			if {[S string 3 0 {} {} eq 3]} {
				>
					emit {Cups Raster version 3, Big Endian}
					mime application/vnd.cups-raster
				<
			}
	
			U 58 cups-le 0
	
		<
	}
	
	if {[S string 1 0 {} {} eq SaR]} {
		>
			if {[S string 0 0 {} {} eq t]} {
				>
					emit {Cups Raster version 1, Little Endian}
				<
			}
	
			if {[S string 0 0 {} {} eq 2]} {
				>
					emit {Cups Raster version 2, Little Endian}
				<
			}
	
			if {[S string 0 0 {} {} eq 3]} {
				>
					emit {Cups Raster version 3, Little Endian}
					mime application/vnd.cups-raster
				<
			}
	
			U 58 cups-le 0
	
		<
	}
	
	if {[S string 0 0 {} {} eq GDBM]} {
		>
			emit {GNU dbm 2.x database}
			mime application/x-gdbm
		<
	}
	
	switch [Nv long 12 0 {} {}] {
		264584 {
			>
				emit {Berkeley DB}
				if {[N long 16 0 0 {} {} > 0]} {
					>
						emit {(Log, version %d, native byte-order)}
					<
				}
	
			<
		}
		270931 {
			>
				emit {Berkeley DB}
				if {[N long 16 0 0 {} {} > 0]} {
					>
						emit {(Queue, version %d, native byte-order)}
					<
				}
	
			<
		}
		340322 {
			>
				emit {Berkeley DB}
				if {[N long 16 0 0 {} {} > 0]} {
					>
						emit {(Btree, version %d, native byte-order)}
					<
				}
	
			<
		}
		398689 {
			>
				emit {Berkeley DB}
				if {[N long 16 0 0 {} {} > 0]} {
					>
						emit {(Hash, version %d, native byte-order)}
					<
				}
	
			<
		}
	}
	
	switch [Nv belong 12 0 {} {}] {
		264584 {
			>
				emit {Berkeley DB}
				if {[N belong 16 0 0 {} {} > 0]} {
					>
						emit {(Log, version %d, big-endian)}
					<
				}
	
			<
		}
		270931 {
			>
				emit {Berkeley DB}
				if {[N belong 16 0 0 {} {} > 0]} {
					>
						emit {(Queue, version %d, big-endian)}
					<
				}
	
			<
		}
		340322 {
			>
				emit {Berkeley DB}
				if {[N belong 16 0 0 {} {} > 0]} {
					>
						emit {(Btree, version %d, big-endian)}
					<
				}
	
			<
		}
		398689 {
			>
				emit {Berkeley DB}
				if {[N belong 16 0 0 {} {} > 0]} {
					>
						emit {(Hash, version %d, big-endian)}
					<
				}
	
			<
		}
	}
	
	switch [Nv lelong 12 0 {} {}] {
		264584 {
			>
				emit {Berkeley DB}
				if {[N lelong 16 0 0 {} {} > 0]} {
					>
						emit {(Log, version %d, little-endian)}
					<
				}
	
			<
		}
		270931 {
			>
				emit {Berkeley DB}
				if {[N lelong 16 0 0 {} {} > 0]} {
					>
						emit {(Queue, version %d, little-endian)}
					<
				}
	
			<
		}
		340322 {
			>
				emit {Berkeley DB}
				if {[N lelong 16 0 0 {} {} > 0]} {
					>
						emit {(Btree, version %d, little-endian)}
					<
				}
	
			<
		}
		398689 {
			>
				emit {Berkeley DB}
				if {[N lelong 16 0 0 {} {} > 0]} {
					>
						emit {(Hash, version %d, little-endian)}
					<
				}
	
			<
		}
	}
	
	if {[S string 0 0 b {} eq RRD\0]} {
		>
			emit {RRDTool DB}
			if {[S string 4 0 b {} x {}]} {
				>
					emit {version %s}
					if {[N short 10 0 0 {} {} != 0]} {
						>
							emit {16bit aligned}
							if {[N bedouble 10 0 0 {} {} == 8.642135e+130]} {
								>
									emit big-endian
									if {[N short 18 0 0 {} {} x {}]} {
										>
											emit {32bit long (m68k)}
										<
									}
	
								<
							}
	
						<
					}
	
					if {[N short 10 0 0 {} {} == 0]} {
						>
							if {[N long 12 0 0 {} {} != 0]} {
								>
									emit {32bit aligned}
									if {[N bedouble 12 0 0 {} {} == 8.642135e+130]} {
										>
											emit big-endian
											if {[N long 20 0 0 {} {} == 0]} {
												>
													emit {64bit long}
												<
											}
	
											if {[N long 20 0 0 {} {} != 0]} {
												>
													emit {32bit long}
												<
											}
	
										<
									}
	
									if {[N ledouble 12 0 0 {} {} == 8.642135e+130]} {
										>
											emit little-endian
											if {[N long 24 0 0 {} {} == 0]} {
												>
													emit {64bit long}
												<
											}
	
											if {[N long 24 0 0 {} {} != 0]} {
												>
													emit {32bit long (i386)}
												<
											}
	
										<
									}
	
									if {[S string 12 0 {} {} eq \x43\x2b\x1f\x5b\x2f\x25\xc0\xc7]} {
										>
											emit middle-endian
											if {[N short 24 0 0 {} {} != 0]} {
												>
													emit {32bit long (arm)}
												<
											}
	
										<
									}
	
								<
							}
	
						<
					}
	
					if {[N quad 8 0 0 {} {} == 0]} {
						>
							emit {64bit aligned}
							if {[N bedouble 16 0 0 {} {} == 8.642135e+130]} {
								>
									emit big-endian
									if {[N long 24 0 0 {} {} == 0]} {
										>
											emit {64bit long (s390x)}
										<
									}
	
									if {[N long 24 0 0 {} {} != 0]} {
										>
											emit {32bit long (hppa/mips/ppc/s390/SPARC)}
										<
									}
	
								<
							}
	
							if {[N ledouble 16 0 0 {} {} == 8.642135e+130]} {
								>
									emit little-endian
									if {[N long 28 0 0 {} {} == 0]} {
										>
											emit {64bit long (alpha/amd64/ia64)}
										<
									}
	
									if {[N long 28 0 0 {} {} != 0]} {
										>
											emit {32bit long (armel/mipsel)}
										<
									}
	
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq root\0]} {
		>
			emit {ROOT file}
			if {[N belong 4 0 0 {} {} x {}]} {
				>
					emit {Version %d}
				<
			}
	
			if {[N belong 33 0 0 {} {} x {}]} {
				>
					emit {(Compression: %d)}
				<
			}
	
		<
	}
	
	if {[N ubelong 0 0 0 & 65535 < 3104]} {
		>
			if {[N ubyte 2 0 0 {} {} > 0]} {
				>
					if {[N ubyte 3 0 0 {} {} > 0]} {
						>
							if {[N ubyte 3 0 0 {} {} < 32]} {
								>
									if {[N ubyte 0 0 0 {} {} > 1]} {
										>
											if {[N ubyte 27 0 0 {} {} == 0]} {
												>
													if {[N ubelong 24 0 0 & 4294967295 > 19931136]} {
														>
														<
													}
	
													if {[N ubelong 24 0 0 & 4294967295 < 19931137]} {
														>
															if {[N ubelong 24 0 0 & 4294967295 == 0]} {
																>
																	if {[N ubelong 12 0 0 & 4294967038 == 0]} {
																		>
																			if {[N ubyte 28 0 0 {} {} x {}]} {
																				>
																				<
																			}
	
																			if {[N ubyte 28 0 0 & 248 == 0]} {
																				>
																					if {[N uleshort 8 0 0 {} {} > 31]} {
																						>
																							if {[N ubyte 32 0 0 {} {} > 0]} {
																								>
																									U 60 xbase-type 0
	
																									if {[N ubyte 0 0 0 {} {} x {}]} {
																										>
																											emit {\b DBF}
																										<
																									}
	
																									if {[N lelong 4 0 0 {} {} == 0]} {
																										>
																											emit {\b, no records}
																										<
																									}
	
																									if {[N lelong 4 0 0 {} {} > 0]} {
																										>
																											emit {\b, %d record}
																											if {[N lelong 4 0 0 {} {} > 1]} {
																												>
																													emit {\bs}
																												<
																											}
	
																										<
																									}
	
																									if {[N uleshort 10 0 0 {} {} x {}]} {
																										>
																											emit {* %d}
																										<
																									}
	
																									if {[N ubyte 1 0 0 {} {} x {}]} {
																										>
																											emit {\b, update-date}
																										<
																									}
	
																									U 60 xbase-date 1
	
																									if {[N ubyte 29 0 0 {} {} > 0]} {
																										>
																											emit {\b, codepage ID=0x%x}
																										<
																									}
	
																									if {[N ubyte 28 0 0 & 1 == 1]} {
																										>
																											emit {\b, with index file .MDX}
																										<
																									}
	
																									if {[N ubyte 28 0 0 & 2 == 2]} {
																										>
																											emit {\b, with memo .FPT}
																										<
																									}
	
																									if {[N ubyte 28 0 0 & 4 == 4]} {
																										>
																											emit {\b, DataBaseContainer}
																										<
																									}
	
																									if {[N uleshort 8 0 0 {} {} > 0]} {
																										>
																										<
																									}
	
																									if {[N ubyte [I 8 uleshort 0 + 0 1] 0 0 {} {} > 0]} {
																										>
																											if {[N uleshort 8 0 0 {} {} > 0]} {
																												>
																													emit {\b, at offset %d}
																												<
																											}
	
																											if {[N ubyte [I 8 uleshort 0 + 0 1] 0 0 {} {} > 0]} {
																												>
																													if {[S string [R -1] 0 {} {} > \0]} {
																														>
																															emit {1st record "%s"}
																														<
																													}
	
																												<
																											}
	
																										<
																									}
	
																								<
																							}
	
																						<
																					}
	
																				<
																			}
	
																		<
																	}
	
																<
															}
	
															if {[N ubelong 24 0 0 & 20183039 > 0]} {
																>
																	if {[N ubyte 47 0 0 {} {} == 0]} {
																		>
																			if {[N ubyte 559 0 0 & 239 == 0]} {
																				>
																					if {[N ubeshort 45 0 0 {} {} < 3104]} {
																						>
																							if {[N ubyte 45 0 0 {} {} > 0]} {
																								>
																									if {[N ubyte 46 0 0 {} {} < 32]} {
																										>
																											if {[N ubyte 46 0 0 {} {} > 0]} {
																												>
																													U 60 xbase-type 0
	
																													if {[N ubyte 0 0 0 {} {} x {}]} {
																														>
																															emit {\b MDX}
																														<
																													}
	
																													if {[N ubyte 1 0 0 {} {} x {}]} {
																														>
																															emit {\b, creation-date}
																														<
																													}
	
																													U 60 xbase-date 1
	
																													if {[N ubyte 44 0 0 {} {} x {}]} {
																														>
																															emit {\b, update-date}
																														<
																													}
	
																													U 60 xbase-date 44
	
																													if {[N uleshort 28 0 0 {} {} x {}]} {
																														>
																															emit {\b, %d}
																														<
																													}
	
																													if {[N ubyte 25 0 0 {} {} x {}]} {
																														>
																															emit {\b/%d tags}
																														<
																													}
	
																													if {[N ubyte 26 0 0 {} {} x {}]} {
																														>
																															emit {* %d}
																														<
																													}
	
																												<
																											}
	
																											if {[S string 548 0 {} {} x {}]} {
																												>
																													emit {\b, 1st tag "%.11s"}
																												<
																											}
	
																										<
																									}
	
																								<
																							}
	
																						<
																					}
	
																				<
																			}
	
																		<
																	}
	
																<
															}
	
														<
													}
	
												<
											}
	
										<
									}
	
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[N ubyte 16 0 0 {} {} < 4]} {
		>
			if {[N ubyte 16 0 0 {} {} != 2]} {
				>
					if {[N ubyte 16 0 0 {} {} != 1]} {
						>
							if {[N ulelong 0 0 0 {} {} > 0]} {
								>
									if {[N ubelong 17 0 0 & 4294835712 == 0]} {
										>
											if {[N ubelong 20 0 0 & 4278263963 == 0]} {
												>
													switch [Nv ubyte 16 0 {} {}] {
														0 {
															>
																if {[N uleshort 20 0 0 {} {} == 0]} {
																	>
																		if {[N ulong 8 0 0 {} {} == 0]} {
																			>
																				if {[N ubeshort 6 0 0 {} {} > 0]} {
																					>
																						if {[N ushort 4 0 0 {} {} == 0]} {
																							>
																								U 60 foxpro-memo-print 0
	
																							<
																						}
	
																					<
																				}
	
																				if {[N ubeshort 6 0 0 {} {} == 0]} {
																					>
																						if {[N ubeshort 510 0 0 {} {} == 0]} {
																							>
																								if {[N ubelong 512 0 0 {} {} < 4278189827]} {
																									>
																										if {[N ubelong 512 0 0 {} {} > 522199072]} {
																											>
																												if {[N ubyte 513 0 0 {} {} > 0]} {
																													>
																														U 60 dbase3-memo-print 0
	
																													<
																												}
	
																											<
																										}
	
																									<
																								}
	
																							<
																						}
	
																					<
																				}
	
																			<
																		}
	
																		if {[N ubelong 8 0 0 {} {} != 0]} {
																			>
																				if {[N ubeshort 510 0 0 {} {} == 0]} {
																					>
																						if {[N ubyte 0 0 0 {} {} > 5]} {
																							>
																								if {[N ubyte 0 0 0 {} {} < 48]} {
																									>
																										U 60 dbase3-memo-print 0
	
																									<
																								}
	
																							<
																						}
	
																					<
																				}
	
																			<
																		}
	
																	<
																}
	
																if {[N uleshort 20 0 0 {} {} > 0]} {
																	>
																		if {[N uleshort 20 0 0 & 32783 == 0]} {
																			>
																				U 60 dbase4-memo-print 0
	
																			<
																		}
	
																	<
																}
	
															<
														}
														3 {
															>
																U 60 dbase3-memo-print 0
	
															<
														}
													}
	
												<
											}
	
										<
									}
	
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 4 0 {} {} eq Standard\ Jet\ DB]} {
		>
			emit {Microsoft Access Database}
			mime application/x-msaccess
		<
	}
	
	if {[S string 4 0 {} {} eq Standard\ ACE\ DB]} {
		>
			emit {Microsoft Access Database}
			mime application/x-msaccess
		<
	}
	
	if {[N ubelong 4 0 0 {} {} == 4023233417]} {
		>
			if {[N ubelong 132 0 0 {} {} == 0]} {
				>
					emit {Extensible storage engine}
					switch [Nv ulelong 12 0 {} {}] {
						0 {
							>
								emit DataBase
								ext edb/sdb
							<
						}
						1 {
							>
								emit STreaMing
								ext stm
							<
						}
					}
	
					if {[N uleshort 8 0 0 {} {} x {}]} {
						>
							emit {\b, version 0x%x}
						<
					}
	
					if {[N uleshort 10 0 0 {} {} > 0]} {
						>
							emit {revision 0x%4.4x}
						<
					}
	
					if {[N ubelong 0 0 0 {} {} x {}]} {
						>
							emit {\b, checksum 0x%8.8x}
						<
					}
	
					if {[N ulequad 236 0 0 {} {} x {}]} {
						>
							emit {\b, page size %lld}
						<
					}
	
					switch [Nv ulelong 52 0 {} {}] {
						1 {
							>
								emit {\b, JustCreated}
							<
						}
						2 {
							>
								emit {\b, DirtyShutdown}
							<
						}
						4 {
							>
								emit {\b, BeingConverted}
							<
						}
						5 {
							>
								emit {\b, ForceDetach}
							<
						}
					}
	
					if {[N ulelong 216 0 0 {} {} x {}]} {
						>
							emit {\b, Windows version %d}
						<
					}
	
					if {[N ulelong 220 0 0 {} {} x {}]} {
						>
							emit {\b.%d}
						<
					}
	
					mime application/x-ms-ese
				<
			}
	
		<
	}
	
	if {[S string 8 0 {} {} eq sdbf]} {
		>
			if {[N ubyte 7 0 0 {} {} == 0]} {
				>
					if {[N uleshort 12 0 0 {} {} == 30722]} {
						>
							emit {Windows application compatibility Shim DataBase}
							mime application/x-ms-sdb
							ext sdb
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq TDB\ file]} {
		>
			emit {TDB database}
			if {[N lelong 32 0 0 {} {} == 637606253]} {
				>
					emit {version 6, little-endian}
					if {[N lelong 36 0 0 {} {} x {}]} {
						>
							emit {hash size %d bytes}
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 2 0 {} {} eq ICE]} {
		>
			emit {ICE authority data}
		<
	}
	
	if {[S string 10 0 {} {} eq MIT-MAGIC-COOKIE-1]} {
		>
			emit {X11 Xauthority data}
		<
	}
	
	if {[S string 11 0 {} {} eq MIT-MAGIC-COOKIE-1]} {
		>
			emit {X11 Xauthority data}
		<
	}
	
	if {[S string 12 0 {} {} eq MIT-MAGIC-COOKIE-1]} {
		>
			emit {X11 Xauthority data}
		<
	}
	
	if {[S string 13 0 {} {} eq MIT-MAGIC-COOKIE-1]} {
		>
			emit {X11 Xauthority data}
		<
	}
	
	if {[S string 14 0 {} {} eq MIT-MAGIC-COOKIE-1]} {
		>
			emit {X11 Xauthority data}
		<
	}
	
	if {[S string 15 0 {} {} eq MIT-MAGIC-COOKIE-1]} {
		>
			emit {X11 Xauthority data}
		<
	}
	
	if {[S string 16 0 {} {} eq MIT-MAGIC-COOKIE-1]} {
		>
			emit {X11 Xauthority data}
		<
	}
	
	if {[S string 17 0 {} {} eq MIT-MAGIC-COOKIE-1]} {
		>
			emit {X11 Xauthority data}
		<
	}
	
	if {[S string 18 0 {} {} eq MIT-MAGIC-COOKIE-1]} {
		>
			emit {X11 Xauthority data}
		<
	}
	
	if {[S string 0 0 {} {} eq PGDMP]} {
		>
			emit {PostgreSQL custom database dump}
			if {[N byte 5 0 0 {} {} x {}]} {
				>
					emit {- v%d}
				<
			}
	
			if {[N byte 6 0 0 {} {} x {}]} {
				>
					emit {\b.%d}
				<
			}
	
			if {[N beshort 5 0 0 {} {} < 257]} {
				>
					emit {\b-0}
				<
			}
	
			if {[N beshort 5 0 0 {} {} > 256]} {
				>
					if {[N byte 7 0 0 {} {} x {}]} {
						>
							emit {\b-%d}
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq @(\#)ADF\ Database]} {
		>
			emit {CGNS Advanced Data Format}
		<
	}
	
	if {[S string 0 0 {} {} eq ToKyO\ CaBiNeT\n]} {
		>
			emit {Tokyo Cabinet}
			if {[S string 14 0 {} {} x {}]} {
				>
					emit {\b (%s)}
				<
			}
	
			switch [Nv byte 32 0 {} {}] {
				0 {
					>
						emit {\b, Hash}
						mime application/x-tokyocabinet-hash
					<
				}
				1 {
					>
						emit {\b, B+ tree}
						mime application/x-tokyocabinet-btree
					<
				}
				2 {
					>
						emit {\b, Fixed-length}
						mime application/x-tokyocabinet-fixed
					<
				}
				3 {
					>
						emit {\b, Table}
						mime application/x-tokyocabinet-table
					<
				}
			}
	
			if {[N byte 33 0 0 {} {} & 1]} {
				>
					emit {\b, [open]}
				<
			}
	
			if {[N byte 33 0 0 {} {} & 2]} {
				>
					emit {\b, [fatal]}
				<
			}
	
			if {[N byte 34 0 0 {} {} x {}]} {
				>
					emit {\b, apow=%d}
				<
			}
	
			if {[N byte 35 0 0 {} {} x {}]} {
				>
					emit {\b, fpow=%d}
				<
			}
	
			if {[N byte 36 0 0 {} {} & 1]} {
				>
					emit {\b, [large]}
				<
			}
	
			if {[N byte 36 0 0 {} {} & 2]} {
				>
					emit {\b, [deflate]}
				<
			}
	
			if {[N byte 36 0 0 {} {} & 4]} {
				>
					emit {\b, [bzip]}
				<
			}
	
			if {[N byte 36 0 0 {} {} & 8]} {
				>
					emit {\b, [tcbs]}
				<
			}
	
			if {[N byte 36 0 0 {} {} & 16]} {
				>
					emit {\b, [excodec]}
				<
			}
	
			if {[N lequad 40 0 0 {} {} x {}]} {
				>
					emit {\b, bnum=%lld}
				<
			}
	
			if {[N lequad 48 0 0 {} {} x {}]} {
				>
					emit {\b, rnum=%lld}
				<
			}
	
			if {[N lequad 56 0 0 {} {} x {}]} {
				>
					emit {\b, fsiz=%lld}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \\\[depot\\\]\n\f]} {
		>
			emit {Quick Database Manager, little endian}
		<
	}
	
	if {[S string 0 0 {} {} eq \\\[DEPOT\\\]\n\f]} {
		>
			emit {Quick Database Manager, big endian}
		<
	}
	
	if {[S string 0 0 {} {} eq ToKyO\ CaBiNeT\n]} {
		>
			emit {TokyoCabinet database}
			if {[S string 14 0 {} {} x {}]} {
				>
					emit {(version %s)}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq FS21]} {
		>
			emit {Zope Object Database File Storage v3 (data)}
		<
	}
	
	if {[S string 0 0 {} {} eq FS30]} {
		>
			emit {Zope Object Database File Storage v4 (data)}
		<
	}
	
	if {[S string 0 0 {} {} eq ZEC3]} {
		>
			emit {Zope Object Database Client Cache File (data)}
		<
	}
	
	if {[S string 0 0 {} {} eq IDA1]} {
		>
			emit {IDA (Interactive Disassembler) database}
		<
	}
	
	if {[S string 0 0 {} {} eq hopperdb]} {
		>
			emit {Hopper database}
		<
	}
	
	if {[N ubyte 5 0 0 {} {} > 0]} {
		>
			if {[N ubelong [I 5 ubyte 0 + 0 7] 0 0 & 4093636608 == 0]} {
				>
					if {[S search [R 1] 0 {} 2 eq DESIGN]} {
						>
							emit {Panorama database}
							if {[S pstring 5 0 {} {} x {}]} {
								>
									emit {\b, "%s"}
								<
							}
	
							ext pan
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq askw40\0]} {
		>
			emit {askSam DB}
		<
	}
	
	if {[S string 0 0 {} {} eq MBSTV\040]} {
		>
			emit {MUIbase DB}
			if {[S string 6 0 {} {} x {}]} {
				>
					emit {version %s}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq NBCDB\012]} {
		>
			emit {NetBSD Constant Database}
			if {[N byte 7 0 0 {} {} x {}]} {
				>
					emit {\b, version %d}
				<
			}
	
			if {[S string 8 0 {} {} x {}]} {
				>
					emit {\b, for '%s'}
				<
			}
	
			if {[N lelong 24 0 0 {} {} x {}]} {
				>
					emit {\b, datasize %d}
				<
			}
	
			if {[N lelong 28 0 0 {} {} x {}]} {
				>
					emit {\b, entries %d}
				<
			}
	
			if {[N lelong 32 0 0 {} {} x {}]} {
				>
					emit {\b, index %d}
				<
			}
	
			if {[N lelong 36 0 0 {} {} x {}]} {
				>
					emit {\b, seed %#x}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq REDIS]} {
		>
			emit {Redis RDB file,}
			if {[S regex 5 0 {} {} eq \[0-9\]\[0-9\]\[0-9\]\[0-9\]]} {
				>
					emit {version %s}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq //\ <!--\ <mdb:mork:z\ v=\"]} {
		>
			emit {Mozilla Mork database}
			if {[S string 23 0 {} {} x {}]} {
				>
					emit {\b, version %.3s}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} < ?xml]} {
		>
			if {[S regex [R 0] 0 {} {} eq (eml)-\[0-9\].\[0-9\].\[0-9\]+]} {
				>
					emit eml://ecoinformatics.org/%s
				<
			}
	
			if {[S regex [R 0] 0 {} {} eq (onedcx/v)\[0-9\].\[0-9\]+]} {
				>
					emit http://ns.dataone.org/metadata/schema/onedcx/v1.0
				<
			}
	
			if {[S regex [R 0] 0 {} {} eq fgdc]} {
				>
					emit FGDC-STD-001-1998
				<
			}
	
			if {[S regex [R 0] 0 {} {} eq (mercury/terms/v)\[0-9\].\[0-9\]]} {
				>
					emit http://purl.org/ornl/schema/mercury/terms/v1.0
				<
			}
	
			if {[S regex [R 0] 0 {} {} eq isotc211]} {
				>
					if {[S regex [R 0] 0 {} {} eq eng\;USA]} {
						>
							emit http://www.isotc211.org/2005/gmd
						<
					}
	
					if {[S regex [R 0] 0 {} {} eq gov.noaa.nodc:\[0-9\]+]} {
						>
							emit http://www.isotc211.org/2005/gmd-noaa
						<
					}
	
					if {[S regex [R 0] 0 {} {} eq pangaea.dataset\[0-9\]\[0-9\]\[0-9\]\[0-9\]\[0-9\]\[0-9\]+]} {
						>
							emit http://www.isotc211.org/2005/gmd-pangaea
							mime text/xml
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} < ?xml]} {
		>
			if {[S regex [R 0] 0 {} {} eq rdf]} {
				>
					if {[S regex [R 0] 0 {} {} eq openarchives]} {
						>
							emit http://www.openarchives.org/ore/terms
							mime application/rdf+xml
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} < DryadData]} {
		>
			if {[S regex [R 0] 0 {} {} eq (dryad-bibo/v)\[0-9\].\[0-9\]]} {
				>
					emit http://datadryad.org/profile/v3.1
					mime text/xml
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq DBPF]} {
		>
			emit {Maxis Database Packed File}
			if {[N ulelong 4 0 0 {} {} x {}]} {
				>
					emit {\b, version: %u.}
					if {[N ulelong 8 0 0 {} {} x {}]} {
						>
							emit {\b%u}
							if {[N ulelong 36 0 0 {} {} x {}]} {
								>
									emit {\b, files: %u}
								<
							}
	
						<
					}
	
					if {[N ledate 24 0 0 {} {} != 0]} {
						>
							emit {\b, created: %s}
						<
					}
	
					if {[N ledate 28 0 0 {} {} != 0]} {
						>
							emit {\b, modified: %s}
							mime application/x-maxis-dbpf
							ext dbpf/package/dat/sc4
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq <list>\n<protocol\ bbn-m]} {
		>
			emit {Diamond Multimedia Document}
		<
	}
	
	if {[S search 0 0 {} 1 eq diff\040]} {
		>
			emit {diff output text}
			mime text/x-diff
		<
	}
	
	if {[S search 0 0 {} 1 eq ***\040]} {
		>
			emit {diff output text}
			mime text/x-diff
		<
	}
	
	if {[S search 0 0 {} 1 eq Only\040in\040]} {
		>
			emit {diff output text}
			mime text/x-diff
		<
	}
	
	if {[S search 0 0 {} 1 eq Common\040subdirectories:\040]} {
		>
			emit {diff output text}
			mime text/x-diff
		<
	}
	
	if {[S search 0 0 {} 1 eq Index:]} {
		>
			emit {RCS/CVS diff output text}
			mime text/x-diff
		<
	}
	
	if {[S string 0 0 b {} eq BSDIFF40]} {
		>
			emit {bsdiff(1) patch file}
		<
	}
	
	if {[S search 0 0 {} 4096 eq ---\040]} {
		>
			if {[S search [R 0] 0 {} 1024 eq \n]} {
				>
					if {[S search [R 0] 0 {} 1 eq +++\040]} {
						>
							if {[S search [R 0] 0 {} 1024 eq \n]} {
								>
									if {[S search [R 0] 0 {} 1 eq @@]} {
										>
											emit {unified diff output text}
											mime text/x-diff
											strength {+ 90}
										<
									}
	
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq !<arch>\n________64E]} {
		>
			emit {Alpha archive}
			if {[S string 22 0 {} {} eq X]} {
				>
					emit {-- out of date}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq Core\001]} {
		>
			emit {Alpha COFF format core dump (Digital UNIX)}
			if {[S string 24 0 {} {} > \0]} {
				>
					emit {\b, from '%s'}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq Core\002]} {
		>
			emit {Alpha COFF format core dump (Digital UNIX)}
			if {[S string 24 0 {} {} > \0]} {
				>
					emit {\b, from '%s'}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \377\377\177]} {
		>
			emit ddis/ddif
		<
	}
	
	if {[S string 0 0 {} {} eq \377\377\174]} {
		>
			emit {ddis/dots archive}
		<
	}
	
	if {[S string 0 0 {} {} eq \377\377\176]} {
		>
			emit {ddis/dtif table data}
		<
	}
	
	if {[S string 0 0 {} {} eq \033c\033]} {
		>
			emit {LN03 output}
		<
	}
	
	if {[S string 0 0 {} {} eq !<PDF>!\n]} {
		>
			emit {profiling data file}
		<
	}
	
	switch [Nv lelong 24 0 {} {}] {
		60011 {
			>
				emit {old-fs dump file (little endian),}
				U 68 old-dump-be 0
	
			<
		}
		60012 {
			>
				emit {new-fs dump file (little endian),}
				U 68 new-dump-be 0
	
			<
		}
		424935705 {
			>
				emit {new-fs dump file (ufs2, little endian),}
				U 68 ufs2-dump-be 0
	
			<
		}
	}
	
	if {[N leshort 18 0 0 {} {} == -5525]} {
		>
			emit {old-fs dump file (16-bit, assuming PDP-11 endianness),}
			if {[N medate 2 0 0 {} {} x {}]} {
				>
					emit {Previous dump %s,}
				<
			}
	
			if {[N medate 6 0 0 {} {} x {}]} {
				>
					emit {This dump %s,}
				<
			}
	
			if {[N leshort 10 0 0 {} {} > 0]} {
				>
					emit {Volume %d,}
				<
			}
	
			switch [Nv leshort 0 0 {} {}] {
				1 {
					>
						emit {tape header.}
					<
				}
				2 {
					>
						emit {beginning of file record.}
					<
				}
				3 {
					>
						emit {map of inodes on tape.}
					<
				}
				4 {
					>
						emit {continuation of file record.}
					<
				}
				5 {
					>
						emit {end of volume.}
					<
				}
				6 {
					>
						emit {map of inodes deleted.}
					<
				}
				7 {
					>
						emit {end of medium (for floppy).}
					<
				}
			}
	
		<
	}
	
	if {[N ubeshort 0 0 0 & 65376 == 43520]} {
		>
			if {[N byte 1 0 0 {} {} != 4]} {
				>
					if {[N ubeshort 2 0 0 {} {} > 0]} {
						>
							emit {Dyalog APL}
							switch [Nv byte 1 0 {} {}] {
								-128 {
									>
										emit DDB
									<
								}
								0 {
									>
										emit aplcore
									<
								}
								1 {
									>
										emit {component file 32-bit non-journaled non-checksummed}
									<
								}
								2 {
									>
										emit {external variable exclusive}
									<
								}
								3 {
									>
										emit workspace
										switch [Nv byte 7 0 & 40] {
											0 {
												>
													emit 32-bit
												<
											}
											32 {
												>
													emit 64-bit
												<
											}
										}
	
										switch [Nv byte 7 0 & 12] {
											0 {
												>
													emit classic
												<
											}
											4 {
												>
													emit unicode
												<
											}
										}
	
										switch [Nv byte 7 0 & -120] {
											-128 {
												>
													emit little-endian
												<
											}
											0 {
												>
													emit big-endian
												<
											}
										}
	
									<
								}
								6 {
									>
										emit {external variable shared}
									<
								}
								7 {
									>
										emit session
									<
								}
								8 {
									>
										emit {mapped file 32-bit}
									<
								}
								9 {
									>
										emit {component file 64-bit non-journaled non-checksummed}
									<
								}
								10 {
									>
										emit {mapped file 64-bit}
									<
								}
								11 {
									>
										emit {component file 32-bit level 1 journaled non-checksummed}
									<
								}
								12 {
									>
										emit {component file 64-bit level 1 journaled non-checksummed}
									<
								}
								13 {
									>
										emit {component file 32-bit level 1 journaled checksummed}
									<
								}
								14 {
									>
										emit {component file 64-bit level 1 journaled checksummed}
									<
								}
								15 {
									>
										emit {component file 32-bit level 2 journaled checksummed}
									<
								}
								16 {
									>
										emit {component file 64-bit level 2 journaled checksummed}
									<
								}
								17 {
									>
										emit {component file 32-bit level 3 journaled checksummed}
									<
								}
								18 {
									>
										emit {component file 64-bit level 3 journaled checksummed}
									<
								}
								19 {
									>
										emit {component file 32-bit non-journaled checksummed}
									<
								}
								20 {
									>
										emit {component file 64-bit non-journaled checksummed}
									<
								}
								21 {
									>
										emit {component file under construction}
									<
								}
								22 {
									>
										emit {DFS component file 64-bit level 1 journaled checksummed}
									<
								}
								23 {
									>
										emit {DFS component file 64-bit level 2 journaled checksummed}
									<
								}
								24 {
									>
										emit {DFS component file 64-bit level 3 journaled checksummed}
									<
								}
								25 {
									>
										emit {external workspace}
									<
								}
							}
	
							if {[N byte 2 0 0 {} {} x {}]} {
								>
									emit {version %d}
								<
							}
	
							if {[N byte 3 0 0 {} {} x {}]} {
								>
									emit {\b.%d}
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq @CT\ ]} {
		>
			emit {T602 document data,}
			if {[S string 4 0 {} {} eq 0]} {
				>
					emit Kamenicky
				<
			}
	
			if {[S string 4 0 {} {} eq 1]} {
				>
					emit {CP 852}
				<
			}
	
			if {[S string 4 0 {} {} eq 2]} {
				>
					emit KOI8-CS
				<
			}
	
			if {[S string 4 0 {} {} > 2]} {
				>
					emit {unknown encoding}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq VimCrypt~]} {
		>
			emit {Vim encrypted file data}
		<
	}
	
	if {[S string 0 0 {} {} eq b0VIM\ ]} {
		>
			emit {Vim swap file}
			if {[S string [R 0] 0 {} {} > \0]} {
				>
					emit {\b, version %s}
				<
			}
	
			U 71 vimnanoswap 0
	
		<
	}
	
	if {[S string 0 0 {} {} eq b0nano]} {
		>
			emit {Nano swap file}
			U 71 vimnanoswap 0
	
		<
	}
	
	if {[S string 0 0 {} {} eq \x00\x00\x00\x12Kate\ Swap\ File\ 2.0\x00]} {
		>
			emit {Kate swap file}
		<
	}
	
	if {[S string 0 0 {} {} eq \177ELF]} {
		>
			emit ELF
			switch [Nv byte 4 0 {} {}] {
				0 {
					>
						emit {invalid class}
					<
				}
				1 {
					>
						emit 32-bit
					<
				}
				2 {
					>
						emit 64-bit
					<
				}
			}
	
			switch [Nv byte 5 0 {} {}] {
				0 {
					>
						emit {invalid byte order}
					<
				}
				1 {
					>
						emit LSB
						U 73 elf-le 0
	
					<
				}
				2 {
					>
						emit MSB
						U 73 elf-le 0
	
					<
				}
			}
	
			switch [Nv byte 7 0 {} {}] {
				-54 {
					>
						emit {(Cafe OS)}
					<
				}
				-1 {
					>
						emit (embedded)
					<
				}
				0 {
					>
						emit (SYSV)
					<
				}
				1 {
					>
						emit (HP-UX)
					<
				}
				2 {
					>
						emit (NetBSD)
					<
				}
				3 {
					>
						emit (GNU/Linux)
					<
				}
				4 {
					>
						emit (GNU/Hurd)
					<
				}
				5 {
					>
						emit (86Open)
					<
				}
				6 {
					>
						emit (Solaris)
					<
				}
				7 {
					>
						emit (Monterey)
					<
				}
				8 {
					>
						emit (IRIX)
					<
				}
				9 {
					>
						emit (FreeBSD)
					<
				}
				10 {
					>
						emit (Tru64)
					<
				}
				11 {
					>
						emit {(Novell Modesto)}
					<
				}
				12 {
					>
						emit (OpenBSD)
					<
				}
				13 {
					>
						emit (OpenVMS)
					<
				}
				14 {
					>
						emit {(HP NonStop Kernel)}
					<
				}
				15 {
					>
						emit {(AROS Research Operating System)}
					<
				}
				16 {
					>
						emit (FenixOS)
					<
				}
				17 {
					>
						emit {(Nuxi CloudABI)}
					<
				}
				97 {
					>
						emit (ARM)
					<
				}
			}
	
			strength *2
		<
	}
	
	if {[S string 0 0 {} {} eq \0177BEAM!]} {
		>
			emit {Old Erlang BEAM file}
			if {[N short 6 0 0 {} {} > 0]} {
				>
					emit {- version %d}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq FOR1]} {
		>
			if {[S string 8 0 {} {} eq BEAM]} {
				>
					emit {Erlang BEAM file}
				<
			}
	
		<
	}
	
	if {[S string 4 0 {} {} eq Tue\ Jan\ 22\ 14:32:44\ MET\ 1991]} {
		>
			emit {Erlang JAM file - version 4.2}
		<
	}
	
	if {[S string 79 0 {} {} eq Tue\ Jan\ 22\ 14:32:44\ MET\ 1991]} {
		>
			emit {Erlang JAM file - version 4.2}
		<
	}
	
	if {[S string 4 0 {} {} eq 1.0\ Fri\ Feb\ 3\ 09:55:56\ MET\ 1995]} {
		>
			emit {Erlang JAM file - version 4.3}
		<
	}
	
	if {[S string 0 0 {} {} eq FCS1.0]} {
		>
			emit {Flow Cytometry Standard (FCS) data, version 1.0}
		<
	}
	
	if {[S string 0 0 {} {} eq FCS2.0]} {
		>
			emit {Flow Cytometry Standard (FCS) data, version 2.0}
		<
	}
	
	if {[S string 0 0 {} {} eq FCS3.0]} {
		>
			emit {Flow Cytometry Standard (FCS) data, version 3.0}
		<
	}
	
	if {[S string 0 0 {} {} eq \366\366\366\366]} {
		>
			emit {PC formatted floppy with no filesystem}
		<
	}
	
	if {[N beshort 508 0 0 {} {} == -9538]} {
		>
			if {[N long 504 0 0 {} {} > 0]} {
				>
					emit {Sun disk label}
					if {[S string 0 0 {} {} x {}]} {
						>
							emit '%s
							if {[S string 31 0 {} {} > \0]} {
								>
									emit {\b%s}
									if {[S string 63 0 {} {} > \0]} {
										>
											emit {\b%s}
											if {[S string 95 0 {} {} > \0]} {
												>
													emit {\b%s}
												<
											}
	
										<
									}
	
								<
							}
	
						<
					}
	
					if {[S string 0 0 {} {} x {}]} {
						>
							emit {\b'}
						<
					}
	
					if {[N short 476 0 0 {} {} > 0]} {
						>
							emit {%d rpm,}
						<
					}
	
					if {[N short 478 0 0 {} {} > 0]} {
						>
							emit {%d phys cys,}
						<
					}
	
					if {[N short 480 0 0 {} {} > 0]} {
						>
							emit {%d alts/cyl,}
						<
					}
	
					if {[N short 486 0 0 {} {} > 0]} {
						>
							emit {%d interleave,}
						<
					}
	
					if {[N short 488 0 0 {} {} > 0]} {
						>
							emit {%d data cyls,}
						<
					}
	
					if {[N short 490 0 0 {} {} > 0]} {
						>
							emit {%d alt cyls,}
						<
					}
	
					if {[N short 492 0 0 {} {} > 0]} {
						>
							emit {%d heads/partition,}
						<
					}
	
					if {[N short 494 0 0 {} {} > 0]} {
						>
							emit {%d sectors/track,}
						<
					}
	
					if {[N long 500 0 0 {} {} > 0]} {
						>
							emit {start cyl %d,}
						<
					}
	
					if {[N long 504 0 0 {} {} x {}]} {
						>
							emit {%d blocks}
						<
					}
	
				<
			}
	
			if {[N belong 512 0 0 & 16777215 == 196871]} {
				>
					emit {\b, boot block present}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq SBMBAKUP_]} {
		>
			emit {Smart Boot Manager backup file}
			if {[S string 9 0 {} {} x {}]} {
				>
					emit {\b, version %-5.5s}
					if {[S string 14 0 {} {} eq _]} {
						>
							if {[S string 15 0 {} {} x {}]} {
								>
									emit %-.1s
									if {[S string 16 0 {} {} eq _]} {
										>
											emit {\b.}
											if {[S string 17 0 {} {} x {}]} {
												>
													emit {\b%-.1s}
													if {[S string 18 0 {} {} eq _]} {
														>
															emit {\b.}
															if {[S string 19 0 {} {} x {}]} {
																>
																	emit {\b%-.1s}
																<
															}
	
														<
													}
	
												<
											}
	
										<
									}
	
								<
							}
	
							if {[N ubyte 22 0 0 {} {} == 0]} {
								>
									if {[N ubyte 21 0 0 {} {} x {}]} {
										>
											emit {\b, from drive 0x%x}
										<
									}
	
								<
							}
	
							if {[N ubyte 22 0 0 {} {} > 0]} {
								>
									if {[S string 21 0 {} {} x {}]} {
										>
											emit {\b, from drive %s}
										<
									}
	
								<
							}
	
							if {[S search 535 0 {} 17 eq \x55\xAA]} {
								>
									emit {\b; contains}
									T [R -512] {}
	
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq DOSEMU\0]} {
		>
			if {[N leshort 638 0 0 {} {} == -21931]} {
				>
					if {[N ubyte 19 0 0 {} {} == 128]} {
						>
							if {[N ubyte [I 19 ubyte 0 - 0 1] 0 0 {} {} == 0]} {
								>
									emit {DOS Emulator image}
									if {[N ulelong 7 0 0 {} {} > 0]} {
										>
											emit {\b, %u heads}
										<
									}
	
									if {[N ulelong 11 0 0 {} {} > 0]} {
										>
											emit {\b, %d sectors/track}
										<
									}
	
									if {[N ulelong 15 0 0 {} {} > 0]} {
										>
											emit {\b, %d cylinders}
										<
									}
	
									emit {\b; contains}
									T 128 {}
	
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq PNCIHISK\0]} {
		>
			emit {Norton Utilities disc image data}
			if {[S search 509 0 {} 1026 eq \x55\xAA\xeb]} {
				>
					emit {\b; contains}
					T [R -1] {}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq PNCIUNDO]} {
		>
			emit {Norton Disk Doctor UnDo file}
		<
	}
	
	if {[S search 30 0 {} 481 eq \x55\xAA]} {
		>
			if {[N uleshort 11 0 0 {} {} < 512]} {
				>
					if {[N uleshort [I 11 uleshort 0 - 0 2] 0 0 {} {} == 43605]} {
						>
							emit {DOS/MBR boot sector}
						<
					}
	
				<
			}
	
			if {[N leshort 510 0 0 {} {} == -21931]} {
				>
					emit {DOS/MBR boot sector}
				<
			}
	
			strength +65
		<
	}
	
	switch [Nv leshort 510 0 {} {}] {
		-21931 {
			>
				emit {DOS/MBR boot sector}
				if {[S string 2 0 {} {} eq OSBS]} {
					>
						emit {OS/BS MBR}
					<
				}
	
				if {[S search 0 0 {} 2 eq \x33\xc0\x8e\xd0\xbc\x00\x7c]} {
					>
						emit MS-MBR
						switch [Nv ubequad 8 0 {} {}] {
							5766665946185735036 {
								>
									switch [Nv ubequad 24 0 {} {}] {
										17556381263194468612 {
											>
												emit XP
												switch [Nv ubelong 436 0 & 16777215] {
													2901091 {
														>
															emit english
														<
													}
													2902126 {
														>
															emit german
														<
													}
												}
	
												if {[N ubyte 437 0 0 {} {} > 0]} {
													>
														emit {at offset 0x1%x}
													<
												}
	
												if {[S string [I 437 ubyte 0 + 0 256] 0 {} {} > \0]} {
													>
														emit {"%s"}
													<
												}
	
												if {[N ubyte 438 0 0 {} {} > 0]} {
													>
														emit {at offset 0x1%x}
													<
												}
	
												if {[S string [I 438 ubyte 0 + 0 256] 0 {} {} > \0]} {
													>
														emit {"%s"}
													<
												}
	
												if {[N ubyte 439 0 0 {} {} > 0]} {
													>
														emit {at offset 0x1%x}
													<
												}
	
												if {[S string [I 439 ubyte 0 + 0 256] 0 {} {} > \0]} {
													>
														emit {"%s"}
													<
												}
	
											<
										}
										17556381267489435908 {
											>
												emit 9M
												if {[S string [I 60 ubyte 0 + 0 255] 0 {} {} eq Invalid\ partition\ table]} {
													>
														emit english
													<
												}
	
												if {[S string [I 60 ubyte 0 + 0 255] 0 {} {} eq Ung\201ltige\ Partitionstabelle]} {
													>
														emit german
													<
												}
	
												if {[S string [I 60 ubyte 0 + 0 255] 0 {} {} eq Table\ de\ partition\ erron\202e]} {
													>
														emit french
													<
												}
	
												if {[S string [I 60 ubyte 0 + 0 255] 0 {} {} eq \215\245\257\340\240\242\250\253\354\255\240\357\ \342\240\241\253\250\346\240]} {
													>
														emit russian
													<
												}
	
												if {[N ubyte 60 0 0 {} {} x {}]} {
													>
														emit {at offset 0x%x+0xFF}
													<
												}
	
												if {[S string [I 60 ubyte 0 + 0 255] 0 {} {} > \0]} {
													>
														emit {"%s"}
													<
												}
	
												if {[N ubyte 189 0 0 {} {} x {}]} {
													>
														emit {at offset 0x1%x}
													<
												}
	
												if {[S string [I 189 ubyte 0 + 0 256] 0 {} {} > \0]} {
													>
														emit {"%s"}
													<
												}
	
												if {[N ubyte 169 0 0 {} {} x {}]} {
													>
														emit {at offset 0x1%x}
													<
												}
	
												if {[S string [I 169 ubyte 0 + 0 256] 0 {} {} > \0]} {
													>
														emit {"%s"}
													<
												}
	
											<
										}
									}
	
								<
							}
							10084773457928649724 {
								>
									switch [Nv ubyte 22 0 {} {}] {
										242 {
											>
												if {[N ubequad 34 0 0 {} {} == 13797911610017883509]} {
													>
														emit {\b,NEC 3.3}
													<
												}
	
												if {[D 34]} {
													>
														emit {\b,D0S version 3.3-7.0}
														if {[S string [I 73 ubyte 0 + 0 0] 0 {} {} eq Invalid\ partition\ table]} {
															>
																emit english
															<
														}
	
														if {[S string [I 73 ubyte 0 + 0 0] 0 {} {} eq Ung\201ltige\ Partitionstabelle]} {
															>
																emit german
															<
														}
	
														if {[S string [I 73 ubyte 0 + 0 0] 0 {} {} eq Table\ de\ partition\ invalide]} {
															>
																emit french
															<
														}
	
														if {[S string [I 73 ubyte 0 + 0 0] 0 {} {} eq Tabela\ de\ parti\207ao\ inv\240lida]} {
															>
																emit portuguese
															<
														}
	
														if {[S string [I 73 ubyte 0 + 0 0] 0 {} {} eq Tabla\ de\ partici\242n\ no\ v\240lida]} {
															>
																emit spanish
															<
														}
	
														if {[S string [I 73 ubyte 0 + 0 0] 0 {} {} eq Tavola\ delle\ partizioni\ non\ valida]} {
															>
																emit italian
															<
														}
	
														if {[N ubyte 73 0 0 {} {} > 0]} {
															>
																emit {at offset 0x%x}
																if {[S string [I 73 ubyte 0 + 0 0] 0 {} {} > \0]} {
																	>
																		emit {"%s"}
																	<
																}
	
															<
														}
	
														if {[N ubyte 116 0 0 {} {} > 0]} {
															>
																emit {at offset 0x%x}
																if {[S string [I 116 ubyte 0 + 0 0] 0 {} {} > \0]} {
																	>
																		emit {"%s"}
																	<
																}
	
															<
														}
	
														if {[N ubyte 121 0 0 {} {} > 0]} {
															>
																emit {at offset 0x%x}
																if {[S string [I 121 ubyte 0 + 0 0] 0 {} {} > \0]} {
																	>
																		emit {"%s"}
																	<
																}
	
															<
														}
	
													<
												}
	
											<
										}
										243 {
											>
												emit {\b,DOS 2}
												if {[S regex 219 0 {} {} eq Author\ -\ ]} {
													>
														emit Author:
														if {[S string [R 0] 0 {} {} x {}]} {
															>
																emit {"%s"}
															<
														}
	
													<
												}
	
											<
										}
									}
	
								<
							}
							13875265812538638080 {
								>
									switch [Nv ubequad 236 0 {} {}] {
										7386461203189481845 {
											>
												emit {Windows 7}
												if {[N ubelong 436 0 0 & 16777215 == 6519706]} {
													>
														emit english
													<
												}
	
												if {[N ubyte 437 0 0 {} {} > 0]} {
													>
														emit {at offset 0x1%x}
													<
												}
	
												if {[S string [I 437 ubyte 0 + 0 256] 0 {} {} > \0]} {
													>
														emit {"%s"}
													<
												}
	
												if {[N ubyte 438 0 0 {} {} > 0]} {
													>
														emit {at offset 0x1%x}
													<
												}
	
												if {[S string [I 438 ubyte 0 + 0 256] 0 {} {} > \0]} {
													>
														emit {"%s"}
													<
												}
	
												if {[N ubyte 439 0 0 {} {} > 0]} {
													>
														emit {at offset 0x1%x}
													<
												}
	
												if {[S string [I 439 ubyte 0 + 0 256] 0 {} {} > \0]} {
													>
														emit {"%s"}
													<
												}
	
											<
										}
										8447458234516915024 {
											>
												emit Vista
												if {[N ubelong 436 0 0 & 16777215 == 6453913]} {
													>
														emit english
													<
												}
	
												if {[N ubyte 437 0 0 {} {} > 0]} {
													>
														emit {at offset 0x1%x}
													<
												}
	
												if {[S string [I 437 ubyte 0 + 0 256] 0 {} {} > \0]} {
													>
														emit {"%s"}
													<
												}
	
												if {[N ubyte 438 0 0 {} {} > 0]} {
													>
														emit {at offset 0x1%x}
													<
												}
	
												if {[S string [I 438 ubyte 0 + 0 256] 0 {} {} > \0]} {
													>
														emit {"%s"}
													<
												}
	
												if {[N ubyte 439 0 0 {} {} > 0]} {
													>
														emit {at offset 0x1%x}
													<
												}
	
												if {[S string [I 439 ubyte 0 + 0 256] 0 {} {} > \0]} {
													>
														emit {"%s"}
													<
												}
	
											<
										}
									}
	
								<
							}
						}
	
						if {[N ulelong 440 0 0 {} {} > 0]} {
							>
								emit {\b, disk signature 0x%-.4x}
							<
						}
	
						if {[N uleshort 218 0 0 {} {} == 0]} {
							>
								if {[N ulelong 220 0 0 {} {} > 0]} {
									>
										emit {\b, created}
										if {[N ubyte 220 0 0 {} {} x {}]} {
											>
												emit {with driveID 0x%x}
											<
										}
	
										if {[N ubyte 223 0 0 {} {} x {}]} {
											>
												emit {at %x}
											<
										}
	
										if {[N ubyte 222 0 0 {} {} x {}]} {
											>
												emit {\b:%x}
											<
										}
	
										if {[N ubyte 221 0 0 {} {} x {}]} {
											>
												emit {\b:%x}
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
				if {[N ubequad 0 0 0 {} {} == 18066242684150922240]} {
					>
						if {[N ubequad 8 0 0 {} {} == 142985680396521176]} {
							>
								emit {MS-MBR,D0S version 3.21 spanish}
							<
						}
	
					<
				}
	
				if {[S string 157 0 {} {} eq Invalid\ partition\ table\$]} {
					>
						if {[S string 181 0 {} {} eq No\ Operating\ System\$]} {
							>
								if {[S string 201 0 {} {} eq Operating\ System\ load\ error\$]} {
									>
										emit {\b, DR-DOS MBR, Version 7.01 to 7.03}
									<
								}
	
							<
						}
	
					<
				}
	
				if {[S string 157 0 {} {} eq Invalid\ partition\ table\$]} {
					>
						if {[S string 181 0 {} {} eq No\ operating\ system\$]} {
							>
								if {[S string 201 0 {} {} eq Operating\ system\ load\ error\$]} {
									>
										emit {\b, DR-DOS MBR, Version 7.01 to 7.03}
									<
								}
	
							<
						}
	
					<
				}
	
				if {[S string 342 0 {} {} eq Invalid\ partition\ table\$]} {
					>
						if {[S string 366 0 {} {} eq No\ operating\ system\$]} {
							>
								if {[S string 386 0 {} {} eq Operating\ system\ load\ error\$]} {
									>
										emit {\b, DR-DOS MBR, version 7.01 to 7.03}
									<
								}
	
							<
						}
	
					<
				}
	
				if {[S string 295 0 {} {} eq NEWLDR\0]} {
					>
						if {[S string 302 0 {} {} eq Bad\ PT\ \$]} {
							>
								if {[S string 310 0 {} {} eq No\ OS\ \$]} {
									>
										if {[S string 317 0 {} {} eq OS\ load\ err\$]} {
											>
												if {[S string 329 0 {} {} eq Moved\ or\ missing\ IBMBIO.LDR\n\r]} {
													>
														if {[S string 358 0 {} {} eq Press\ any\ key\ to\ continue.\n\r\$]} {
															>
																if {[S string 387 0 {} {} eq Copyright\ (c)\ 1984,1998]} {
																	>
																		if {[S string 411 0 {} {} eq Caldera\ Inc.\0]} {
																			>
																				emit {\b, DR-DOS MBR (IBMBIO.LDR)}
																			<
																		}
	
																	<
																}
	
															<
														}
	
													<
												}
	
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
				if {[S search 325 0 {} 7 eq Default:\ F]} {
					>
						emit {\b, FREE-DOS MBR}
					<
				}
	
				if {[S string 64 0 {} {} eq no\ active\ partition\ found]} {
					>
						if {[S string 96 0 {} {} eq read\ error\ while\ reading\ drive]} {
							>
								emit {\b, FREE-DOS Beta 0.9 MBR}
							<
						}
	
					<
				}
	
				if {[S search 387 0 {} 4 eq \0\ Error!\r]} {
					>
						if {[S search 378 0 {} 7 eq Virus!]} {
							>
								if {[S search 397 0 {} 4 eq Booting\040]} {
									>
										if {[S search 408 0 {} 4 eq HD1/\0]} {
											>
												emit {\b, Ranish MBR (}
												if {[S string 416 0 {} {} eq Writing\ changes...]} {
													>
														emit {\b2.37}
														if {[N ubyte 438 0 0 {} {} x {}]} {
															>
																emit {\b,0x%x dots}
															<
														}
	
														if {[N ubyte 440 0 0 {} {} > 0]} {
															>
																emit {\b,virus check}
															<
														}
	
														if {[N ubyte 441 0 0 {} {} > 0]} {
															>
																emit {\b,partition %c}
															<
														}
	
													<
												}
	
												if {[S string 416 0 {} {} ne Writing\ changes...]} {
													>
														emit {\b}
														if {[N ubyte 418 0 0 {} {} == 1]} {
															>
																emit {\bvirus check,}
															<
														}
	
														if {[N ubyte 419 0 0 {} {} x {}]} {
															>
																emit {\b0x%x seconds}
															<
														}
	
														if {[N ubyte 420 0 0 & 15 > 0]} {
															>
																emit {\b,partition}
																if {[N ubyte 420 0 0 & 15 < 5]} {
																	>
																		emit {\b %x}
																	<
																}
	
																if {[N ubyte 420 0 0 & 15 == 15]} {
																	>
																		emit {\b ask}
																	<
																}
	
															<
														}
	
													<
												}
	
												if {[N ubyte 420 0 0 {} {} x {}]} {
													>
														emit {\b)}
													<
												}
	
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
				if {[S string 362 0 {} {} eq MBR\ Error\ \0\r]} {
					>
						if {[S string 376 0 {} {} eq ress\ any\ key\ to\040]} {
							>
								if {[S string 392 0 {} {} eq boot\ from\ floppy...\0]} {
									>
										emit {\b, Acronis MBR}
									<
								}
	
							<
						}
	
					<
				}
	
				if {[S string 309 0 {} {} eq No\ bootable\ partition\ found\r]} {
					>
						if {[S string 339 0 {} {} eq I/O\ Error\ reading\ boot\ sector\r]} {
							>
								emit {\b, Visopsys MBR}
							<
						}
	
					<
				}
	
				if {[S string 349 0 {} {} eq No\ bootable\ partition\ found\r]} {
					>
						if {[S string 379 0 {} {} eq I/O\ Error\ reading\ boot\ sector\r]} {
							>
								emit {\b, simple Visopsys MBR}
							<
						}
	
					<
				}
	
				if {[S string 64 0 {} {} eq SBML]} {
					>
						if {[S string 43 0 {} {} eq SMART\ BTMGR]} {
							>
								if {[S string 430 0 {} {} eq SBMK\ Bad!\r]} {
									>
										emit {\b, Smart Boot Manager}
										if {[S string 6 0 {} {} > \0]} {
											>
												emit {\b, version %s}
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
				if {[S string 382 0 {} {} eq XOSLLOADXCF]} {
					>
						emit {\b, eXtended Operating System Loader}
					<
				}
	
				if {[S string 6 0 {} {} eq LILO]} {
					>
						emit {\b, LInux i386 boot LOader}
						if {[S string 120 0 {} {} eq LILO]} {
							>
								emit {\b, version 22.3.4 SuSe}
							<
						}
	
						if {[S string 172 0 {} {} eq LILO]} {
							>
								emit {\b, version 22.5.8 Debian}
							<
						}
	
					<
				}
	
				if {[S search 342 0 {} 60 eq \0Geom\0]} {
					>
						if {[N ubyte 65 0 0 {} {} < 2]} {
							>
								if {[N ubyte 62 0 0 {} {} > 2]} {
									>
										emit {\b; GRand Unified Bootloader}
										if {[N ubyte 62 0 0 {} {} x {}]} {
											>
												emit {\b, stage1 version 0x%x}
											<
										}
	
										if {[N ubyte 64 0 0 {} {} < 255]} {
											>
												emit {\b, boot drive 0x%x}
											<
										}
	
										if {[N ubyte 65 0 0 {} {} > 0]} {
											>
												emit {\b, LBA flag 0x%x}
											<
										}
	
										if {[N uleshort 66 0 0 {} {} < 32768]} {
											>
												emit {\b, stage2 address 0x%x}
											<
										}
	
										if {[N uleshort 66 0 0 {} {} > 32768]} {
											>
												emit {\b, stage2 address 0x%x}
											<
										}
	
										if {[N ulelong 68 0 0 {} {} > 1]} {
											>
												emit {\b, 1st sector stage2 0x%x}
											<
										}
	
										if {[N uleshort 72 0 0 {} {} < 2048]} {
											>
												emit {\b, stage2 segment 0x%x}
											<
										}
	
										if {[N uleshort 72 0 0 {} {} > 2048]} {
											>
												emit {\b, stage2 segment 0x%x}
											<
										}
	
										if {[S string 402 0 {} {} eq Geom\0Hard\ Disk\0Read\0\ Error\0]} {
											>
												if {[S string 394 0 {} {} eq stage1]} {
													>
														emit {\b, GRUB version 0.5.95}
													<
												}
	
											<
										}
	
										if {[S string 382 0 {} {} eq Geom\0Hard\ Disk\0Read\0\ Error\0]} {
											>
												if {[S string 376 0 {} {} eq GRUB\ \0]} {
													>
														emit {\b, GRUB version 0.93 or 1.94}
													<
												}
	
											<
										}
	
										if {[S string 383 0 {} {} eq Geom\0Hard\ Disk\0Read\0\ Error\0]} {
											>
												if {[S string 377 0 {} {} eq GRUB\ \0]} {
													>
														emit {\b, GRUB version 0.94}
													<
												}
	
											<
										}
	
										if {[S string 385 0 {} {} eq Geom\0Hard\ Disk\0Read\0\ Error\0]} {
											>
												if {[S string 379 0 {} {} eq GRUB\ \0]} {
													>
														emit {\b, GRUB version 0.95 or 0.96}
													<
												}
	
											<
										}
	
										if {[S string 391 0 {} {} eq Geom\0Hard\ Disk\0Read\0\ Error\0]} {
											>
												if {[S string 385 0 {} {} eq GRUB\ \0]} {
													>
														emit {\b, GRUB version 0.97}
													<
												}
	
											<
										}
	
									<
								}
	
								if {[S string 343 0 {} {} eq Geom\0Read\0\ Error\0]} {
									>
										if {[S string 321 0 {} {} eq Loading\ stage1.5]} {
											>
												emit {\b, GRUB version x.y}
											<
										}
	
									<
								}
	
								if {[S string 380 0 {} {} eq Geom\0Hard\ Disk\0Read\0\ Error\0]} {
									>
										if {[S string 374 0 {} {} eq GRUB\ \0]} {
											>
												emit {\b, GRUB version n.m}
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
				if {[S string 395 0 {} {} eq chksum\0\ ERROR!\0]} {
					>
						emit {\b, Gujin bootloader}
					<
				}
	
				if {[S string 3 0 {} {} eq BCDL]} {
					>
						if {[S string 498 0 {} {} eq BCDL\ \ \ \ BIN]} {
							>
								emit {\b, Bootable CD Loader (1.50Z)}
							<
						}
	
					<
				}
	
				if {[S string 3 0 {} {} ne IHISK]} {
					>
						if {[N belong 0 0 0 {} {} != -1195374706]} {
							>
								if {[S string 514 0 {} {} ne HdrS]} {
									>
										if {[S string 422 0 {} {} ne Be\ Boot\ Loader]} {
											>
												if {[N ubelong 0 0 0 & 4244635648 == 3909091328]} {
													>
														if {[N ubequad [I 1 ubyte 0 + 0 2] 0 0 {} {} == 18028402503091929230]} {
															>
																U 79 partition-table 446
	
															<
														}
	
													<
												}
	
												if {[N ubelong 0 0 0 & 4244635648 != 3909091328]} {
													>
														if {[S string 0 0 {} {} ne RRaA]} {
															>
																if {[N ubequad 0 0 0 {} {} != 18043126232640415371]} {
																	>
																		if {[N ubequad 0 0 0 {} {} != 7354297128558431054]} {
																			>
																				if {[S string 0 0 {} {} ne \r\n]} {
																					>
																						if {[N ubyte 446 0 0 {} {} == 0]} {
																							>
																								U 79 partition-table 446
	
																							<
																						}
	
																						if {[N ubyte 446 0 0 {} {} > 127]} {
																							>
																								U 79 partition-table 446
	
																							<
																						}
	
																					<
																				}
	
																			<
																		}
	
																	<
																}
	
															<
														}
	
													<
												}
	
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
				if {[S string 442 0 {} {} eq Non-system\ disk,\040]} {
					>
						if {[S string 459 0 {} {} eq press\ any\ key...\x7\0]} {
							>
								emit {\b, Acronis Startup Recovery Loader}
								if {[N ubyte 447 0 0 {} {} x {}]} {
									>
										emit {\b}
									<
								}
	
								U 79 DOS-filename 477
	
							<
						}
	
					<
				}
	
				if {[S string 185 0 {} {} eq FDBOOT\ Version\040]} {
					>
						if {[S string 204 0 {} {} eq \rNo\ Systemdisk.\040]} {
							>
								if {[S string 220 0 {} {} eq Booting\ from\ harddisk.\n\r]} {
									>
									<
								}
	
								if {[S string 245 0 {} {} eq Cannot\ load\ from\ harddisk.\n\r]} {
									>
										if {[S string 273 0 {} {} eq Insert\ Systemdisk\040]} {
											>
												if {[S string 291 0 {} {} eq and\ press\ any\ key.\n\r]} {
													>
														emit {\b, FDBOOT harddisk Bootloader}
														if {[S string 200 0 {} {} > \0]} {
															>
																emit {\b, version %-3s}
															<
														}
	
													<
												}
	
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
				if {[S string 242 0 {} {} eq Bootsector\ from\ C.H.\ Hochst\204]} {
					>
					<
				}
	
				if {[S search 242 0 {} 127 eq Bootsector\ from\ C.H.\ Hochst]} {
					>
						if {[S search 278 0 {} 127 eq No\ Systemdisk.\ Booting\ from\ harddisk]} {
							>
								if {[S search 208 0 {} 261 eq Cannot\ load\ from\ harddisk.]} {
									>
										if {[S search 236 0 {} 235 eq Insert\ Systemdisk\ and\ press\ any\ key.]} {
											>
												if {[S search 180 0 {} 96 eq Disk\ formatted\ with\ WinImage\ ]} {
													>
														emit {\b, WinImage harddisk Bootloader}
														if {[S string [R 0] 0 {} {} x {}]} {
															>
																emit {\b, version %-4.4s}
															<
														}
	
													<
												}
	
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
				if {[N ubyte [I 1 ubyte 0 + 0 2] 0 0 {} {} == 14]} {
					>
						if {[N ubyte [I 1 ubyte 0 + 0 3] 0 0 {} {} == 31]} {
							>
								if {[N ubyte [I 1 ubyte 0 + 0 4] 0 0 {} {} == 190]} {
									>
										if {[N ubyte [I 1 ubyte 0 + 0 5] 0 0 & 211 == 83]} {
											>
												if {[N ubyte [I 1 ubyte 0 + 0 6] 0 0 {} {} == 124]} {
													>
														if {[N ubyte [I 1 ubyte 0 + 0 7] 0 0 {} {} == 172]} {
															>
																if {[N ubyte [I 1 ubyte 0 + 0 8] 0 0 {} {} == 34]} {
																	>
																		if {[N ubyte [I 1 ubyte 0 + 0 9] 0 0 {} {} == 192]} {
																			>
																				if {[N ubyte [I 1 ubyte 0 + 0 10] 0 0 {} {} == 116]} {
																					>
																						if {[N ubyte [I 1 ubyte 0 + 0 11] 0 0 {} {} == 11]} {
																							>
																								if {[N ubyte [I 1 ubyte 0 + 0 12] 0 0 {} {} == 86]} {
																									>
																										if {[N ubyte [I 1 ubyte 0 + 0 13] 0 0 {} {} == 180]} {
																											>
																												emit {\b, mkdosfs boot message display}
																												switch [Nv ubyte [I 1 ubyte 0 + 0 5] 0 {} {}] {
																													91 {
																														>
																															if {[S string 91 0 {} {} > \0]} {
																																>
																																	emit {"%-s"}
																																<
																															}
	
																														<
																													}
																													119 {
																														>
																															if {[S string 119 0 {} {} > \0]} {
																																>
																																	emit {"%-s"}
																																<
																															}
	
																														<
																													}
																												}
	
																											<
																										}
	
																									<
																								}
	
																							<
																						}
	
																					<
																				}
	
																			<
																		}
	
																	<
																}
	
															<
														}
	
													<
												}
	
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
				if {[S string 214 0 {} {} eq Please\ try\ to\ install\ FreeDOS\ ]} {
					>
						emit {\b, DOS Emulator boot message display}
					<
				}
	
				if {[S string 103 0 {} {} eq This\ is\ not\ a\ bootable\ disk.\040]} {
					>
						if {[S string 132 0 {} {} eq Please\ insert\ a\ bootable\040]} {
							>
								if {[S string 157 0 {} {} eq floppy\ and\r\n]} {
									>
										if {[S string 169 0 {} {} eq press\ any\ key\ to\ try\ again...\r]} {
											>
												emit {\b, FREE-DOS message display}
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
				if {[S string 66 0 {} {} eq Solaris\ Boot\ Sector]} {
					>
						if {[S string 99 0 {} {} eq Incomplete\ MDBoot\ load.]} {
							>
								if {[S string 89 0 {} {} eq Version]} {
									>
										emit {\b, Sun Solaris Bootloader}
										if {[N byte 97 0 0 {} {} x {}]} {
											>
												emit {version %c}
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
				if {[S string 408 0 {} {} eq OS/2\ !!\ SYS01475\r\0]} {
					>
						if {[S string 429 0 {} {} eq OS/2\ !!\ SYS02025\r\0]} {
							>
								if {[S string 450 0 {} {} eq OS/2\ !!\ SYS02027\r\0]} {
									>
									<
								}
	
								if {[S string 469 0 {} {} eq OS2BOOT\ \ \ \ ]} {
									>
										emit {\b, IBM OS/2 Warp bootloader}
									<
								}
	
							<
						}
	
					<
				}
	
				if {[S string 409 0 {} {} eq OS/2\ !!\ SYS01475\r\0]} {
					>
						if {[S string 430 0 {} {} eq OS/2\ !!\ SYS02025\r\0]} {
							>
								if {[S string 451 0 {} {} eq OS/2\ !!\ SYS02027\r\0]} {
									>
									<
								}
	
								if {[S string 470 0 {} {} eq OS2BOOT\ \ \ \ ]} {
									>
										emit {\b, IBM OS/2 Warp Bootloader}
									<
								}
	
							<
						}
	
					<
				}
	
				if {[S string 112 0 {} {} eq This\ disk\ is\ not\ bootable\r]} {
					>
						if {[S string 142 0 {} {} eq If\ you\ wish\ to\ make\ it\ bootable]} {
							>
								if {[S string 176 0 {} {} eq run\ the\ DOS\ program\ SYS\040]} {
									>
									<
								}
	
								if {[S string 200 0 {} {} eq after\ the\r]} {
									>
										if {[S string 216 0 {} {} eq system\ has\ been\ loaded\r\n]} {
											>
												if {[S string 242 0 {} {} eq Please\ insert\ a\ DOS\ diskette\040]} {
													>
													<
												}
	
												if {[S string 271 0 {} {} eq into\r\n\ the\ drive\ and\040]} {
													>
														if {[S string 292 0 {} {} eq strike\ any\ key...\0]} {
															>
																emit {\b, IBM OS/2 Warp message display}
															<
														}
	
													<
												}
	
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
				if {[S string 430 0 {} {} eq NTLDR\ is\ missing\xFF\r\n]} {
					>
						if {[S string 449 0 {} {} eq Disk\ error\xFF\r\n]} {
							>
								if {[S string 462 0 {} {} eq Press\ any\ key\ to\ restart\r]} {
									>
										emit {\b, Microsoft Windows XP Bootloader}
										if {[N ubyte 417 0 0 & 223 > 0]} {
											>
												if {[S string 417 0 {} {} x {}]} {
													>
														emit %-.5s
														if {[N ubyte 422 0 0 & 223 > 0]} {
															>
																if {[S string 422 0 {} {} x {}]} {
																	>
																		emit {\b%-.3s}
																	<
																}
	
															<
														}
	
													<
												}
	
												if {[N ubyte 425 0 0 & 223 > 0]} {
													>
														if {[S string 425 0 {} {} > \ ]} {
															>
																emit {\b.%-.3s}
															<
														}
	
													<
												}
	
											<
										}
	
										if {[N ubyte 371 0 0 {} {} > 32]} {
											>
												if {[N ubyte 368 0 0 & 223 > 0]} {
													>
														if {[S string 368 0 {} {} x {}]} {
															>
																emit %-.5s
																if {[N ubyte 373 0 0 & 223 > 0]} {
																	>
																		if {[S string 373 0 {} {} x {}]} {
																			>
																				emit {\b%-.3s}
																			<
																		}
	
																	<
																}
	
															<
														}
	
														if {[N ubyte 376 0 0 & 223 > 0]} {
															>
																if {[S string 376 0 {} {} x {}]} {
																	>
																		emit {\b.%-.3s}
																	<
																}
	
															<
														}
	
													<
												}
	
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
				if {[S string 430 0 {} {} eq NTLDR\ nicht\ gefunden\xFF\r\n]} {
					>
						if {[S string 453 0 {} {} eq Datentr\204gerfehler\xFF\r\n]} {
							>
								if {[S string 473 0 {} {} eq Neustart\ mit\ beliebiger\ Taste\r]} {
									>
										emit {\b, Microsoft Windows XP Bootloader (german)}
										if {[N ubyte 417 0 0 & 223 > 0]} {
											>
												if {[S string 417 0 {} {} x {}]} {
													>
														emit %-.5s
														if {[N ubyte 422 0 0 & 223 > 0]} {
															>
																if {[S string 422 0 {} {} x {}]} {
																	>
																		emit {\b%-.3s}
																	<
																}
	
															<
														}
	
													<
												}
	
												if {[N ubyte 425 0 0 & 223 > 0]} {
													>
														if {[S string 425 0 {} {} > \ ]} {
															>
																emit {\b.%-.3s}
															<
														}
	
													<
												}
	
											<
										}
	
										if {[S string 379 0 {} {} eq \0]} {
											>
												if {[N ubyte 368 0 0 & 223 > 0]} {
													>
														if {[S string 368 0 {} {} x {}]} {
															>
																emit %-.5s
																if {[N ubyte 373 0 0 & 223 > 0]} {
																	>
																		if {[S string 373 0 {} {} x {}]} {
																			>
																				emit {\b%-.3s}
																			<
																		}
	
																	<
																}
	
															<
														}
	
													<
												}
	
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
				if {[S string 430 0 {} {} eq NTLDR\ fehlt\xFF\r\n]} {
					>
						if {[S string 444 0 {} {} eq Datentr\204gerfehler\xFF\r\n]} {
							>
								if {[S string 464 0 {} {} eq Neustart\ mit\ beliebiger\ Taste\r]} {
									>
										emit {\b, Microsoft Windows XP Bootloader (2.german)}
										if {[N ubyte 417 0 0 & 223 > 0]} {
											>
												if {[S string 417 0 {} {} x {}]} {
													>
														emit %-.5s
														if {[N ubyte 422 0 0 & 223 > 0]} {
															>
																if {[S string 422 0 {} {} x {}]} {
																	>
																		emit {\b%-.3s}
																	<
																}
	
															<
														}
	
													<
												}
	
												if {[N ubyte 425 0 0 & 223 > 0]} {
													>
														if {[S string 425 0 {} {} > \ ]} {
															>
																emit {\b.%-.3s}
															<
														}
	
													<
												}
	
											<
										}
	
										if {[N ubyte 371 0 0 {} {} > 32]} {
											>
												if {[N ubyte 368 0 0 & 223 > 0]} {
													>
														if {[S string 368 0 {} {} x {}]} {
															>
																emit %-.5s
																if {[N ubyte 373 0 0 & 223 > 0]} {
																	>
																		if {[S string 373 0 {} {} x {}]} {
																			>
																				emit {\b%-.3s}
																			<
																		}
	
																	<
																}
	
															<
														}
	
														if {[N ubyte 376 0 0 & 223 > 0]} {
															>
																if {[S string 376 0 {} {} x {}]} {
																	>
																		emit {\b.%-.3s}
																	<
																}
	
															<
														}
	
													<
												}
	
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
				if {[S string 430 0 {} {} eq NTLDR\ fehlt\xFF\r\n]} {
					>
						if {[S string 444 0 {} {} eq Medienfehler\xFF\r\n]} {
							>
								if {[S string 459 0 {} {} eq Neustart:\ Taste\ dr\201cken\r]} {
									>
										emit {\b, Microsoft Windows XP Bootloader (3.german)}
										if {[N ubyte 371 0 0 {} {} > 32]} {
											>
												if {[N ubyte 368 0 0 & 223 > 0]} {
													>
														if {[S string 368 0 {} {} x {}]} {
															>
																emit %-.5s
																if {[N ubyte 373 0 0 & 223 > 0]} {
																	>
																		if {[S string 373 0 {} {} x {}]} {
																			>
																				emit {\b%-.3s}
																			<
																		}
	
																	<
																}
	
															<
														}
	
														if {[N ubyte 376 0 0 & 223 > 0]} {
															>
																if {[S string 376 0 {} {} x {}]} {
																	>
																		emit {\b.%-.3s}
																	<
																}
	
															<
														}
	
													<
												}
	
											<
										}
	
										if {[N ubyte 417 0 0 & 223 > 0]} {
											>
												if {[S string 417 0 {} {} x {}]} {
													>
														emit %-.5s
														if {[N ubyte 422 0 0 & 223 > 0]} {
															>
																if {[S string 422 0 {} {} x {}]} {
																	>
																		emit {\b%-.3s}
																	<
																}
	
															<
														}
	
													<
												}
	
												if {[N ubyte 425 0 0 & 223 > 0]} {
													>
														if {[S string 425 0 {} {} > \ ]} {
															>
																emit {\b.%-.3s}
															<
														}
	
													<
												}
	
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
				if {[S string 430 0 {} {} eq Datentr\204ger\ entfernen\xFF\r\n]} {
					>
						if {[S string 454 0 {} {} eq Medienfehler\xFF\r\n]} {
							>
								if {[S string 469 0 {} {} eq Neustart:\ Taste\ dr\201cken\r]} {
									>
										emit {\b, Microsoft Windows XP Bootloader (4.german)}
										if {[S string 379 0 {} {} eq \0]} {
											>
												if {[N ubyte 368 0 0 & 223 > 0]} {
													>
														if {[S string 368 0 {} {} x {}]} {
															>
																emit %-.5s
																if {[N ubyte 373 0 0 & 223 > 0]} {
																	>
																		if {[S string 373 0 {} {} x {}]} {
																			>
																				emit {\b%-.3s}
																			<
																		}
	
																	<
																}
	
															<
														}
	
														if {[N ubyte 376 0 0 & 223 > 0]} {
															>
																if {[S string 376 0 {} {} x {}]} {
																	>
																		emit {\b.%-.3s}
																	<
																}
	
															<
														}
	
													<
												}
	
											<
										}
	
										if {[N ubyte 417 0 0 & 223 > 0]} {
											>
												if {[S string 417 0 {} {} x {}]} {
													>
														emit %-.5s
														if {[N ubyte 422 0 0 & 223 > 0]} {
															>
																if {[S string 422 0 {} {} x {}]} {
																	>
																		emit {\b%-.3s}
																	<
																}
	
															<
														}
	
													<
												}
	
												if {[N ubyte 425 0 0 & 223 > 0]} {
													>
														if {[S string 425 0 {} {} > \ ]} {
															>
																emit {\b.%-.3s}
															<
														}
	
													<
												}
	
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
				if {[S string 389 0 {} {} eq Fehler\ beim\ Lesen\040]} {
					>
						if {[S string 407 0 {} {} eq des\ Datentr\204gers]} {
							>
								if {[S string 426 0 {} {} eq NTLDR\ fehlt]} {
									>
										if {[S string 440 0 {} {} eq NTLDR\ ist\ komprimiert]} {
											>
												if {[S string 464 0 {} {} eq Neustart\ mit\ Strg+Alt+Entf\r]} {
													>
														emit {\b, Microsoft Windows XP Bootloader NTFS (german)}
													<
												}
	
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
				if {[S string 313 0 {} {} eq A\ disk\ read\ error\ occurred.\r]} {
					>
						if {[S string 345 0 {} {} eq A\ kernel\ file\ is\ missing\040]} {
							>
								if {[S string 370 0 {} {} eq from\ the\ disk.\r]} {
									>
										if {[S string 484 0 {} {} eq NTLDR\ is\ compressed]} {
											>
												if {[S string 429 0 {} {} eq Insert\ a\ system\ diskette\040]} {
													>
														if {[S string 454 0 {} {} eq and\ restart\r\nthe\ system.\r]} {
															>
																emit {\b, Microsoft Windows XP Bootloader NTFS}
															<
														}
	
													<
												}
	
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
				if {[N ubyte 472 0 0 & 223 > 0]} {
					>
						if {[S string 389 0 {} {} eq Invalid\ system\ disk\xFF\r\n]} {
							>
								if {[S string 411 0 {} {} eq Disk\ I/O\ error]} {
									>
										if {[S string 428 0 {} {} eq Replace\ the\ disk,\ and\040]} {
											>
												if {[S string 455 0 {} {} eq press\ any\ key]} {
													>
														emit {\b, Microsoft Windows 98 Bootloader}
														if {[N ubyte 472 0 0 & 223 > 0]} {
															>
																if {[S string 472 0 {} {} x {}]} {
																	>
																		emit {\b %-.2s}
																		if {[N ubyte 474 0 0 & 223 > 0]} {
																			>
																				if {[S string 474 0 {} {} x {}]} {
																					>
																						emit {\b%-.5s}
																						if {[N ubyte 479 0 0 & 223 > 0]} {
																							>
																								if {[S string 479 0 {} {} x {}]} {
																									>
																										emit {\b%-.1s}
																									<
																								}
	
																							<
																						}
	
																					<
																				}
	
																			<
																		}
	
																	<
																}
	
																if {[N ubyte 480 0 0 & 223 > 0]} {
																	>
																		if {[S string 480 0 {} {} x {}]} {
																			>
																				emit {\b.%-.3s}
																			<
																		}
	
																	<
																}
	
																if {[N ubyte 483 0 0 & 223 > 0]} {
																	>
																		emit {\b+}
																		if {[S string 483 0 {} {} x {}]} {
																			>
																				emit {\b%-.5s}
																				if {[N ubyte 488 0 0 & 223 > 0]} {
																					>
																						if {[S string 488 0 {} {} x {}]} {
																							>
																								emit {\b%-.3s}
																							<
																						}
	
																					<
																				}
	
																			<
																		}
	
																		if {[N ubyte 491 0 0 & 223 > 0]} {
																			>
																				if {[S string 491 0 {} {} x {}]} {
																					>
																						emit {\b.%-.3s}
																					<
																				}
	
																			<
																		}
	
																	<
																}
	
															<
														}
	
													<
												}
	
											<
										}
	
									<
								}
	
							<
						}
	
						if {[S string 390 0 {} {} eq Invalid\ system\ disk\xFF\r\n]} {
							>
								if {[S string 412 0 {} {} eq Disk\ I/O\ error\xFF\r\n]} {
									>
										if {[S string 429 0 {} {} eq Replace\ the\ disk,\ and\040]} {
											>
												if {[S string 451 0 {} {} eq then\ press\ any\ key\r]} {
													>
														emit {\b, Microsoft Windows 98 Bootloader}
													<
												}
	
											<
										}
	
									<
								}
	
							<
						}
	
						if {[S string 388 0 {} {} eq Ungueltiges\ System\ \xFF\r\n]} {
							>
								if {[S string 410 0 {} {} eq E/A-Fehler\ \ \ \ \xFF\r\n]} {
									>
										if {[S string 427 0 {} {} eq Datentraeger\ wechseln\ und\040]} {
											>
												if {[S string 453 0 {} {} eq Taste\ druecken\r]} {
													>
														emit {\b, Microsoft Windows 95/98/ME Bootloader (german)}
														if {[N ubyte 497 0 0 & 223 > 0]} {
															>
																if {[S string 497 0 {} {} x {}]} {
																	>
																		emit %-.5s
																		if {[N ubyte 502 0 0 & 223 > 0]} {
																			>
																				if {[S string 502 0 {} {} x {}]} {
																					>
																						emit {\b%-.1s}
																						if {[N ubyte 503 0 0 & 223 > 0]} {
																							>
																								if {[S string 503 0 {} {} x {}]} {
																									>
																										emit {\b%-.1s}
																										if {[N ubyte 504 0 0 & 223 > 0]} {
																											>
																												if {[S string 504 0 {} {} x {}]} {
																													>
																														emit {\b%-.1s}
																													<
																												}
	
																											<
																										}
	
																									<
																								}
	
																							<
																						}
	
																					<
																				}
	
																			<
																		}
	
																	<
																}
	
															<
														}
	
														if {[N ubyte 505 0 0 & 223 > 0]} {
															>
																if {[S string 505 0 {} {} x {}]} {
																	>
																		emit {\b.%-.3s}
																	<
																}
	
															<
														}
	
														if {[N ubyte 472 0 0 & 223 > 0]} {
															>
																emit or
																if {[S string 472 0 {} {} x {}]} {
																	>
																		emit {\b %-.2s}
																		if {[N ubyte 474 0 0 & 223 > 0]} {
																			>
																				if {[S string 474 0 {} {} x {}]} {
																					>
																						emit {\b%-.5s}
																						if {[N ubyte 479 0 0 & 223 > 0]} {
																							>
																								if {[S string 479 0 {} {} x {}]} {
																									>
																										emit {\b%-.1s}
																									<
																								}
	
																							<
																						}
	
																					<
																				}
	
																			<
																		}
	
																	<
																}
	
																if {[N ubyte 480 0 0 & 223 > 0]} {
																	>
																		if {[S string 480 0 {} {} x {}]} {
																			>
																				emit {\b.%-.3s}
																			<
																		}
	
																	<
																}
	
																if {[N ubyte 483 0 0 & 223 > 0]} {
																	>
																		emit {\b+}
																		if {[S string 483 0 {} {} x {}]} {
																			>
																				emit {\b%-.5s}
																				if {[N ubyte 488 0 0 & 223 > 0]} {
																					>
																						if {[S string 488 0 {} {} x {}]} {
																							>
																								emit {\b%-.3s}
																							<
																						}
	
																					<
																				}
	
																			<
																		}
	
																		if {[N ubyte 491 0 0 & 223 > 0]} {
																			>
																				if {[S string 491 0 {} {} x {}]} {
																					>
																						emit {\b.%-.3s}
																					<
																				}
	
																			<
																		}
	
																	<
																}
	
															<
														}
	
													<
												}
	
											<
										}
	
									<
								}
	
							<
						}
	
						if {[S string 390 0 {} {} eq Ungueltiges\ System\ \xFF\r\n]} {
							>
								if {[S string 412 0 {} {} eq E/A-Fehler\ \ \ \ \xFF\r\n]} {
									>
										if {[S string 429 0 {} {} eq Datentraeger\ wechseln\ und\040]} {
											>
												if {[S string 455 0 {} {} eq Taste\ druecken\r]} {
													>
														emit {\b, Microsoft Windows 95/98/ME Bootloader (German)}
														if {[N ubyte 497 0 0 & 223 > 0]} {
															>
																if {[S string 497 0 {} {} x {}]} {
																	>
																		emit %-.7s
																		if {[N ubyte 504 0 0 & 223 > 0]} {
																			>
																				if {[S string 504 0 {} {} x {}]} {
																					>
																						emit {\b%-.1s}
																					<
																				}
	
																			<
																		}
	
																	<
																}
	
															<
														}
	
														if {[N ubyte 505 0 0 & 223 > 0]} {
															>
																if {[S string 505 0 {} {} x {}]} {
																	>
																		emit {\b.%-.3s}
																	<
																}
	
															<
														}
	
														if {[N ubyte 472 0 0 & 223 > 0]} {
															>
																emit or
																if {[S string 472 0 {} {} x {}]} {
																	>
																		emit {\b %-.2s}
																		if {[N ubyte 474 0 0 & 223 > 0]} {
																			>
																				if {[S string 474 0 {} {} x {}]} {
																					>
																						emit {\b%-.6s}
																					<
																				}
	
																			<
																		}
	
																	<
																}
	
																if {[N ubyte 480 0 0 & 223 > 0]} {
																	>
																		if {[S string 480 0 {} {} x {}]} {
																			>
																				emit {\b.%-.3s}
																			<
																		}
	
																	<
																}
	
																if {[N ubyte 483 0 0 & 223 > 0]} {
																	>
																		emit {\b+}
																		if {[S string 483 0 {} {} x {}]} {
																			>
																				emit {\b%-.5s}
																				if {[N ubyte 488 0 0 & 223 > 0]} {
																					>
																						if {[S string 488 0 {} {} x {}]} {
																							>
																								emit {\b%-.3s}
																							<
																						}
	
																					<
																				}
	
																			<
																		}
	
																		if {[N ubyte 491 0 0 & 223 > 0]} {
																			>
																				if {[S string 491 0 {} {} x {}]} {
																					>
																						emit {\b.%-.3s}
																					<
																				}
	
																			<
																		}
	
																	<
																}
	
															<
														}
	
													<
												}
	
											<
										}
	
									<
								}
	
							<
						}
	
						if {[S string 389 0 {} {} eq Ungueltiges\ System\ \xFF\r\n]} {
							>
								if {[S string 411 0 {} {} eq E/A-Fehler\ \ \ \ \xFF\r\n]} {
									>
										if {[S string 428 0 {} {} eq Datentraeger\ wechseln\ und\040]} {
											>
												if {[S string 454 0 {} {} eq Taste\ druecken\r]} {
													>
														emit {\b, Microsoft Windows 95/98/ME Bootloader (GERMAN)}
														if {[S string 472 0 {} {} x {}]} {
															>
																emit %-.2s
																if {[N ubyte 474 0 0 & 223 > 0]} {
																	>
																		if {[S string 474 0 {} {} x {}]} {
																			>
																				emit {\b%-.5s}
																			<
																		}
	
																		if {[N ubyte 479 0 0 & 223 > 0]} {
																			>
																				if {[S string 479 0 {} {} x {}]} {
																					>
																						emit {\b%-.1s}
																					<
																				}
	
																			<
																		}
	
																	<
																}
	
															<
														}
	
														if {[N ubyte 480 0 0 & 223 > 0]} {
															>
																if {[S string 480 0 {} {} x {}]} {
																	>
																		emit {\b.%-.3s}
																	<
																}
	
															<
														}
	
														if {[N ubyte 483 0 0 & 223 > 0]} {
															>
																emit {\b+}
																if {[S string 483 0 {} {} x {}]} {
																	>
																		emit {\b%-.5s}
																	<
																}
	
																if {[N ubyte 488 0 0 & 223 > 0]} {
																	>
																		if {[S string 488 0 {} {} x {}]} {
																			>
																				emit {\b%-.2s}
																			<
																		}
	
																		if {[N ubyte 490 0 0 & 223 > 0]} {
																			>
																				if {[S string 490 0 {} {} x {}]} {
																					>
																						emit {\b%-.1s}
																					<
																				}
	
																			<
																		}
	
																	<
																}
	
																if {[N ubyte 491 0 0 & 223 > 0]} {
																	>
																		if {[S string 491 0 {} {} x {}]} {
																			>
																				emit {\b.%-.3s}
																			<
																		}
	
																	<
																}
	
															<
														}
	
													<
												}
	
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
				if {[N ubyte 479 0 0 & 223 > 0]} {
					>
						if {[S string 416 0 {} {} eq Kein\ System\ oder\040]} {
							>
								if {[S string 433 0 {} {} eq Laufwerksfehler]} {
									>
										if {[S string 450 0 {} {} eq Wechseln\ und\ Taste\ dr\201cken]} {
											>
												emit {\b, Microsoft DOS Bootloader (german)}
												if {[S string 479 0 {} {} x {}]} {
													>
														emit {\b %-.2s}
														if {[N ubyte 481 0 0 & 223 > 0]} {
															>
																if {[S string 481 0 {} {} x {}]} {
																	>
																		emit {\b%-.6s}
																	<
																}
	
															<
														}
	
													<
												}
	
												if {[N ubyte 487 0 0 & 223 > 0]} {
													>
														if {[S string 487 0 {} {} x {}]} {
															>
																emit {\b.%-.3s}
															<
														}
	
														if {[N ubyte 490 0 0 & 223 > 0]} {
															>
																emit {\b+}
																if {[S string 490 0 {} {} x {}]} {
																	>
																		emit {\b%-.5s}
																		if {[N ubyte 495 0 0 & 223 > 0]} {
																			>
																				if {[S string 495 0 {} {} x {}]} {
																					>
																						emit {\b%-.3s}
																					<
																				}
	
																			<
																		}
	
																	<
																}
	
																if {[N ubyte 498 0 0 & 223 > 0]} {
																	>
																		if {[S string 498 0 {} {} x {}]} {
																			>
																				emit {\b.%-.3s}
																			<
																		}
	
																	<
																}
	
															<
														}
	
													<
												}
	
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
				if {[S search 376 0 {} 41 eq Non-System\ disk\ or\040]} {
					>
						if {[S search 395 0 {} 41 eq disk\ error\r]} {
							>
								if {[S search 407 0 {} 41 eq Replace\ and\040]} {
									>
										if {[S search 419 0 {} 41 eq press\ ]} {
											>
												emit {\b,}
											<
										}
	
										if {[S search 419 0 {} 41 eq strike\ ]} {
											>
												emit {\b, old}
											<
										}
	
										if {[S search 426 0 {} 41 eq any\ key\ when\ ready\r]} {
											>
												emit {MS or PC-DOS bootloader}
												if {[S search 468 0 {} 18 eq \0]} {
													>
														if {[S string [R 0] 0 {} {} x {}]} {
															>
																emit {\b %-.2s}
																if {[N ubyte [R -20] 0 0 & 223 > 0]} {
																	>
																		if {[S string [R -1] 0 {} {} x {}]} {
																			>
																				emit {\b%-.4s}
																				if {[N ubyte [R -16] 0 0 & 223 > 0]} {
																					>
																						if {[S string [R -1] 0 {} {} x {}]} {
																							>
																								emit {\b%-.2s}
																							<
																						}
	
																					<
																				}
	
																			<
																		}
	
																	<
																}
	
															<
														}
	
														if {[N ubyte [R 8] 0 0 & 223 > 0]} {
															>
																emit {\b.}
																if {[S string [R -1] 0 {} {} x {}]} {
																	>
																		emit {\b%-.3s}
																	<
																}
	
															<
														}
	
														if {[N ubyte [R 11] 0 0 & 223 > 0]} {
															>
																emit {\b+}
																if {[S string [R -1] 0 {} {} x {}]} {
																	>
																		emit {\b%-.5s}
																		if {[N ubyte [R -6] 0 0 & 223 > 0]} {
																			>
																				if {[S string [R -1] 0 {} {} x {}]} {
																					>
																						emit {\b%-.1s}
																						if {[N ubyte [R -5] 0 0 & 223 > 0]} {
																							>
																								if {[S string [R -1] 0 {} {} x {}]} {
																									>
																										emit {\b%-.2s}
																									<
																								}
	
																							<
																						}
	
																					<
																				}
	
																			<
																		}
	
																	<
																}
	
																if {[N ubyte [R 7] 0 0 & 223 > 0]} {
																	>
																		emit {\b.}
																		if {[S string [R -1] 0 {} {} x {}]} {
																			>
																				emit {\b%-.3s}
																			<
																		}
	
																	<
																}
	
															<
														}
	
													<
												}
	
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
				if {[S string 441 0 {} {} eq Cannot\ load\ from\ harddisk.\n\r]} {
					>
						if {[S string 469 0 {} {} eq Insert\ Systemdisk\040]} {
							>
								if {[S string 487 0 {} {} eq and\ press\ any\ key.\n\r]} {
									>
										emit {\b, MS (2.11) DOS bootloader}
									<
								}
	
							<
						}
	
					<
				}
	
				if {[S string 54 0 {} {} eq SYS]} {
					>
						if {[S string 324 0 {} {} eq VASKK]} {
							>
								if {[S string 495 0 {} {} eq NEWLDR\0]} {
									>
										emit {\b, DR-DOS Bootloader (LOADER.SYS)}
									<
								}
	
							<
						}
	
					<
				}
	
				if {[S string 98 0 {} {} eq Press\ a\ key\ to\ retry\0\r]} {
					>
						if {[S string 120 0 {} {} eq Cannot\ find\ file\ \0\r]} {
							>
								if {[S string 139 0 {} {} eq Disk\ read\ error\0\r]} {
									>
										if {[S string 156 0 {} {} eq Loading\ ...\0]} {
											>
												emit {\b, DR-DOS (3.41) Bootloader}
												if {[N ubyte 44 0 0 & 223 > 0]} {
													>
														if {[S string 44 0 {} {} x {}]} {
															>
																emit {\b %-.6s}
																if {[N ubyte 50 0 0 & 223 > 0]} {
																	>
																		if {[S string 50 0 {} {} x {}]} {
																			>
																				emit {\b%-.2s}
																			<
																		}
	
																	<
																}
	
															<
														}
	
														if {[N ubyte 52 0 0 & 223 > 0]} {
															>
																if {[S string 52 0 {} {} x {}]} {
																	>
																		emit {\b.%-.3s}
																	<
																}
	
															<
														}
	
													<
												}
	
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
				if {[S string 70 0 {} {} eq IBMBIO\ \ COM]} {
					>
						if {[S string 472 0 {} {} eq Cannot\ load\ DOS!\040]} {
							>
								if {[S string 489 0 {} {} eq Any\ key\ to\ retry]} {
									>
										emit {\b, DR-DOS Bootloader}
									<
								}
	
							<
						}
	
						if {[S string 471 0 {} {} eq Cannot\ load\ DOS\040]} {
							>
							<
						}
	
						if {[S string 487 0 {} {} eq press\ key\ to\ retry]} {
							>
								emit {\b, Open-DOS Bootloader}
							<
						}
	
					<
				}
	
				if {[S string 444 0 {} {} eq KERNEL\ \ SYS]} {
					>
						if {[S string 314 0 {} {} eq BOOT\ error!]} {
							>
								emit {\b, FREE-DOS Bootloader}
							<
						}
	
					<
				}
	
				if {[S string 499 0 {} {} eq KERNEL\ \ SYS]} {
					>
						if {[S string 305 0 {} {} eq BOOT\ err!\0]} {
							>
								emit {\b, Free-DOS Bootloader}
							<
						}
	
					<
				}
	
				if {[S string 449 0 {} {} eq KERNEL\ \ SYS]} {
					>
						if {[S string 319 0 {} {} eq BOOT\ error!]} {
							>
								emit {\b, FREE-DOS 0.5 Bootloader}
							<
						}
	
					<
				}
	
				if {[S string 449 0 {} {} eq Loading\ FreeDOS]} {
					>
						if {[N ulelong 431 0 0 {} {} > 0]} {
							>
								emit {\b, FREE-DOS 0.95,1.0 Bootloader}
								if {[N ubyte 497 0 0 & 223 > 0]} {
									>
										if {[S string 497 0 {} {} x {}]} {
											>
												emit {\b %-.6s}
												if {[N ubyte 503 0 0 & 223 > 0]} {
													>
														if {[S string 503 0 {} {} x {}]} {
															>
																emit {\b%-.1s}
																if {[N ubyte 504 0 0 & 223 > 0]} {
																	>
																		if {[S string 504 0 {} {} x {}]} {
																			>
																				emit {\b%-.1s}
																			<
																		}
	
																	<
																}
	
															<
														}
	
													<
												}
	
											<
										}
	
										if {[N ubyte 505 0 0 & 223 > 0]} {
											>
												if {[S string 505 0 {} {} x {}]} {
													>
														emit {\b.%-.3s}
													<
												}
	
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
				if {[S string 331 0 {} {} eq Error!.0]} {
					>
						emit {\b, FREE-DOS 1.0 bootloader}
					<
				}
	
				if {[S string 125 0 {} {} eq Loading\ FreeDOS...\r]} {
					>
						if {[S string 311 0 {} {} eq BOOT\ error!\r]} {
							>
								emit {\b, FREE-DOS bootloader}
								if {[N ubyte 441 0 0 & 223 > 0]} {
									>
										if {[S string 441 0 {} {} x {}]} {
											>
												emit {\b %-.6s}
												if {[N ubyte 447 0 0 & 223 > 0]} {
													>
														if {[S string 447 0 {} {} x {}]} {
															>
																emit {\b%-.1s}
																if {[N ubyte 448 0 0 & 223 > 0]} {
																	>
																		if {[S string 448 0 {} {} x {}]} {
																			>
																				emit {\b%-.1s}
																			<
																		}
	
																	<
																}
	
															<
														}
	
													<
												}
	
											<
										}
	
										if {[N ubyte 449 0 0 & 223 > 0]} {
											>
												if {[S string 449 0 {} {} x {}]} {
													>
														emit {\b.%-.3s}
													<
												}
	
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
				if {[S string 124 0 {} {} eq FreeDOS\0]} {
					>
						if {[S string 331 0 {} {} eq \ err\0]} {
							>
								emit {\b, FREE-DOS BETa 0.9 Bootloader}
								if {[N ubyte 497 0 0 & 223 > 0]} {
									>
										if {[S string 497 0 {} {} x {}]} {
											>
												emit {\b %-.6s}
												if {[N ubyte 503 0 0 & 223 > 0]} {
													>
														if {[S string 503 0 {} {} x {}]} {
															>
																emit {\b%-.1s}
																if {[N ubyte 504 0 0 & 223 > 0]} {
																	>
																		if {[S string 504 0 {} {} x {}]} {
																			>
																				emit {\b%-.1s}
																			<
																		}
	
																	<
																}
	
															<
														}
	
													<
												}
	
											<
										}
	
										if {[N ubyte 505 0 0 & 223 > 0]} {
											>
												if {[S string 505 0 {} {} x {}]} {
													>
														emit {\b.%-.3s}
													<
												}
	
											<
										}
	
									<
								}
	
							<
						}
	
						if {[S string 333 0 {} {} eq \ err\0]} {
							>
								emit {\b, FREE-DOS BEta 0.9 Bootloader}
								if {[N ubyte 497 0 0 & 223 > 0]} {
									>
										if {[S string 497 0 {} {} x {}]} {
											>
												emit {\b %-.6s}
												if {[N ubyte 503 0 0 & 223 > 0]} {
													>
														if {[S string 503 0 {} {} x {}]} {
															>
																emit {\b%-.1s}
																if {[N ubyte 504 0 0 & 223 > 0]} {
																	>
																		if {[S string 504 0 {} {} x {}]} {
																			>
																				emit {\b%-.1s}
																			<
																		}
	
																	<
																}
	
															<
														}
	
													<
												}
	
											<
										}
	
										if {[N ubyte 505 0 0 & 223 > 0]} {
											>
												if {[S string 505 0 {} {} x {}]} {
													>
														emit {\b.%-.3s}
													<
												}
	
											<
										}
	
									<
								}
	
							<
						}
	
						if {[S string 334 0 {} {} eq \ err\0]} {
							>
								emit {\b, FREE-DOS Beta 0.9 Bootloader}
								if {[N ubyte 497 0 0 & 223 > 0]} {
									>
										if {[S string 497 0 {} {} x {}]} {
											>
												emit {\b %-.6s}
												if {[N ubyte 503 0 0 & 223 > 0]} {
													>
														if {[S string 503 0 {} {} x {}]} {
															>
																emit {\b%-.1s}
																if {[N ubyte 504 0 0 & 223 > 0]} {
																	>
																		if {[S string 504 0 {} {} x {}]} {
																			>
																				emit {\b%-.1s}
																			<
																		}
	
																	<
																}
	
															<
														}
	
													<
												}
	
											<
										}
	
										if {[N ubyte 505 0 0 & 223 > 0]} {
											>
												if {[S string 505 0 {} {} x {}]} {
													>
														emit {\b.%-.3s}
													<
												}
	
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
				if {[S string 336 0 {} {} eq Error!\040]} {
					>
						if {[S string 343 0 {} {} eq Hit\ a\ key\ to\ reboot.]} {
							>
								emit {\b, FREE-DOS Beta 0.9sr1 Bootloader}
								if {[N ubyte 497 0 0 & 223 > 0]} {
									>
										if {[S string 497 0 {} {} x {}]} {
											>
												emit {\b %-.6s}
												if {[N ubyte 503 0 0 & 223 > 0]} {
													>
														if {[S string 503 0 {} {} x {}]} {
															>
																emit {\b%-.1s}
																if {[N ubyte 504 0 0 & 223 > 0]} {
																	>
																		if {[S string 504 0 {} {} x {}]} {
																			>
																				emit {\b%-.1s}
																			<
																		}
	
																	<
																}
	
															<
														}
	
													<
												}
	
											<
										}
	
										if {[N ubyte 505 0 0 & 223 > 0]} {
											>
												if {[S string 505 0 {} {} x {}]} {
													>
														emit {\b.%-.3s}
													<
												}
	
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
				if {[N ulelong 478 0 0 {} {} == 0]} {
					>
						if {[S string [I 1 ubyte 0 + 0 326] 0 {} {} eq I/O\ Error\ reading\040]} {
							>
								if {[S string [I 1 ubyte 0 + 0 344] 0 {} {} eq Visopsys\ loader\r]} {
									>
										if {[S string [I 1 ubyte 0 + 0 361] 0 {} {} eq Press\ any\ key\ to\ continue.\r]} {
											>
												emit {\b, Visopsys loader}
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
				if {[N ubyte 494 0 0 {} {} > 77]} {
					>
						if {[S string 495 0 {} {} > E]} {
							>
								if {[S string 495 0 {} {} < S]} {
									>
										if {[S string 3 0 {} {} eq BootProg]} {
											>
											<
										}
	
										if {[N ubyte 499 0 0 & 223 > 0]} {
											>
												emit {\b, COM/EXE Bootloader}
												U 79 DOS-filename 499
	
												if {[S string 492 0 {} {} eq RENF]} {
													>
														emit {\b, FAT (12 bit)}
													<
												}
	
												if {[S string 495 0 {} {} eq RENF]} {
													>
														emit {\b, FAT (16 bit)}
													<
												}
	
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
				if {[S string 0 0 {} {} eq RRaA]} {
					>
						if {[S string 484 0 {} {} eq rrAa]} {
							>
								emit {\b, FSInfosector}
								if {[N ulelong 488 0 0 {} {} < 4294967295]} {
									>
										emit {\b, %u free clusters}
									<
								}
	
								if {[N ulelong 492 0 0 {} {} < 4294967295]} {
									>
										emit {\b, last allocated cluster %u}
									<
								}
	
							<
						}
	
					<
				}
	
				if {[N ubyte 3 0 0 {} {} == 0]} {
					>
						if {[N ubyte 446 0 0 {} {} == 0]} {
							>
								if {[N ubyte 450 0 0 {} {} > 0]} {
									>
										if {[N ubyte 482 0 0 {} {} == 0]} {
											>
												if {[N ubyte 498 0 0 {} {} == 0]} {
													>
														if {[N ubyte 466 0 0 {} {} < 16]} {
															>
																switch [Nv ubyte 466 0 {} {}] {
																	0 {
																		>
																			emit {\b, extended partition table (last)}
																		<
																	}
																	5 {
																		>
																			emit {\b, extended partition table}
																		<
																	}
																	15 {
																		>
																			emit {\b, extended partition table (LBA)}
																		<
																	}
																}
	
															<
														}
	
													<
												}
	
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
				if {[N lelong 512 0 0 {} {} == -2108275369]} {
					>
						emit {\b, BSD disklabel}
					<
				}
	
			<
			>
				if {[S string 3 0 {} {} ne MS]} {
					>
						if {[S string 3 0 {} {} ne SYSLINUX]} {
							>
								if {[S string 3 0 {} {} ne MTOOL]} {
									>
										if {[S string 3 0 {} {} ne NEWLDR]} {
											>
												if {[S string 5 0 {} {} ne DOS]} {
													>
														if {[S string 82 0 {} {} ne FAT32]} {
															>
																if {[S string 514 0 {} {} ne HdrS]} {
																	>
																		if {[S string 422 0 {} {} ne Be\ Boot\ Loader]} {
																			>
																				if {[N ubyte 450 0 0 {} {} == 238]} {
																					>
																						if {[N ubyte 466 0 0 {} {} != 238]} {
																							>
																								if {[N ubyte 482 0 0 {} {} != 238]} {
																									>
																										if {[N ubyte 498 0 0 {} {} != 238]} {
																											>
																												if {[S string [I 454 ulelong 0 * 0 8192] 0 {} {} eq EFI\ PART]} {
																													>
																														emit {GPT partition table}
																														U 98 gpt-mbr-type 0
	
																														U 98 gpt-table [R -8]
	
																														if {[N ubyte 0 0 0 {} {} x {}]} {
																															>
																																emit {of 8192 bytes}
																															<
																														}
	
																													<
																												}
	
																												if {[S string [I 454 ulelong 0 * 0 8192] 0 {} {} ne EFI\ PART]} {
																													>
																														if {[S string [I 454 ulelong 0 * 0 4096] 0 {} {} eq EFI\ PART]} {
																															>
																																emit {GPT partition table}
																																U 98 gpt-mbr-type 0
	
																																U 98 gpt-table [R -8]
	
																																if {[N ubyte 0 0 0 {} {} x {}]} {
																																	>
																																		emit {of 4096 bytes}
																																	<
																																}
	
																															<
																														}
	
																														if {[S string [I 454 ulelong 0 * 0 4096] 0 {} {} ne EFI\ PART]} {
																															>
																																if {[S string [I 454 ulelong 0 * 0 2048] 0 {} {} eq EFI\ PART]} {
																																	>
																																		emit {GPT partition table}
																																		U 98 gpt-mbr-type 0
	
																																		U 98 gpt-table [R -8]
	
																																		if {[N ubyte 0 0 0 {} {} x {}]} {
																																			>
																																				emit {of 2048 bytes}
																																			<
																																		}
	
																																	<
																																}
	
																																if {[S string [I 454 ulelong 0 * 0 2048] 0 {} {} ne EFI\ PART]} {
																																	>
																																		if {[S string [I 454 ulelong 0 * 0 1024] 0 {} {} eq EFI\ PART]} {
																																			>
																																				emit {GPT partition table}
																																				U 98 gpt-mbr-type 0
	
																																				U 98 gpt-table [R -8]
	
																																				if {[N ubyte 0 0 0 {} {} x {}]} {
																																					>
																																						emit {of 1024 bytes}
																																					<
																																				}
	
																																			<
																																		}
	
																																		if {[S string [I 454 ulelong 0 * 0 1024] 0 {} {} ne EFI\ PART]} {
																																			>
																																				if {[S string [I 454 ulelong 0 * 0 512] 0 {} {} eq EFI\ PART]} {
																																					>
																																						emit {GPT partition table}
																																						U 98 gpt-mbr-type 0
	
																																						U 98 gpt-table [R -8]
	
																																						if {[N ubyte 0 0 0 {} {} x {}]} {
																																							>
																																								emit {of 512 bytes}
																																							<
																																						}
	
																																					<
																																				}
	
																																			<
																																		}
	
																																	<
																																}
	
																															<
																														}
	
																													<
																												}
	
																											<
																										}
	
																									<
																								}
	
																							<
																						}
	
																					<
																				}
	
																				if {[N ubyte 450 0 0 {} {} != 238]} {
																					>
																						if {[N ubyte 466 0 0 {} {} == 238]} {
																							>
																								if {[N ubyte 482 0 0 {} {} != 238]} {
																									>
																										if {[N ubyte 498 0 0 {} {} != 238]} {
																											>
																												if {[S string [I 470 ulelong 0 * 0 8192] 0 {} {} eq EFI\ PART]} {
																													>
																														emit {GPT partition table}
																														U 98 gpt-mbr-type 0
	
																														U 98 gpt-table [R -8]
	
																														if {[N ubyte 0 0 0 {} {} x {}]} {
																															>
																																emit {of 8192 bytes}
																															<
																														}
	
																													<
																												}
	
																												if {[S string [I 470 ulelong 0 * 0 8192] 0 {} {} ne EFI\ PART]} {
																													>
																														if {[S string [I 470 ulelong 0 * 0 4096] 0 {} {} eq EFI\ PART]} {
																															>
																																emit {GPT partition table}
																																U 98 gpt-mbr-type 0
	
																																U 98 gpt-table [R -8]
	
																																if {[N ubyte 0 0 0 {} {} x {}]} {
																																	>
																																		emit {of 4096 bytes}
																																	<
																																}
	
																															<
																														}
	
																														if {[S string [I 470 ulelong 0 * 0 4096] 0 {} {} ne EFI\ PART]} {
																															>
																																if {[S string [I 470 ulelong 0 * 0 2048] 0 {} {} eq EFI\ PART]} {
																																	>
																																		emit {GPT partition table}
																																		U 98 gpt-mbr-type 0
	
																																		U 98 gpt-table [R -8]
	
																																		if {[N ubyte 0 0 0 {} {} x {}]} {
																																			>
																																				emit {of 2048 bytes}
																																			<
																																		}
	
																																	<
																																}
	
																																if {[S string [I 470 ulelong 0 * 0 2048] 0 {} {} ne EFI\ PART]} {
																																	>
																																		if {[S string [I 470 ulelong 0 * 0 1024] 0 {} {} eq EFI\ PART]} {
																																			>
																																				emit {GPT partition table}
																																				U 98 gpt-mbr-type 0
	
																																				U 98 gpt-table [R -8]
	
																																				if {[N ubyte 0 0 0 {} {} x {}]} {
																																					>
																																						emit {of 1024 bytes}
																																					<
																																				}
	
																																			<
																																		}
	
																																		if {[S string [I 470 ulelong 0 * 0 1024] 0 {} {} ne EFI\ PART]} {
																																			>
																																				if {[S string [I 470 ulelong 0 * 0 512] 0 {} {} eq EFI\ PART]} {
																																					>
																																						emit {GPT partition table}
																																						U 98 gpt-mbr-type 0
	
																																						U 98 gpt-table [R -8]
	
																																						if {[N ubyte 0 0 0 {} {} x {}]} {
																																							>
																																								emit {of 512 bytes}
																																							<
																																						}
	
																																					<
																																				}
	
																																			<
																																		}
	
																																	<
																																}
	
																															<
																														}
	
																													<
																												}
	
																											<
																										}
	
																									<
																								}
	
																							<
																						}
	
																					<
																				}
	
																				if {[N ubyte 450 0 0 {} {} != 238]} {
																					>
																						if {[N ubyte 466 0 0 {} {} != 238]} {
																							>
																								if {[N ubyte 482 0 0 {} {} == 238]} {
																									>
																										if {[N ubyte 498 0 0 {} {} != 238]} {
																											>
																												if {[S string [I 486 ulelong 0 * 0 8192] 0 {} {} eq EFI\ PART]} {
																													>
																														emit {GPT partition table}
																														U 98 gpt-mbr-type 0
	
																														U 98 gpt-table [R -8]
	
																														if {[N ubyte 0 0 0 {} {} x {}]} {
																															>
																																emit {of 8192 bytes}
																															<
																														}
	
																													<
																												}
	
																												if {[S string [I 486 ulelong 0 * 0 8192] 0 {} {} ne EFI\ PART]} {
																													>
																														if {[S string [I 486 ulelong 0 * 0 4096] 0 {} {} eq EFI\ PART]} {
																															>
																																emit {GPT partition table}
																																U 98 gpt-mbr-type 0
	
																																U 98 gpt-table [R -8]
	
																																if {[N ubyte 0 0 0 {} {} x {}]} {
																																	>
																																		emit {of 4096 bytes}
																																	<
																																}
	
																															<
																														}
	
																														if {[S string [I 486 ulelong 0 * 0 4096] 0 {} {} ne EFI\ PART]} {
																															>
																																if {[S string [I 486 ulelong 0 * 0 2048] 0 {} {} eq EFI\ PART]} {
																																	>
																																		emit {GPT partition table}
																																		U 98 gpt-mbr-type 0
	
																																		U 98 gpt-table [R -8]
	
																																		if {[N ubyte 0 0 0 {} {} x {}]} {
																																			>
																																				emit {of 2048 bytes}
																																			<
																																		}
	
																																	<
																																}
	
																																if {[S string [I 486 ulelong 0 * 0 2048] 0 {} {} ne EFI\ PART]} {
																																	>
																																		if {[S string [I 486 ulelong 0 * 0 1024] 0 {} {} eq EFI\ PART]} {
																																			>
																																				emit {GPT partition table}
																																				U 98 gpt-mbr-type 0
	
																																				U 98 gpt-table [R -8]
	
																																				if {[N ubyte 0 0 0 {} {} x {}]} {
																																					>
																																						emit {of 1024 bytes}
																																					<
																																				}
	
																																			<
																																		}
	
																																		if {[S string [I 486 ulelong 0 * 0 1024] 0 {} {} ne EFI\ PART]} {
																																			>
																																				if {[S string [I 486 ulelong 0 * 0 512] 0 {} {} eq EFI\ PART]} {
																																					>
																																						emit {GPT partition table}
																																						U 98 gpt-mbr-type 0
	
																																						U 98 gpt-table [R -8]
	
																																						if {[N ubyte 0 0 0 {} {} x {}]} {
																																							>
																																								emit {of 512 bytes}
																																							<
																																						}
	
																																					<
																																				}
	
																																			<
																																		}
	
																																	<
																																}
	
																															<
																														}
	
																													<
																												}
	
																											<
																										}
	
																									<
																								}
	
																							<
																						}
	
																					<
																				}
	
																				if {[N ubyte 450 0 0 {} {} != 238]} {
																					>
																						if {[N ubyte 466 0 0 {} {} != 238]} {
																							>
																								if {[N ubyte 482 0 0 {} {} != 238]} {
																									>
																										if {[N ubyte 498 0 0 {} {} == 238]} {
																											>
																												if {[S string [I 502 ulelong 0 * 0 8192] 0 {} {} eq EFI\ PART]} {
																													>
																														emit {GPT partition table}
																														U 98 gpt-mbr-type 0
	
																														U 98 gpt-table [R -8]
	
																														if {[N ubyte 0 0 0 {} {} x {}]} {
																															>
																																emit {of 8192 bytes}
																															<
																														}
	
																													<
																												}
	
																												if {[S string [I 502 ulelong 0 * 0 8192] 0 {} {} ne EFI\ PART]} {
																													>
																														if {[S string [I 502 ulelong 0 * 0 4096] 0 {} {} eq EFI\ PART]} {
																															>
																																emit {GPT partition table}
																																U 98 gpt-mbr-type 0
	
																																U 98 gpt-table [R -8]
	
																																if {[N ubyte 0 0 0 {} {} x {}]} {
																																	>
																																		emit {of 4096 bytes}
																																	<
																																}
	
																															<
																														}
	
																														if {[S string [I 502 ulelong 0 * 0 4096] 0 {} {} ne EFI\ PART]} {
																															>
																																if {[S string [I 502 ulelong 0 * 0 2048] 0 {} {} eq EFI\ PART]} {
																																	>
																																		emit {GPT partition table}
																																		U 98 gpt-mbr-type 0
	
																																		U 98 gpt-table [R -8]
	
																																		if {[N ubyte 0 0 0 {} {} x {}]} {
																																			>
																																				emit {of 2048 bytes}
																																			<
																																		}
	
																																	<
																																}
	
																																if {[S string [I 502 ulelong 0 * 0 2048] 0 {} {} ne EFI\ PART]} {
																																	>
																																		if {[S string [I 502 ulelong 0 * 0 1024] 0 {} {} eq EFI\ PART]} {
																																			>
																																				emit {GPT partition table}
																																				U 98 gpt-mbr-type 0
	
																																				U 98 gpt-table [R -8]
	
																																				if {[N ubyte 0 0 0 {} {} x {}]} {
																																					>
																																						emit {of 1024 bytes}
																																					<
																																				}
	
																																			<
																																		}
	
																																		if {[S string [I 502 ulelong 0 * 0 1024] 0 {} {} ne EFI\ PART]} {
																																			>
																																				if {[S string [I 502 ulelong 0 * 0 512] 0 {} {} eq EFI\ PART]} {
																																					>
																																						emit {GPT partition table}
																																						U 98 gpt-mbr-type 0
	
																																						U 98 gpt-table [R -8]
	
																																						if {[N ubyte 0 0 0 {} {} x {}]} {
																																							>
																																								emit {of 512 bytes}
																																							<
																																						}
	
																																					<
																																				}
	
																																			<
																																		}
	
																																	<
																																}
	
																															<
																														}
	
																													<
																												}
	
																											<
																										}
	
																									<
																								}
	
																							<
																						}
	
																					<
																				}
	
																			<
																		}
	
																	<
																}
	
															<
														}
	
													<
												}
	
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
			<
		}
	}
	
	if {[S string 0 0 {} {} eq FATX]} {
		>
			emit {FATX filesystem data}
		<
	}
	
	if {[S string 0 0 {} {} eq -rom1fs-]} {
		>
			emit {romfs filesystem, version 1}
			if {[N belong 8 0 0 {} {} x {}]} {
				>
					emit {%d bytes,}
				<
			}
	
			if {[S string 16 0 {} {} x {}]} {
				>
					emit {named %s.}
				<
			}
	
		<
	}
	
	if {[S string 395 0 {} {} eq OS/2]} {
		>
			emit {OS/2 Boot Manager}
		<
	}
	
	if {[N ulequad 0 0 0 & 10416825940200975098 == 10416825940192586490]} {
		>
			if {[S search 631 0 {} 689 eq ISOLINUX\ ]} {
				>
					emit {isolinux Loader}
					if {[S string [R 0] 0 {} {} x {}]} {
						>
							emit {(version %-4.4s)}
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq LDLINUX\ SYS\ ]} {
		>
			emit {SYSLINUX loader}
			if {[S string 12 0 {} {} x {}]} {
				>
					emit {(older version %-4.4s)}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \r\nSYSLINUX\ ]} {
		>
			emit {SYSLINUX loader}
			if {[S string 11 0 {} {} x {}]} {
				>
					emit {(version %-4.4s)}
				<
			}
	
		<
	}
	
	if {[N ulelong 0 0 0 & 2156960747 == 9443563]} {
		>
			if {[S search 434 0 {} 47 eq Boot\ failed]} {
				>
					if {[S search 482 0 {} 132 eq \0LDLINUX\ SYS]} {
						>
							emit {Syslinux bootloader (version 2.13 or older)}
						<
					}
	
					if {[N ubyte 1 0 0 {} {} == 88]} {
						>
							emit {Syslinux bootloader (version 3.0-3.9)}
						<
					}
	
				<
			}
	
			if {[S search 459 0 {} 30 eq Boot\ error\r\n\0]} {
				>
					if {[N ubyte 1 0 0 {} {} == 88]} {
						>
							emit {Syslinux bootloader (version 3.10 or newer)}
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S search 16 0 {} 4 eq \xbf\x00\x06\xb9\x00\x01]} {
		>
			if {[S search 94 0 {} 249 eq Missing\ operating\ system]} {
				>
					if {[S search 408 0 {} 4 eq HD1/\0]} {
						>
						<
					}
	
					if {[D 408]} {
						>
							if {[S search 250 0 {} 118 eq \0Operating\ system\ load]} {
								>
									emit {SYSLINUX MBR}
									if {[S search 292 0 {} 98 eq error]} {
										>
											if {[S string [R 0] 0 {} {} eq \r]} {
												>
													emit {(version 3.35 or older)}
												<
											}
	
											if {[S string [R 0] 0 {} {} eq .\r]} {
												>
													emit {(version 3.52 or newer)}
												<
											}
	
											if {[D [R 0]]} {
												>
													emit {(version 3.36-3.51 )}
												<
											}
	
										<
									}
	
								<
							}
	
						<
					}
	
				<
			}
	
			if {[S search 368 0 {} 106 eq \0Disk\ error\ on\ boot\r\n]} {
				>
					emit {SYSLINUX GPT-MBR}
					if {[S search 156 0 {} 10 eq \0Boot\ partition\ not\ found\r\n]} {
						>
							if {[S search 270 0 {} 10 eq \0OS\ not\ bootable\r\n]} {
								>
									emit {(version 3.86 or older)}
								<
							}
	
						<
					}
	
					if {[S search 174 0 {} 10 eq \0Missing\ OS\r\n]} {
						>
							if {[S search 189 0 {} 10 eq \0Multiple\ active\ partitions\r\n]} {
								>
									emit {(version 4.00 or newer)}
								<
							}
	
						<
					}
	
				<
			}
	
			strength +36
		<
	}
	
	if {[N ubequad 0 0 0 {} {} == 3585022330545405070]} {
		>
			if {[N uleshort 4 0 0 {} {} x {}]} {
				>
					if {[S search 181 0 {} 166 eq Error\ \0\r\n]} {
						>
							emit {NetBSD mbr}
							if {[N ubelong 440 0 0 {} {} > 0]} {
								>
									emit {\b,Serial 0x%-.8x}
								<
							}
	
							if {[S search 187 0 {} 71 eq \xcd\x13\x5a\x52\x52]} {
								>
									emit {\b,bootselector}
								<
							}
	
							if {[S search 150 0 {} 1 eq \x66\x87\xca\x66\x01\xca\x66\x89\x16\x3a\x07\xbe\x32\x07\xb4\x42\x5a\x52\xcd\x13]} {
								>
									emit {\b,boot extended}
								<
							}
	
							if {[S search 304 0 {} 55 eq \xee\x80\xc2\x05\xec\xa8\x40]} {
								>
									emit {\b,serial IO}
								<
							}
	
							if {[S search 196 0 {} 106 eq No\ active\ partition\0]} {
								>
									if {[S string [R 0] 0 {} {} eq Disk\ read\ error\0]} {
										>
											if {[S string [R 0] 0 {} {} eq No\ operating\ system\0]} {
												>
													emit {\b,verbose}
												<
											}
	
										<
									}
	
								<
							}
	
							if {[S search 125 0 {} 7 eq \x5a\x52\xb4\x08\xcd\x13]} {
								>
									emit {\b,CHS}
								<
							}
	
							if {[S search 164 0 {} 84 eq \xbb\xaa\x55\xb4\x41\x5a\x52\xcd\x13]} {
								>
									emit {\b,LBA-check}
								<
							}
	
							if {[S search 38 0 {} 21 eq \xBB\x94\x07]} {
								>
									if {[N ubequad [R -9] 0 0 & 13691207746446080916 == 13690943863638768532]} {
										>
											if {[S search 181 0 {} 166 eq Error\ \0]} {
												>
													if {[S string [R 3] 0 {} {} x {}]} {
														>
															emit {\b,"%s"}
														<
													}
	
												<
											}
	
										<
									}
	
								<
							}
	
							U 79 partition-table 446
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[N ubequad 0 0 0 & 16958463276293816320 == 16958462726538002432]} {
		>
			if {[N ubequad [I 1 ubyte 0 + 0 2] 0 0 {} {} == 18028402503091929230]} {
				>
					if {[S string 376 0 {} {} eq No\ operating\ system\r\n\0]} {
						>
							if {[S string 398 0 {} {} eq Disk\ error\r\n\0FDD\0HDD\0]} {
								>
									if {[S string 419 0 {} {} eq \ EBIOS\r\n\0]} {
										>
											emit {AdvanceMAME mbr}
										<
									}
	
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[N ulequad 0 0 0 & 14851535477856547324 == 10232179249133924860]} {
		>
			if {[S string [I 444 uleshort 0 + 0 0] 0 {} {} eq NDTmbr]} {
				>
					if {[S string [R -14] 0 {} {} eq 1234F\0]} {
						>
							emit {Turton mbr (}
							if {[N ubyte [I 444 uleshort 0 + 0 7] 0 0 {} {} x {}]} {
								>
									emit {\b%u<=}
								<
							}
	
							if {[N ubyte [I 444 uleshort 0 + 0 9] 0 0 {} {} x {}]} {
								>
									emit {\bVersion<=%u}
								<
							}
	
							if {[N ubyte [I 444 uleshort 0 + 0 8] 0 0 & 1 == 1]} {
								>
									emit {\b,Y2K-Fix}
								<
							}
	
							if {[N ubyte [I 444 uleshort 0 + 0 8] 0 0 & 2 == 2]} {
								>
									emit {\b,TestDisk}
								<
							}
	
							if {[N ubyte [I 444 uleshort 0 + 0 9] 0 0 {} {} < 2]} {
								>
									if {[N ubyte [I 444 uleshort 0 + 0 12] 0 0 {} {} != 18]} {
										>
											emit {\b,%u/18 seconds}
										<
									}
	
									if {[N ubyte [I 444 uleshort 0 + 0 13] 0 0 {} {} < 2]} {
										>
											emit {\b,floppy 0x%x}
										<
									}
	
									if {[N ubyte [I 444 uleshort 0 + 0 13] 0 0 {} {} > 1]} {
										>
											if {[N ubyte [I 444 uleshort 0 + 0 13] 0 0 {} {} != 128]} {
												>
													emit {\b,drive 0x%x}
												<
											}
	
										<
									}
	
								<
							}
	
							if {[N ubyte [I 444 uleshort 0 + 0 9] 0 0 {} {} > 1]} {
								>
									if {[N uleshort [I 444 uleshort 0 + 0 12] 0 0 {} {} != 18]} {
										>
											emit {\b,%u/18 seconds}
										<
									}
	
									if {[N ubyte [I 444 uleshort 0 + 0 14] 0 0 {} {} < 2]} {
										>
											emit {\b,floppy 0x%x}
										<
									}
	
									if {[N ubyte [I 444 uleshort 0 + 0 14] 0 0 {} {} > 1]} {
										>
											if {[N ubyte [I 444 uleshort 0 + 0 14] 0 0 {} {} != 128]} {
												>
													emit {\b,drive 0x%x}
												<
											}
	
										<
									}
	
								<
							}
	
							if {[N ubyte 0 0 0 {} {} x {}]} {
								>
									emit {\b)}
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[N uleshort 512 0 0 {} {} == 28906]} {
		>
			if {[N ubeshort 518 0 0 {} {} > 768]} {
				>
					if {[N ubyte 530 0 0 {} {} > 41]} {
						>
							if {[N ubyte 531 0 0 {} {} > 41]} {
								>
									if {[N ubyte 531 0 0 {} {} > 41]} {
										>
											emit {GRand Unified Bootloader}
										<
									}
	
									if {[N ubyte 535 0 0 {} {} == 255]} {
										>
											emit stage1_5
										<
									}
	
									if {[N ubyte 535 0 0 {} {} < 255]} {
										>
											emit stage2
										<
									}
	
									if {[N ubyte 518 0 0 {} {} x {}]} {
										>
											emit {\b version %u}
										<
									}
	
									if {[N ubyte 519 0 0 {} {} x {}]} {
										>
											emit {\b.%u}
										<
									}
	
									if {[N ulelong 520 0 0 {} {} < 16777215]} {
										>
											emit {\b, installed partition %u}
										<
									}
	
									if {[N ulelong 520 0 0 {} {} > 16777215]} {
										>
											emit {\b, installed partition %u}
										<
									}
	
									if {[N ulelong 524 0 0 & 774897664 == 774897664]} {
										>
											if {[N ubyte 524 0 0 {} {} x {}]} {
												>
													emit {\b, identifier 0x%x}
												<
											}
	
											if {[N ubyte 525 0 0 {} {} > 0]} {
												>
													emit {\b, LBA flag 0x%x}
												<
											}
	
											if {[S string 526 0 {} {} > \0]} {
												>
													emit {\b, GRUB version %-s}
													if {[N ulong 533 0 0 {} {} == 4294967295]} {
														>
															if {[S string 537 0 {} {} > \0]} {
																>
																	emit {\b, configuration file %-s}
																<
															}
	
														<
													}
	
													if {[N ulong 533 0 0 {} {} != 4294967295]} {
														>
															if {[S string 533 0 {} {} > \0]} {
																>
																	emit {\b, configuration file %-s}
																<
															}
	
														<
													}
	
												<
											}
	
										<
									}
	
									if {[N ulelong 524 0 0 & 774897664 != 774897664]} {
										>
											if {[N ulelong 524 0 0 {} {} > 0]} {
												>
													emit {\b, saved entry %d}
												<
											}
	
											if {[N ubyte 528 0 0 {} {} x {}]} {
												>
													emit {\b, identifier 0x%x}
												<
											}
	
											if {[N ubyte 529 0 0 {} {} > 0]} {
												>
													emit {\b, LBA flag 0x%x}
												<
											}
	
											if {[S string 530 0 {} {} > \0]} {
												>
													emit {\b, GRUB version %-s}
												<
											}
	
											if {[N ulong 535 0 0 {} {} == 4294967295]} {
												>
													if {[S string 539 0 {} {} > \0]} {
														>
															emit {\b, configuration file %-s}
														<
													}
	
												<
											}
	
											if {[N ulong 535 0 0 {} {} != 4294967295]} {
												>
													if {[S string 535 0 {} {} > \0]} {
														>
															emit {\b, configuration file %-s}
														<
													}
	
												<
											}
	
										<
									}
	
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[N ulelong 0 0 0 & 2151678185 == 233]} {
		>
			if {[N uleshort 11 0 0 & 31 == 0]} {
				>
					if {[N uleshort 11 0 0 {} {} < 32769]} {
						>
							if {[N uleshort 11 0 0 {} {} > 31]} {
								>
									if {[N ubyte 21 0 0 & 240 == 240]} {
										>
											switch [Nv ubyte 0 0 {} {}] {
												233 {
													>
														if {[N uleshort 1 0 0 {} {} x {}]} {
															>
																emit {\b, code offset 0x%x+3}
															<
														}
	
													<
												}
												235 {
													>
														emit {DOS/MBR boot sector}
														if {[N ubyte 1 0 0 {} {} x {}]} {
															>
																emit {\b, code offset 0x%x+2}
															<
														}
	
													<
												}
											}
	
											if {[S string 3 0 {} {} > \0]} {
												>
													emit {\b, OEM-ID "%-.8s"}
													if {[S string 8 0 {} {} eq IHC]} {
														>
															emit {\b cached by Windows 9M}
														<
													}
	
												<
											}
	
											if {[N uleshort 11 0 0 {} {} > 512]} {
												>
													emit {\b, Bytes/sector %u}
												<
											}
	
											if {[N uleshort 11 0 0 {} {} < 512]} {
												>
													emit {\b, Bytes/sector %u}
												<
											}
	
											if {[N ubyte 13 0 0 {} {} > 1]} {
												>
													emit {\b, sectors/cluster %u}
												<
											}
	
											if {[S string 82 0 c {} eq fat32]} {
												>
													if {[N uleshort 14 0 0 {} {} != 32]} {
														>
															emit {\b, reserved sectors %u}
														<
													}
	
												<
											}
	
											if {[S string 82 0 c {} ne fat32]} {
												>
													if {[N uleshort 14 0 0 {} {} > 1]} {
														>
															emit {\b, reserved sectors %u}
														<
													}
	
												<
											}
	
											if {[N ubyte 16 0 0 {} {} > 2]} {
												>
													emit {\b, FATs %u}
												<
											}
	
											switch [Nv ubyte 16 0 {} {}] {
												0 {
													>
														if {[N uleshort 17 0 0 {} {} == 0]} {
															>
																if {[N uleshort 19 0 0 {} {} == 0]} {
																	>
																		if {[N uleshort 22 0 0 {} {} == 0]} {
																			>
																				emit {\b; NTFS}
																				if {[N uleshort 24 0 0 {} {} > 0]} {
																					>
																						emit {\b, sectors/track %u}
																					<
																				}
	
																				if {[N ulelong 36 0 0 {} {} != 8388736]} {
																					>
																						emit {\b, physical drive 0x%x}
																					<
																				}
	
																				if {[N ulequad 40 0 0 {} {} > 0]} {
																					>
																						emit {\b, sectors %lld}
																					<
																				}
	
																				if {[N ulequad 48 0 0 {} {} > 0]} {
																					>
																						emit {\b, $MFT start cluster %lld}
																					<
																				}
	
																				if {[N ulequad 56 0 0 {} {} > 0]} {
																					>
																						emit {\b, $MFTMirror start cluster %lld}
																					<
																				}
	
																				if {[N lelong 64 0 0 {} {} < 256]} {
																					>
																						if {[N lelong 64 0 0 {} {} < 128]} {
																							>
																								emit {\b, clusters/RecordSegment %d}
																							<
																						}
	
																						if {[N ubyte 64 0 0 {} {} > 127]} {
																							>
																								emit {\b, bytes/RecordSegment 2^(-1*%i)}
																							<
																						}
	
																					<
																				}
	
																				if {[N ulelong 68 0 0 {} {} < 256]} {
																					>
																						if {[N ulelong 68 0 0 {} {} < 128]} {
																							>
																								emit {\b, clusters/index block %d}
																							<
																						}
	
																						if {[N ubyte 68 0 0 {} {} > 127]} {
																							>
																								emit {\b, bytes/index block 2^(-1*%i)}
																							<
																						}
	
																					<
																				}
	
																				if {[N ulequad 72 0 0 {} {} x {}]} {
																					>
																						emit {\b, serial number 0%llx}
																					<
																				}
	
																				if {[N ulelong 80 0 0 {} {} > 0]} {
																					>
																						emit {\b, checksum 0x%x}
																					<
																				}
	
																				if {[N ulelong 600 0 0 & 37008 == 37008]} {
																					>
																						emit {\b; contains}
																						T [R -92] {}
	
																					<
																				}
	
																			<
																		}
	
																	<
																}
	
															<
														}
	
													<
												}
												1 {
													>
														emit {\b, FAT  %u}
													<
												}
											}
	
											if {[N ubyte 16 0 0 {} {} > 0]} {
												>
												<
											}
	
											if {[N uleshort 17 0 0 {} {} > 0]} {
												>
													emit {\b, root entries %u}
												<
											}
	
											if {[N uleshort 19 0 0 {} {} > 0]} {
												>
													emit {\b, sectors %u (volumes <=32 MB)}
												<
											}
	
											if {[N ubyte 21 0 0 {} {} > 240]} {
												>
													emit {\b, Media descriptor 0x%x}
												<
											}
	
											if {[N ubyte 21 0 0 {} {} < 240]} {
												>
													emit {\b, Media descriptor 0x%x}
												<
											}
	
											if {[N uleshort 22 0 0 {} {} > 0]} {
												>
													emit {\b, sectors/FAT %u}
												<
											}
	
											if {[N uleshort 24 0 0 {} {} x {}]} {
												>
													emit {\b, sectors/track %u}
												<
											}
	
											if {[N ubyte 26 0 0 {} {} > 2]} {
												>
													emit {\b, heads %u}
												<
											}
	
											if {[N ubyte 26 0 0 {} {} == 1]} {
												>
													emit {\b, heads %u}
												<
											}
	
											if {[N uleshort 11 0 0 {} {} > 32]} {
												>
													if {[N ubyte 38 0 0 & 86 == 0]} {
														>
															if {[N ulelong 28 0 0 {} {} > 0]} {
																>
																	emit {\b, hidden sectors %u}
																<
															}
	
															if {[N ulelong 32 0 0 {} {} > 0]} {
																>
																	emit {\b, sectors %u (volumes > 32 MB)}
																<
															}
	
															if {[S string 82 0 c {} ne fat32]} {
																>
																	if {[N ubyte 36 0 0 {} {} != 128]} {
																		>
																			if {[N ubyte 36 0 0 {} {} != 0]} {
																				>
																					emit {\b, physical drive 0x%x}
																				<
																			}
	
																		<
																	}
	
																	if {[N ubyte 37 0 0 {} {} > 0]} {
																		>
																			emit {\b, reserved 0x%x}
																		<
																	}
	
																	if {[N ubyte 38 0 0 {} {} != 41]} {
																		>
																			emit {\b, dos < 4.0 BootSector (0x%x)}
																		<
																	}
	
																	if {[N ubyte 38 0 0 & 254 == 40]} {
																		>
																			if {[N ulelong 39 0 0 {} {} x {}]} {
																				>
																					emit {\b, serial number 0x%x}
																				<
																			}
	
																		<
																	}
	
																	if {[N ubyte 38 0 0 {} {} == 41]} {
																		>
																			if {[S string 43 0 {} {} < NO\ NAME]} {
																				>
																					emit {\b, label: "%11.11s"}
																				<
																			}
	
																			if {[S string 43 0 {} {} > NO\ NAME]} {
																				>
																					emit {\b, label: "%11.11s"}
																				<
																			}
	
																			if {[S string 43 0 {} {} eq NO\ NAME]} {
																				>
																					emit {\b, unlabeled}
																				<
																			}
	
																		<
																	}
	
																<
															}
	
														<
													}
	
												<
											}
	
											if {[S string 82 0 c {} ne fat32]} {
												>
													if {[S string 54 0 {} {} eq FAT12]} {
														>
															emit {\b, FAT (12 bit)}
														<
													}
	
													if {[S string 54 0 {} {} eq FAT16]} {
														>
															emit {\b, FAT (16 bit)}
														<
													}
	
													if {[D 54]} {
														>
															if {[N ubyte 21 0 0 {} {} < 240]} {
																>
																	emit {\b, FAT (12 bit by descriptor)}
																<
															}
	
															switch [Nv ubyte 21 0 {} {}] {
																240 {
																	>
																		if {[N ulelong 32 0 0 {} {} > 65535]} {
																			>
																				emit {\b, FAT (16 bit by descriptor+sectors)}
																			<
																		}
	
																		if {[D 32]} {
																			>
																				emit {\b, FAT (12 bit by descriptor+sectors)}
																			<
																		}
	
																	<
																}
																248 {
																	>
																		if {[N ubequad 19 0 0 {} {} == 14988815201611612161]} {
																			>
																				emit {\b, FAT (12 bit by descriptor+geometry)}
																			<
																		}
	
																		if {[D 19]} {
																			>
																				emit {\b, FAT (1Y bit by descriptor)}
																			<
																		}
	
																	<
																}
																250 {
																	>
																		if {[N ubequad 19 0 0 {} {} == 9224209873305600001]} {
																			>
																				emit {\b, FAT (12 bit by descriptor+geometry)}
																			<
																		}
	
																		if {[D 19]} {
																			>
																				emit {\b, FAT (1Y bit by descriptor)}
																			<
																		}
	
																	<
																}
															}
	
															if {[D 21]} {
																>
																	emit {\b, FAT (12 bit by descriptor)}
																<
															}
	
														<
													}
	
												<
											}
	
											if {[S string 82 0 c {} eq fat32]} {
												>
													emit {\b, FAT (32 bit)}
													if {[N ulelong 36 0 0 {} {} x {}]} {
														>
															emit {\b, sectors/FAT %u}
														<
													}
	
													if {[N uleshort 40 0 0 {} {} > 0]} {
														>
															emit {\b, extension flags 0x%x}
														<
													}
	
													if {[N uleshort 42 0 0 {} {} > 0]} {
														>
															emit {\b, fsVersion %u}
														<
													}
	
													if {[N ulelong 44 0 0 {} {} > 2]} {
														>
															emit {\b, rootdir cluster %u}
														<
													}
	
													if {[N uleshort 48 0 0 {} {} > 1]} {
														>
															emit {\b, infoSector %u}
														<
													}
	
													if {[N uleshort 48 0 0 {} {} < 1]} {
														>
															emit {\b, infoSector %u}
														<
													}
	
													switch [Nv uleshort 50 0 {} {}] {
														0 {
															>
																emit {\b, no Backup boot sector}
															<
														}
														65535 {
															>
																emit {\b, no Backup boot sector}
															<
														}
													}
	
													if {[D 50]} {
														>
															if {[N uleshort 50 0 0 {} {} x {}]} {
																>
																	emit {\b, Backup boot sector %u}
																<
															}
	
														<
													}
	
													if {[N ulelong 52 0 0 {} {} > 0]} {
														>
															emit {\b, reserved1 0x%x}
														<
													}
	
													if {[N ulelong 56 0 0 {} {} > 0]} {
														>
															emit {\b, reserved2 0x%x}
														<
													}
	
													if {[N ulelong 60 0 0 {} {} > 0]} {
														>
															emit {\b, reserved3 0x%x}
														<
													}
	
													if {[N ubyte 64 0 0 {} {} != 128]} {
														>
															if {[N ubyte 64 0 0 {} {} > 0]} {
																>
																	emit {\b, physical drive 0x%x}
																<
															}
	
														<
													}
	
													if {[N ubyte 65 0 0 {} {} > 0]} {
														>
															emit {\b, reserved 0x%x}
														<
													}
	
													if {[N ubyte 66 0 0 {} {} != 41]} {
														>
															emit {\b, dos < 4.0 BootSector (0x%x)}
														<
													}
	
													if {[N ubyte 66 0 0 {} {} == 41]} {
														>
															if {[N ulelong 67 0 0 {} {} x {}]} {
																>
																	emit {\b, serial number 0x%x}
																<
															}
	
															if {[S string 71 0 {} {} < NO\ NAME]} {
																>
																	emit {\b, label: "%11.11s"}
																<
															}
	
															if {[S string 71 0 {} {} > NO\ NAME]} {
																>
																	emit {\b, label: "%11.11s"}
																<
															}
	
															if {[S string 71 0 {} {} eq NO\ NAME]} {
																>
																	emit {\b, unlabeled}
																<
															}
	
														<
													}
	
												<
											}
	
											if {[N ubyte 21 0 0 {} {} != 248]} {
												>
													if {[S string 54 0 {} {} ne FAT16]} {
														>
															if {[N ulelong [I 11 uleshort 0 + 0 0] 0 0 & 16777200 == 16777200]} {
																>
																	emit {\b, followed by FAT}
																	mime application/x-ima
																<
															}
	
														<
													}
	
												<
											}
	
										<
									}
	
								<
							}
	
						<
					}
	
				<
			}
	
			strength +60
		<
	}
	
	if {[N ulelong 86 0 0 & 4294905855 == 2425357035]} {
		>
			if {[N ulelong [I 0 uleshort 0 * 0 2] 0 0 & 4294967040 == 262144]} {
				>
					if {[S lestring16 2 0 {} {} x {}]} {
						>
							emit {Microsoft Windows XP/VISTA bootloader %-5.5s}
						<
					}
	
					if {[S string 18 0 {} {} eq \$]} {
						>
							if {[S lestring16 12 0 {} {} x {}]} {
								>
									emit {\b%-2.2s}
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \0ntfsclone-image]} {
		>
			emit {ntfsclone image,}
			if {[N byte 16 0 0 {} {} x {}]} {
				>
					emit {version %d.}
				<
			}
	
			if {[N byte 17 0 0 {} {} x {}]} {
				>
					emit {\b%d,}
				<
			}
	
			if {[N lelong 18 0 0 {} {} x {}]} {
				>
					emit {cluster size %d,}
				<
			}
	
			if {[N lequad 22 0 0 {} {} x {}]} {
				>
					emit {device size %lld,}
				<
			}
	
			if {[N lequad 30 0 0 {} {} x {}]} {
				>
					emit {%lld total clusters,}
				<
			}
	
			if {[N lequad 38 0 0 {} {} x {}]} {
				>
					emit {%lld clusters in use}
				<
			}
	
		<
	}
	
	if {[N lelong 9564 0 0 {} {} == 72020]} {
		>
			emit {Unix Fast File system [v1] (little-endian),}
			if {[S string 8404 0 {} {} x {}]} {
				>
					emit {last mounted on %s,}
				<
			}
	
			if {[N ledate 8224 0 0 {} {} x {}]} {
				>
					emit {last written at %s,}
				<
			}
	
			if {[N byte 8401 0 0 {} {} x {}]} {
				>
					emit {clean flag %d,}
				<
			}
	
			if {[N lelong 8228 0 0 {} {} x {}]} {
				>
					emit {number of blocks %d,}
				<
			}
	
			if {[N lelong 8232 0 0 {} {} x {}]} {
				>
					emit {number of data blocks %d,}
				<
			}
	
			if {[N lelong 8236 0 0 {} {} x {}]} {
				>
					emit {number of cylinder groups %d,}
				<
			}
	
			if {[N lelong 8240 0 0 {} {} x {}]} {
				>
					emit {block size %d,}
				<
			}
	
			if {[N lelong 8244 0 0 {} {} x {}]} {
				>
					emit {fragment size %d,}
				<
			}
	
			if {[N lelong 8252 0 0 {} {} x {}]} {
				>
					emit {minimum percentage of free blocks %d,}
				<
			}
	
			if {[N lelong 8256 0 0 {} {} x {}]} {
				>
					emit {rotational delay %dms,}
				<
			}
	
			if {[N lelong 8260 0 0 {} {} x {}]} {
				>
					emit {disk rotational speed %drps,}
				<
			}
	
			switch [Nv lelong 8320 0 {} {}] {
				0 {
					>
						emit {TIME optimization}
					<
				}
				1 {
					>
						emit {SPACE optimization}
					<
				}
			}
	
		<
	}
	
	if {[N lelong 42332 0 0 {} {} == 424935705]} {
		>
			emit {Unix Fast File system [v2] (little-endian)}
			if {[S string [R -1164] 0 {} {} x {}]} {
				>
					emit {last mounted on %s,}
				<
			}
	
			if {[S string [R -696] 0 {} {} > \0]} {
				>
					emit {volume name %s,}
				<
			}
	
			if {[N leqldate [R -304] 0 0 {} {} x {}]} {
				>
					emit {last written at %s,}
				<
			}
	
			if {[N byte [R -1167] 0 0 {} {} x {}]} {
				>
					emit {clean flag %d,}
				<
			}
	
			if {[N byte [R -1168] 0 0 {} {} x {}]} {
				>
					emit {readonly flag %d,}
				<
			}
	
			if {[N lequad [R -296] 0 0 {} {} x {}]} {
				>
					emit {number of blocks %lld,}
				<
			}
	
			if {[N lequad [R -288] 0 0 {} {} x {}]} {
				>
					emit {number of data blocks %lld,}
				<
			}
	
			if {[N lelong [R -1332] 0 0 {} {} x {}]} {
				>
					emit {number of cylinder groups %d,}
				<
			}
	
			if {[N lelong [R -1328] 0 0 {} {} x {}]} {
				>
					emit {block size %d,}
				<
			}
	
			if {[N lelong [R -1324] 0 0 {} {} x {}]} {
				>
					emit {fragment size %d,}
				<
			}
	
			if {[N lelong [R -180] 0 0 {} {} x {}]} {
				>
					emit {average file size %d,}
				<
			}
	
			if {[N lelong [R -176] 0 0 {} {} x {}]} {
				>
					emit {average number of files in dir %d,}
				<
			}
	
			if {[N lequad [R -272] 0 0 {} {} x {}]} {
				>
					emit {pending blocks to free %lld,}
				<
			}
	
			if {[N lelong [R -264] 0 0 {} {} x {}]} {
				>
					emit {pending inodes to free %d,}
				<
			}
	
			if {[N lequad [R -664] 0 0 {} {} x {}]} {
				>
					emit {system-wide uuid %0llx,}
				<
			}
	
			if {[N lelong [R -1316] 0 0 {} {} x {}]} {
				>
					emit {minimum percentage of free blocks %d,}
				<
			}
	
			switch [Nv lelong [R -1248] 0 {} {}] {
				0 {
					>
						emit {TIME optimization}
					<
				}
				1 {
					>
						emit {SPACE optimization}
					<
				}
			}
	
		<
	}
	
	if {[N lelong 66908 0 0 {} {} == 424935705]} {
		>
			emit {Unix Fast File system [v2] (little-endian)}
			if {[S string [R -1164] 0 {} {} x {}]} {
				>
					emit {last mounted on %s,}
				<
			}
	
			if {[S string [R -696] 0 {} {} > \0]} {
				>
					emit {volume name %s,}
				<
			}
	
			if {[N leqldate [R -304] 0 0 {} {} x {}]} {
				>
					emit {last written at %s,}
				<
			}
	
			if {[N byte [R -1167] 0 0 {} {} x {}]} {
				>
					emit {clean flag %d,}
				<
			}
	
			if {[N byte [R -1168] 0 0 {} {} x {}]} {
				>
					emit {readonly flag %d,}
				<
			}
	
			if {[N lequad [R -296] 0 0 {} {} x {}]} {
				>
					emit {number of blocks %lld,}
				<
			}
	
			if {[N lequad [R -288] 0 0 {} {} x {}]} {
				>
					emit {number of data blocks %lld,}
				<
			}
	
			if {[N lelong [R -1332] 0 0 {} {} x {}]} {
				>
					emit {number of cylinder groups %d,}
				<
			}
	
			if {[N lelong [R -1328] 0 0 {} {} x {}]} {
				>
					emit {block size %d,}
				<
			}
	
			if {[N lelong [R -1324] 0 0 {} {} x {}]} {
				>
					emit {fragment size %d,}
				<
			}
	
			if {[N lelong [R -180] 0 0 {} {} x {}]} {
				>
					emit {average file size %d,}
				<
			}
	
			if {[N lelong [R -176] 0 0 {} {} x {}]} {
				>
					emit {average number of files in dir %d,}
				<
			}
	
			if {[N lequad [R -272] 0 0 {} {} x {}]} {
				>
					emit {pending blocks to free %lld,}
				<
			}
	
			if {[N lelong [R -264] 0 0 {} {} x {}]} {
				>
					emit {pending inodes to free %d,}
				<
			}
	
			if {[N lequad [R -664] 0 0 {} {} x {}]} {
				>
					emit {system-wide uuid %0llx,}
				<
			}
	
			if {[N lelong [R -1316] 0 0 {} {} x {}]} {
				>
					emit {minimum percentage of free blocks %d,}
				<
			}
	
			switch [Nv lelong [R -1248] 0 {} {}] {
				0 {
					>
						emit {TIME optimization}
					<
				}
				1 {
					>
						emit {SPACE optimization}
					<
				}
			}
	
		<
	}
	
	if {[N belong 9564 0 0 {} {} == 72020]} {
		>
			emit {Unix Fast File system [v1] (big-endian),}
			if {[N belong 7168 0 0 {} {} == 1279345228]} {
				>
					emit {Apple UFS Volume}
					if {[S string 7186 0 {} {} x {}]} {
						>
							emit {named %s,}
						<
					}
	
					if {[N belong 7176 0 0 {} {} x {}]} {
						>
							emit {volume label version %d,}
						<
					}
	
					if {[N bedate 7180 0 0 {} {} x {}]} {
						>
							emit {created on %s,}
						<
					}
	
				<
			}
	
			if {[S string 8404 0 {} {} x {}]} {
				>
					emit {last mounted on %s,}
				<
			}
	
			if {[N bedate 8224 0 0 {} {} x {}]} {
				>
					emit {last written at %s,}
				<
			}
	
			if {[N byte 8401 0 0 {} {} x {}]} {
				>
					emit {clean flag %d,}
				<
			}
	
			if {[N belong 8228 0 0 {} {} x {}]} {
				>
					emit {number of blocks %d,}
				<
			}
	
			if {[N belong 8232 0 0 {} {} x {}]} {
				>
					emit {number of data blocks %d,}
				<
			}
	
			if {[N belong 8236 0 0 {} {} x {}]} {
				>
					emit {number of cylinder groups %d,}
				<
			}
	
			if {[N belong 8240 0 0 {} {} x {}]} {
				>
					emit {block size %d,}
				<
			}
	
			if {[N belong 8244 0 0 {} {} x {}]} {
				>
					emit {fragment size %d,}
				<
			}
	
			if {[N belong 8252 0 0 {} {} x {}]} {
				>
					emit {minimum percentage of free blocks %d,}
				<
			}
	
			if {[N belong 8256 0 0 {} {} x {}]} {
				>
					emit {rotational delay %dms,}
				<
			}
	
			if {[N belong 8260 0 0 {} {} x {}]} {
				>
					emit {disk rotational speed %drps,}
				<
			}
	
			switch [Nv belong 8320 0 {} {}] {
				0 {
					>
						emit {TIME optimization}
					<
				}
				1 {
					>
						emit {SPACE optimization}
					<
				}
			}
	
		<
	}
	
	if {[N belong 42332 0 0 {} {} == 424935705]} {
		>
			emit {Unix Fast File system [v2] (big-endian)}
			if {[S string [R -1164] 0 {} {} x {}]} {
				>
					emit {last mounted on %s,}
				<
			}
	
			if {[S string [R -696] 0 {} {} > \0]} {
				>
					emit {volume name %s,}
				<
			}
	
			if {[N beqldate [R -304] 0 0 {} {} x {}]} {
				>
					emit {last written at %s,}
				<
			}
	
			if {[N byte [R -1167] 0 0 {} {} x {}]} {
				>
					emit {clean flag %d,}
				<
			}
	
			if {[N byte [R -1168] 0 0 {} {} x {}]} {
				>
					emit {readonly flag %d,}
				<
			}
	
			if {[N bequad [R -296] 0 0 {} {} x {}]} {
				>
					emit {number of blocks %lld,}
				<
			}
	
			if {[N bequad [R -288] 0 0 {} {} x {}]} {
				>
					emit {number of data blocks %lld,}
				<
			}
	
			if {[N belong [R -1332] 0 0 {} {} x {}]} {
				>
					emit {number of cylinder groups %d,}
				<
			}
	
			if {[N belong [R -1328] 0 0 {} {} x {}]} {
				>
					emit {block size %d,}
				<
			}
	
			if {[N belong [R -1324] 0 0 {} {} x {}]} {
				>
					emit {fragment size %d,}
				<
			}
	
			if {[N belong [R -180] 0 0 {} {} x {}]} {
				>
					emit {average file size %d,}
				<
			}
	
			if {[N belong [R -176] 0 0 {} {} x {}]} {
				>
					emit {average number of files in dir %d,}
				<
			}
	
			if {[N bequad [R -272] 0 0 {} {} x {}]} {
				>
					emit {pending blocks to free %lld,}
				<
			}
	
			if {[N belong [R -264] 0 0 {} {} x {}]} {
				>
					emit {pending inodes to free %d,}
				<
			}
	
			if {[N bequad [R -664] 0 0 {} {} x {}]} {
				>
					emit {system-wide uuid %0llx,}
				<
			}
	
			if {[N belong [R -1316] 0 0 {} {} x {}]} {
				>
					emit {minimum percentage of free blocks %d,}
				<
			}
	
			switch [Nv belong [R -1248] 0 {} {}] {
				0 {
					>
						emit {TIME optimization}
					<
				}
				1 {
					>
						emit {SPACE optimization}
					<
				}
			}
	
		<
	}
	
	if {[N belong 66908 0 0 {} {} == 424935705]} {
		>
			emit {Unix Fast File system [v2] (big-endian)}
			if {[S string [R -1164] 0 {} {} x {}]} {
				>
					emit {last mounted on %s,}
				<
			}
	
			if {[S string [R -696] 0 {} {} > \0]} {
				>
					emit {volume name %s,}
				<
			}
	
			if {[N beqldate [R -304] 0 0 {} {} x {}]} {
				>
					emit {last written at %s,}
				<
			}
	
			if {[N byte [R -1167] 0 0 {} {} x {}]} {
				>
					emit {clean flag %d,}
				<
			}
	
			if {[N byte [R -1168] 0 0 {} {} x {}]} {
				>
					emit {readonly flag %d,}
				<
			}
	
			if {[N bequad [R -296] 0 0 {} {} x {}]} {
				>
					emit {number of blocks %lld,}
				<
			}
	
			if {[N bequad [R -288] 0 0 {} {} x {}]} {
				>
					emit {number of data blocks %lld,}
				<
			}
	
			if {[N belong [R -1332] 0 0 {} {} x {}]} {
				>
					emit {number of cylinder groups %d,}
				<
			}
	
			if {[N belong [R -1328] 0 0 {} {} x {}]} {
				>
					emit {block size %d,}
				<
			}
	
			if {[N belong [R -1324] 0 0 {} {} x {}]} {
				>
					emit {fragment size %d,}
				<
			}
	
			if {[N belong [R -180] 0 0 {} {} x {}]} {
				>
					emit {average file size %d,}
				<
			}
	
			if {[N belong [R -176] 0 0 {} {} x {}]} {
				>
					emit {average number of files in dir %d,}
				<
			}
	
			if {[N bequad [R -272] 0 0 {} {} x {}]} {
				>
					emit {pending blocks to free %lld,}
				<
			}
	
			if {[N belong [R -264] 0 0 {} {} x {}]} {
				>
					emit {pending inodes to free %d,}
				<
			}
	
			if {[N bequad [R -664] 0 0 {} {} x {}]} {
				>
					emit {system-wide uuid %0llx,}
				<
			}
	
			if {[N belong [R -1316] 0 0 {} {} x {}]} {
				>
					emit {minimum percentage of free blocks %d,}
				<
			}
	
			switch [Nv belong [R -1248] 0 {} {}] {
				0 {
					>
						emit {TIME optimization}
					<
				}
				1 {
					>
						emit {SPACE optimization}
					<
				}
			}
	
		<
	}
	
	switch [Nv ulequad 0 0 {} {}] {
		6192449487699967 {
			>
				U 163 msdos-driver 0
	
			<
		}
		16325548649369164 {
			>
				emit {MS Advisor help file}
			<
		}
		35747322042318847 {
			>
				U 163 msdos-driver 0
	
			<
		}
		365847100979675154 {
			>
				U 163 msdos-driver 0
	
			<
		}
		557611562475454463 {
			>
				U 163 msdos-driver 0
	
			<
		}
		862167487276384255 {
			>
				U 163 msdos-driver 0
	
			<
		}
		3671137388043632662 {
			>
				U 163 msdos-driver 0
	
			<
		}
		14429899677490098225 {
			>
				emit {HAMMER filesystem (little-endian),}
				if {[N lelong 144 0 0 + 1 x {}]} {
					>
						emit {volume %d}
					<
				}
	
				if {[N lelong 148 0 0 {} {} x {}]} {
					>
						emit {(of %d),}
					<
				}
	
				if {[S string 80 0 {} {} x {}]} {
					>
						emit {name %s,}
					<
				}
	
				if {[N ulelong 152 0 0 {} {} x {}]} {
					>
						emit {version %u,}
					<
				}
	
				if {[N ulelong 160 0 0 {} {} x {}]} {
					>
						emit {flags 0x%x}
					<
				}
	
			<
		}
	}
	
	if {[N leshort 1080 0 0 {} {} == -4269]} {
		>
			emit Linux
			if {[N lelong 1100 0 0 {} {} x {}]} {
				>
					emit {rev %d}
				<
			}
	
			if {[N leshort 1086 0 0 {} {} x {}]} {
				>
					emit {\b.%d}
				<
			}
	
			if {[N lelong 1116 0 0 {} {} ^ 4]} {
				>
					emit {ext2 filesystem data}
					if {[N leshort 1082 0 0 {} {} ^ 1]} {
						>
							emit {(mounted or unclean)}
						<
					}
	
				<
			}
	
			if {[N lelong 1116 0 0 {} {} & 4]} {
				>
					if {[N lelong 1120 0 0 {} {} < 64]} {
						>
							if {[N lelong 1124 0 0 {} {} < 8]} {
								>
									emit {ext3 filesystem data}
								<
							}
	
							if {[N lelong 1124 0 0 {} {} > 7]} {
								>
									emit {ext4 filesystem data}
								<
							}
	
						<
					}
	
					if {[N lelong 1120 0 0 {} {} > 63]} {
						>
							emit {ext4 filesystem data}
						<
					}
	
				<
			}
	
			if {[N belong 1128 0 0 {} {} x {}]} {
				>
					emit {\b, UUID=%08x}
				<
			}
	
			if {[N beshort 1132 0 0 {} {} x {}]} {
				>
					emit {\b-%04x}
				<
			}
	
			if {[N beshort 1134 0 0 {} {} x {}]} {
				>
					emit {\b-%04x}
				<
			}
	
			if {[N beshort 1136 0 0 {} {} x {}]} {
				>
					emit {\b-%04x}
				<
			}
	
			if {[N belong 1138 0 0 {} {} x {}]} {
				>
					emit {\b-%08x}
				<
			}
	
			if {[N beshort 1142 0 0 {} {} x {}]} {
				>
					emit {\b%04x}
				<
			}
	
			if {[S string 1144 0 {} {} > 0]} {
				>
					emit {\b, volume name "%s"}
				<
			}
	
			if {[N lelong 1120 0 0 {} {} & 4]} {
				>
					emit {(needs journal recovery)}
				<
			}
	
			if {[N leshort 1082 0 0 {} {} & 2]} {
				>
					emit (errors)
				<
			}
	
			if {[N lelong 1120 0 0 {} {} & 1]} {
				>
					emit (compressed)
				<
			}
	
			if {[N lelong 1120 0 0 {} {} & 64]} {
				>
					emit (extents)
				<
			}
	
			if {[N lelong 1120 0 0 {} {} & 128]} {
				>
					emit (64bit)
				<
			}
	
			if {[N lelong 1124 0 0 {} {} & 2]} {
				>
					emit {(large files)}
				<
			}
	
			if {[N lelong 1124 0 0 {} {} & 8]} {
				>
					emit {(huge files)}
				<
			}
	
		<
	}
	
	if {[N lelong 1024 0 0 {} {} == -218816496]} {
		>
			emit {F2FS filesystem}
			if {[N belong 1132 0 0 {} {} x {}]} {
				>
					emit {\b, UUID=%08x}
				<
			}
	
			if {[N beshort 1136 0 0 {} {} x {}]} {
				>
					emit {\b-%04x}
				<
			}
	
			if {[N beshort 1138 0 0 {} {} x {}]} {
				>
					emit {\b-%04x}
				<
			}
	
			if {[N beshort 1140 0 0 {} {} x {}]} {
				>
					emit {\b-%04x}
				<
			}
	
			if {[N belong 1142 0 0 {} {} x {}]} {
				>
					emit {\b-%08x}
				<
			}
	
			if {[N beshort 1146 0 0 {} {} x {}]} {
				>
					emit {\b%04x}
				<
			}
	
			if {[S lestring16 5244 0 {} {} x {}]} {
				>
					emit {\b, volume name "%s"}
				<
			}
	
		<
	}
	
	switch [Nv leshort 1040 0 {} {}] {
		4991 {
			>
				if {[N beshort 1026 0 0 {} {} < 100]} {
					>
					<
				}
	
				if {[N beshort 1026 0 0 {} {} > -1]} {
					>
						emit {Minix filesystem, V1, 14 char names, %d zones}
					<
				}
	
				if {[S string 30 0 {} {} eq minix]} {
					>
						emit {\b, bootable}
					<
				}
	
			<
		}
		5007 {
			>
				if {[N beshort 1026 0 0 {} {} < 100]} {
					>
					<
				}
	
				if {[N beshort 1026 0 0 {} {} > -1]} {
					>
						emit {Minix filesystem, V1, 30 char names, %d zones}
					<
				}
	
				if {[S string 30 0 {} {} eq minix]} {
					>
						emit {\b, bootable}
					<
				}
	
			<
		}
	}
	
	switch [Nv beshort 1040 0 {} {}] {
		4991 {
			>
				if {[N beshort 1026 0 0 {} {} < 100]} {
					>
					<
				}
	
				if {[N beshort 1026 0 0 {} {} > -1]} {
					>
						emit {Minix filesystem, V1 (big endian), %d zones}
					<
				}
	
				if {[S string 30 0 {} {} eq minix]} {
					>
						emit {\b, bootable}
					<
				}
	
			<
		}
		5007 {
			>
				if {[N beshort 1026 0 0 {} {} < 100]} {
					>
					<
				}
	
				if {[N beshort 1026 0 0 {} {} > -1]} {
					>
						emit {Minix filesystem, V1, 30 char names (big endian), %d zones}
					<
				}
	
				if {[S string 30 0 {} {} eq minix]} {
					>
						emit {\b, bootable}
					<
				}
	
			<
		}
	}
	
	if {[N belong 2048 0 0 {} {} == 1190930176]} {
		>
			emit {Atari-ST Minix kernel image}
			if {[S string 19 0 {} {} eq \240\005\371\005\0\011\0\2\0]} {
				>
					emit {\b, 720k floppy}
				<
			}
	
			if {[S string 19 0 {} {} eq \320\002\370\005\0\011\0\1\0]} {
				>
					emit {\b, 360k floppy}
				<
			}
	
		<
	}
	
	if {[S string 19 0 {} {} eq \320\002\360\003\0\011\0\1\0]} {
		>
			emit {DOS floppy 360k}
			if {[N leshort 510 0 0 {} {} == -21931]} {
				>
					emit {\b, DOS/MBR hard disk boot sector}
				<
			}
	
		<
	}
	
	if {[S string 19 0 {} {} eq \240\005\371\003\0\011\0\2\0]} {
		>
			emit {DOS floppy 720k}
			if {[N leshort 510 0 0 {} {} == -21931]} {
				>
					emit {\b, DOS/MBR hard disk boot sector}
				<
			}
	
		<
	}
	
	if {[S string 19 0 {} {} eq \100\013\360\011\0\022\0\2\0]} {
		>
			emit {DOS floppy 1440k}
			if {[N leshort 510 0 0 {} {} == -21931]} {
				>
					emit {\b, DOS/MBR hard disk boot sector}
				<
			}
	
		<
	}
	
	if {[S string 19 0 {} {} eq \240\005\371\005\0\011\0\2\0]} {
		>
			emit {DOS floppy 720k, IBM}
			if {[N leshort 510 0 0 {} {} == -21931]} {
				>
					emit {\b, DOS/MBR hard disk boot sector}
				<
			}
	
		<
	}
	
	if {[S string 19 0 {} {} eq \100\013\371\005\0\011\0\2\0]} {
		>
			emit {DOS floppy 1440k, mkdosfs}
			if {[N leshort 510 0 0 {} {} == -21931]} {
				>
					emit {\b, DOS/MBR hard disk boot sector}
				<
			}
	
		<
	}
	
	if {[S string 19 0 {} {} eq \320\002\370\005\0\011\0\1\0]} {
		>
			emit {Atari-ST floppy 360k}
		<
	}
	
	if {[S string 19 0 {} {} eq \240\005\371\005\0\011\0\2\0]} {
		>
			emit {Atari-ST floppy 720k}
		<
	}
	
	if {[S string 37633 0 {} {} eq CD001]} {
		>
			emit {ISO 9660 CD-ROM filesystem data (raw 2352 byte sectors)}
			mime application/x-iso9660-image
		<
	}
	
	if {[S string 32777 0 {} {} eq CDROM]} {
		>
			emit {High Sierra CD-ROM filesystem data}
		<
	}
	
	if {[S string 32769 0 {} {} eq CD001]} {
		>
			U 79 cdrom 0
	
			strength +34
		<
	}
	
	if {[S string 339969 0 {} {} eq CD001]} {
		>
			emit {Nero CD image at 0x4B000}
			U 79 cdrom 307200
	
			mime application/x-nrg
			ext nrg
		<
	}
	
	if {[S string 0 0 {} {} eq CISO]} {
		>
			if {[N lelong 4 0 0 {} {} != 0]} {
				>
					if {[N lelong 4 0 0 {} {} != 2097152]} {
						>
							if {[N lelong 16 0 0 {} {} != 2048]} {
								>
									emit {Compressed ISO CD image}
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 65588 0 {} {} eq ReIsErFs]} {
		>
			emit {ReiserFS V3.5}
		<
	}
	
	if {[S string 65588 0 {} {} eq ReIsEr2Fs]} {
		>
			emit {ReiserFS V3.6}
		<
	}
	
	if {[S string 65588 0 {} {} eq ReIsEr3Fs]} {
		>
			emit {ReiserFS V3.6.19}
			if {[N leshort 65580 0 0 {} {} x {}]} {
				>
					emit {block size %d}
				<
			}
	
			if {[N leshort 65586 0 0 {} {} & 2]} {
				>
					emit {(mounted or unclean)}
				<
			}
	
			if {[N lelong 65536 0 0 {} {} x {}]} {
				>
					emit {num blocks %d}
				<
			}
	
			switch [Nv lelong 65600 0 {} {}] {
				1 {
					>
						emit {tea hash}
					<
				}
				2 {
					>
						emit {yura hash}
					<
				}
				3 {
					>
						emit {r5 hash}
					<
				}
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq ESTFBINR]} {
		>
			emit {EST flat binary}
		<
	}
	
	if {[S string 0 0 {} {} eq VoIP\ Startup\ and]} {
		>
			emit {Aculab VoIP firmware}
			if {[S string 35 0 {} {} x {}]} {
				>
					emit {format %s}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq sqsh]} {
		>
			emit {Squashfs filesystem, big endian,}
			if {[N beshort 28 0 0 {} {} x {}]} {
				>
					emit {version %d.}
				<
			}
	
			if {[N beshort 30 0 0 {} {} x {}]} {
				>
					emit {\b%d,}
				<
			}
	
			if {[N beshort 28 0 0 {} {} < 3]} {
				>
					if {[N belong 8 0 0 {} {} x {}]} {
						>
							emit {%d bytes,}
						<
					}
	
				<
			}
	
			if {[N beshort 28 0 0 {} {} > 2]} {
				>
					if {[N beshort 28 0 0 {} {} < 4]} {
						>
							if {[N bequad 63 0 0 {} {} x {}]} {
								>
									emit {%lld bytes,}
								<
							}
	
						<
					}
	
					if {[N beshort 28 0 0 {} {} > 3]} {
						>
							if {[N bequad 40 0 0 {} {} x {}]} {
								>
									emit {%lld bytes,}
								<
							}
	
						<
					}
	
				<
			}
	
			if {[N belong 4 0 0 {} {} x {}]} {
				>
					emit {%d inodes,}
				<
			}
	
			if {[N beshort 28 0 0 {} {} < 2]} {
				>
					if {[N beshort 32 0 0 {} {} x {}]} {
						>
							emit {blocksize: %d bytes,}
						<
					}
	
				<
			}
	
			if {[N beshort 28 0 0 {} {} > 1]} {
				>
					if {[N beshort 28 0 0 {} {} < 4]} {
						>
							if {[N belong 51 0 0 {} {} x {}]} {
								>
									emit {blocksize: %d bytes,}
								<
							}
	
						<
					}
	
					if {[N beshort 28 0 0 {} {} > 3]} {
						>
							if {[N belong 12 0 0 {} {} x {}]} {
								>
									emit {blocksize: %d bytes,}
								<
							}
	
						<
					}
	
				<
			}
	
			if {[N beshort 28 0 0 {} {} < 4]} {
				>
					if {[N bedate 39 0 0 {} {} x {}]} {
						>
							emit {created: %s}
						<
					}
	
				<
			}
	
			if {[N beshort 28 0 0 {} {} > 3]} {
				>
					if {[N bedate 8 0 0 {} {} x {}]} {
						>
							emit {created: %s}
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq hsqs]} {
		>
			emit {Squashfs filesystem, little endian,}
			if {[N leshort 28 0 0 {} {} x {}]} {
				>
					emit {version %d.}
				<
			}
	
			if {[N leshort 30 0 0 {} {} x {}]} {
				>
					emit {\b%d,}
				<
			}
	
			if {[N leshort 28 0 0 {} {} < 3]} {
				>
					if {[N lelong 8 0 0 {} {} x {}]} {
						>
							emit {%d bytes,}
						<
					}
	
				<
			}
	
			if {[N leshort 28 0 0 {} {} > 2]} {
				>
					if {[N leshort 28 0 0 {} {} < 4]} {
						>
							if {[N lequad 63 0 0 {} {} x {}]} {
								>
									emit {%lld bytes,}
								<
							}
	
						<
					}
	
					if {[N leshort 28 0 0 {} {} > 3]} {
						>
							if {[N lequad 40 0 0 {} {} x {}]} {
								>
									emit {%lld bytes,}
								<
							}
	
						<
					}
	
				<
			}
	
			if {[N lelong 4 0 0 {} {} x {}]} {
				>
					emit {%d inodes,}
				<
			}
	
			if {[N leshort 28 0 0 {} {} < 2]} {
				>
					if {[N leshort 32 0 0 {} {} x {}]} {
						>
							emit {blocksize: %d bytes,}
						<
					}
	
				<
			}
	
			if {[N leshort 28 0 0 {} {} > 1]} {
				>
					if {[N leshort 28 0 0 {} {} < 4]} {
						>
							if {[N lelong 51 0 0 {} {} x {}]} {
								>
									emit {blocksize: %d bytes,}
								<
							}
	
						<
					}
	
					if {[N leshort 28 0 0 {} {} > 3]} {
						>
							if {[N lelong 12 0 0 {} {} x {}]} {
								>
									emit {blocksize: %d bytes,}
								<
							}
	
						<
					}
	
				<
			}
	
			if {[N leshort 28 0 0 {} {} < 4]} {
				>
					if {[N ledate 39 0 0 {} {} x {}]} {
						>
							emit {created: %s}
						<
					}
	
				<
			}
	
			if {[N leshort 28 0 0 {} {} > 3]} {
				>
					if {[N ledate 8 0 0 {} {} x {}]} {
						>
							emit {created: %s}
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \x01\xb3\xa1\x13\x22]} {
		>
			emit {AFS Dump}
			if {[N belong [R 0] 0 0 {} {} x {}]} {
				>
					emit (v%d)
					if {[N byte [R 0] 0 0 {} {} == 118]} {
						>
							if {[N belong [R 0] 0 0 {} {} x {}]} {
								>
									emit {Vol %d,}
									if {[N byte [R 0] 0 0 {} {} == 110]} {
										>
											if {[S string [R 0] 0 {} {} x {}]} {
												>
													emit %s
													if {[N byte [R 1] 0 0 {} {} == 116]} {
														>
															if {[N beshort [R 0] 0 0 {} {} == 2]} {
																>
																	if {[N bedate [R 4] 0 0 {} {} x {}]} {
																		>
																			emit {on: %s}
																		<
																	}
	
																	if {[N bedate [R 0] 0 0 {} {} == 0]} {
																		>
																			emit {full dump}
																		<
																	}
	
																	if {[N bedate [R 0] 0 0 {} {} != 0]} {
																		>
																			emit {incremental since: %s}
																		<
																	}
	
																<
															}
	
														<
													}
	
												<
											}
	
										<
									}
	
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq DISO]} {
		>
			emit {Delta ISO data}
			if {[N belong 4 0 0 {} {} x {}]} {
				>
					emit {version %d}
				<
			}
	
			strength +50
		<
	}
	
	if {[S string 4 0 {} {} eq \x01\x00\x01\x00\x01\x00]} {
		>
			if {[S string [I 0 uleshort 0 + 0 16] 0 {} {} eq \x01\x01]} {
				>
					if {[N byte [R [I [R 0] ubyte 0 + 0 8]] 0 0 {} {} == 66]} {
						>
							emit {OpenVMS backup saveset data}
							if {[N lelong 40 0 0 {} {} x {}]} {
								>
									emit {(block size %d,}
								<
							}
	
							if {[S string 49 0 {} {} > \0]} {
								>
									emit {original name '%s',}
								<
							}
	
							switch [Nv short 2 0 {} {}] {
								1024 {
									>
										emit {VAX generated)}
									<
								}
								2048 {
									>
										emit {AXP generated)}
									<
								}
								4096 {
									>
										emit {I64 generated)}
									<
								}
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 8 0 {} {} eq OracleCFS]} {
		>
			emit {Oracle Clustered Filesystem,}
			if {[N long 4 0 0 {} {} x {}]} {
				>
					emit {rev %d}
				<
			}
	
			if {[N long 0 0 0 {} {} x {}]} {
				>
					emit {\b.%d,}
				<
			}
	
			if {[S string 560 0 {} {} x {}]} {
				>
					emit {label: %.64s,}
				<
			}
	
			if {[S string 136 0 {} {} x {}]} {
				>
					emit {mountpoint: %.128s}
				<
			}
	
		<
	}
	
	if {[S string 32 0 {} {} eq ORCLDISK]} {
		>
			emit {Oracle ASM Volume,}
			if {[S string 40 0 {} {} x {}]} {
				>
					emit {Disk Name: %0.12s}
				<
			}
	
		<
	}
	
	if {[S string 32 0 {} {} eq ORCLCLRD]} {
		>
			emit {Oracle ASM Volume (cleared),}
			if {[S string 40 0 {} {} x {}]} {
				>
					emit {Disk Name: %0.12s}
				<
			}
	
		<
	}
	
	if {[S string 8 0 {} {} eq OracleCFS]} {
		>
			emit {Oracle Clustered Filesystem,}
			if {[N long 4 0 0 {} {} x {}]} {
				>
					emit {rev %d}
				<
			}
	
			if {[N long 0 0 0 {} {} x {}]} {
				>
					emit {\b.%d,}
				<
			}
	
			if {[S string 560 0 {} {} x {}]} {
				>
					emit {label: %.64s,}
				<
			}
	
			if {[S string 136 0 {} {} x {}]} {
				>
					emit {mountpoint: %.128s}
				<
			}
	
		<
	}
	
	if {[S string 32 0 {} {} eq ORCLDISK]} {
		>
			emit {Oracle ASM Volume,}
			if {[S string 40 0 {} {} x {}]} {
				>
					emit {Disk Name: %0.12s}
				<
			}
	
		<
	}
	
	if {[S string 32 0 {} {} eq ORCLCLRD]} {
		>
			emit {Oracle ASM Volume (cleared),}
			if {[S string 40 0 {} {} x {}]} {
				>
					emit {Disk Name: %0.12s}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq CPQRFBLO]} {
		>
			emit {Compaq/HP RILOE floppy image}
		<
	}
	
	if {[S string 1008 0 {} {} eq DECFILE11]} {
		>
			emit {Files-11 On-Disk Structure}
			if {[N byte 525 0 0 {} {} x {}]} {
				>
					emit {(ODS-%d);}
				<
			}
	
			if {[S string 1017 0 {} {} eq A]} {
				>
					emit {RSX-11, VAX/VMS or OpenVMS VAX file system;}
				<
			}
	
			if {[S string 1017 0 {} {} eq B]} {
				>
					switch [Nv byte 525 0 {} {}] {
						2 {
							>
								emit {VAX/VMS or OpenVMS file system;}
							<
						}
						5 {
							>
								emit {OpenVMS Alpha or Itanium file system;}
							<
						}
					}
	
				<
			}
	
			if {[S string 984 0 {} {} x {}]} {
				>
					emit {volume label is '%-12.12s'}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq DAA\x0\x0\x0\x0\x0]} {
		>
			emit {PowerISO Direct-Access-Archive}
		<
	}
	
	if {[S string 0 0 {} {} eq \1\0\0\0\0\0\0\300\0\2\0\0]} {
		>
			emit {Marvell Libertas firmware}
		<
	}
	
	if {[N belong 65536 0 0 {} {} == 18225520]} {
		>
			switch [Nv belong 65560 0 {} {}] {
				1309 {
					>
						emit {GFS1 Filesystem}
						if {[N belong 65572 0 0 {} {} x {}]} {
							>
								emit {(blocksize %d,}
							<
						}
	
						if {[S string 65632 0 {} {} > \0]} {
							>
								emit {lockproto %s)}
							<
						}
	
					<
				}
				1801 {
					>
						emit {GFS2 Filesystem}
						if {[N belong 65572 0 0 {} {} x {}]} {
							>
								emit {(blocksize %d,}
							<
						}
	
						if {[S string 65632 0 {} {} > \0]} {
							>
								emit {lockproto %s)}
							<
						}
	
					<
				}
			}
	
		<
	}
	
	if {[S string 65600 0 {} {} eq _BHRfS_M]} {
		>
			emit {BTRFS Filesystem}
			if {[S string 65835 0 {} {} > \0]} {
				>
					emit {label "%s",}
				<
			}
	
			if {[N lelong 65680 0 0 {} {} x {}]} {
				>
					emit {sectorsize %d,}
				<
			}
	
			if {[N lelong 65684 0 0 {} {} x {}]} {
				>
					emit {nodesize %d,}
				<
			}
	
			if {[N lelong 65688 0 0 {} {} x {}]} {
				>
					emit {leafsize %d,}
				<
			}
	
			if {[N belong 65568 0 0 {} {} x {}]} {
				>
					emit UUID=%08x-
				<
			}
	
			if {[N beshort 65572 0 0 {} {} x {}]} {
				>
					emit {\b%04x-}
				<
			}
	
			if {[N beshort 65574 0 0 {} {} x {}]} {
				>
					emit {\b%04x-}
				<
			}
	
			if {[N beshort 65576 0 0 {} {} x {}]} {
				>
					emit {\b%04x-}
				<
			}
	
			if {[N beshort 65578 0 0 {} {} x {}]} {
				>
					emit {\b%04x}
				<
			}
	
			if {[N belong 65580 0 0 {} {} x {}]} {
				>
					emit {\b%08x,}
				<
			}
	
			if {[N lequad 65656 0 0 {} {} x {}]} {
				>
					emit %lld/
				<
			}
	
			if {[N lequad 65648 0 0 {} {} x {}]} {
				>
					emit {\b%lld bytes used,}
				<
			}
	
			if {[N lequad 65672 0 0 {} {} x {}]} {
				>
					emit {%lld devices}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq *dvdisaster*]} {
		>
			emit {dvdisaster error correction file}
		<
	}
	
	if {[S string 0 0 {} {} eq XFSM]} {
		>
			if {[S string 512 0 {} {} eq XFSB]} {
				>
					emit {XFS filesystem metadump image}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq CROMFS]} {
		>
			emit CROMFS
			if {[S string 6 0 {} {} > \0]} {
				>
					emit {\b version %2.2s,}
				<
			}
	
			if {[N ulequad 8 0 0 {} {} > 0]} {
				>
					emit {\b block data at %lld,}
				<
			}
	
			if {[N ulequad 16 0 0 {} {} > 0]} {
				>
					emit {\b fblock table at %lld,}
				<
			}
	
			if {[N ulequad 24 0 0 {} {} > 0]} {
				>
					emit {\b inode table at %lld,}
				<
			}
	
			if {[N ulequad 32 0 0 {} {} > 0]} {
				>
					emit {\b root at %lld,}
				<
			}
	
			if {[N ulelong 40 0 0 {} {} > 0]} {
				>
					emit {\b fblock size = %d,}
				<
			}
	
			if {[N ulelong 44 0 0 {} {} > 0]} {
				>
					emit {\b block size = %d,}
				<
			}
	
			if {[N ulequad 48 0 0 {} {} > 0]} {
				>
					emit {\b bytes = %lld}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq XFSM]} {
		>
			if {[S string 512 0 {} {} eq XFSB]} {
				>
					emit {XFS filesystem metadump image}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq DISO]} {
		>
			emit {Delta ISO data,}
			if {[N belong 4 0 0 {} {} x {}]} {
				>
					emit {version %d}
				<
			}
	
		<
	}
	
	if {[S string 32768 0 {} {} eq JFS1]} {
		>
			if {[N lelong [R 0] 0 0 {} {} < 3]} {
				>
					emit {JFS2 filesystem image}
					if {[S regex [R 144] 0 {} {} eq \[\x20-\x7E\]\{1,16\}]} {
						>
							emit {(label "%s")}
						<
					}
	
					if {[N lequad [R 0] 0 0 {} {} x {}]} {
						>
							emit {\b, %lld blocks}
						<
					}
	
					if {[N lelong [R 8] 0 0 {} {} x {}]} {
						>
							emit {\b, blocksize %d}
						<
					}
	
					if {[N lelong [R 32] 0 0 & 6 > 0]} {
						>
							emit (dirty)
						<
					}
	
					if {[N lelong [R 36] 0 0 {} {} > 0]} {
						>
							emit (compressed)
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq td\000]} {
		>
			emit {floppy image data (TeleDisk, compressed)}
		<
	}
	
	if {[S string 0 0 {} {} eq TD\000]} {
		>
			emit {floppy image data (TeleDisk)}
		<
	}
	
	if {[S string 0 0 {} {} eq CQ\024]} {
		>
			emit {floppy image data (CopyQM,}
			if {[N leshort 16 0 0 {} {} x {}]} {
				>
					emit {%d sectors,}
				<
			}
	
			if {[N leshort 18 0 0 {} {} x {}]} {
				>
					emit {%d heads.)}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq ACT\020Apricot\020disk\020image\032\004]} {
		>
			emit {floppy image data (ApriDisk)}
		<
	}
	
	if {[S string 0 0 {} {} eq \074CPM_Disk\076]} {
		>
			emit {disk image data (YAZE)}
		<
	}
	
	if {[S string 0 0 {} {} eq \0\0\0ReFS\0]} {
		>
			emit {ReFS filesystem image}
		<
	}
	
	if {[S string 0 0 {} {} eq EVF\x09\x0d\x0a\xff\x00]} {
		>
			emit {EWF/Expert Witness/EnCase image file format}
		<
	}
	
	switch [Nv ulelong 32 0 & 4294967039] {
		672 {
			>
				if {[S string 16 0 {} {} eq \0\0\0\0\0\0\0\0\0\0]} {
					>
						if {[S string 640 0 {} {} eq \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0]} {
							>
								if {[N ubyte 26 0 0 & 239 == 0]} {
									>
										if {[N ubyte 27 0 0 & 143 == 0]} {
											>
												if {[N ubyte 27 0 0 & 70 < 64]} {
													>
														if {[N ulelong 28 0 0 {} {} > 33]} {
															>
																if {[S regex 0 0 {} {} eq \[\[:print:\]\]*]} {
																	>
																		emit {NEC PC-88 disk image, name=%s}
																		switch [Nv ubyte 27 0 {} {}] {
																			0 {
																				>
																					emit {\b, media=2D}
																				<
																			}
																			16 {
																				>
																					emit {\b, media=2DD}
																				<
																			}
																			32 {
																				>
																					emit {\b, media=2HD}
																				<
																			}
																			48 {
																				>
																					emit {\b, media=1D}
																				<
																			}
																			64 {
																				>
																					emit {\b, media=1DD}
																				<
																			}
																		}
	
																		if {[N ubyte 26 0 0 {} {} == 16]} {
																			>
																				emit {\b, write-protected}
																			<
																		}
	
																	<
																}
	
															<
														}
	
													<
												}
	
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
			<
			>
				if {[S string 16 0 {} {} eq \0\0\0\0\0\0\0\0\0\0]} {
					>
						if {[S string 640 0 {} {} eq \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0]} {
							>
								if {[N ubyte 26 0 0 & 239 == 0]} {
									>
										if {[N ubyte 27 0 0 & 143 == 0]} {
											>
												if {[N ubyte 27 0 0 & 70 < 64]} {
													>
														if {[N ulelong 28 0 0 {} {} > 33]} {
															>
																if {[S regex 0 0 {} {} eq \[\[:print:\]\]*]} {
																	>
																		emit {NEC PC-88 disk image, name=%s}
																		switch [Nv ubyte 27 0 {} {}] {
																			0 {
																				>
																					emit {\b, media=2D}
																				<
																			}
																			16 {
																				>
																					emit {\b, media=2DD}
																				<
																			}
																			32 {
																				>
																					emit {\b, media=2HD}
																				<
																			}
																			48 {
																				>
																					emit {\b, media=1D}
																				<
																			}
																			64 {
																				>
																					emit {\b, media=1DD}
																				<
																			}
																		}
	
																		if {[N ubyte 26 0 0 {} {} == 16]} {
																			>
																				emit {\b, write-protected}
																			<
																		}
	
																	<
																}
	
															<
														}
	
													<
												}
	
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
	
			<
		}
	}
	
	if {[S pstring 0 0 {} {} eq HDD\ Raw\ Copy\ Tool]} {
		>
			emit %s
			if {[S pstring 256 0 {} {} x {}]} {
				>
					emit %s
				<
			}
	
			if {[S pstring 512 0 {} {} x {}]} {
				>
					emit {- HD model: %s}
				<
			}
	
			if {[S pstring 1024 0 {} {} x {}]} {
				>
					emit {serial: %s}
					ext imgc
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq FP1]} {
		>
			emit {libfprint fingerprint data V1}
			if {[N beshort 3 0 0 {} {} x {}]} {
				>
					emit {\b, driver_id %x}
				<
			}
	
			if {[N belong 5 0 0 {} {} x {}]} {
				>
					emit {\b, devtype %x}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq FP2]} {
		>
			emit {libfprint fingerprint data V2}
			if {[N beshort 3 0 0 {} {} x {}]} {
				>
					emit {\b, driver_id %x}
				<
			}
	
			if {[N belong 5 0 0 {} {} x {}]} {
				>
					emit {\b, devtype %x}
				<
			}
	
		<
	}
	
	if {[S string 1 0 {} {} eq WS]} {
		>
			if {[N ulelong 4 0 0 {} {} > 14]} {
				>
					if {[N ubyte 3 0 0 {} {} != 0]} {
						>
							U 81 swf-details 0
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq FLV\x01]} {
		>
			emit {Macromedia Flash Video}
			mime video/x-flv
		<
	}
	
	if {[S string 0 0 {} {} eq AGD2\xbe\xb8\xbb\xcd\x00]} {
		>
			emit {Macromedia Freehand 7 Document}
		<
	}
	
	if {[S string 0 0 {} {} eq AGD3\xbe\xb8\xbb\xcc\x00]} {
		>
			emit {Macromedia Freehand 8 Document}
		<
	}
	
	if {[S string 0 0 {} {} eq AGD4\xbe\xb8\xbb\xcb\x00]} {
		>
			emit {Macromedia Freehand 9 Document}
		<
	}
	
	if {[S string 0 0 {} {} eq FLIF]} {
		>
			emit FLIF
			if {[S string 4 0 {} {} < H]} {
				>
					emit {image data}
					if {[N beshort 6 0 0 {} {} x {}]} {
						>
							emit {\b, %u}
						<
					}
	
					if {[N beshort 8 0 0 {} {} x {}]} {
						>
							emit {\bx%u}
						<
					}
	
					if {[S string 5 0 {} {} eq 1]} {
						>
							emit {\b, 8-bit/color,}
						<
					}
	
					if {[S string 5 0 {} {} eq 2]} {
						>
							emit {\b, 16-bit/color,}
						<
					}
	
					if {[S string 4 0 {} {} eq 1]} {
						>
							emit {\b, grayscale, non-interlaced}
						<
					}
	
					if {[S string 4 0 {} {} eq 3]} {
						>
							emit {\b, RGB, non-interlaced}
						<
					}
	
					if {[S string 4 0 {} {} eq 4]} {
						>
							emit {\b, RGBA, non-interlaced}
						<
					}
	
					if {[S string 4 0 {} {} eq A]} {
						>
							emit {\b, grayscale}
						<
					}
	
					if {[S string 4 0 {} {} eq C]} {
						>
							emit {\b, RGB, interlaced}
						<
					}
	
					if {[S string 4 0 {} {} eq D]} {
						>
							emit {\b, RGBA, interlaced}
						<
					}
	
				<
			}
	
			if {[S string 4 0 {} {} > H]} {
				>
					emit {\b, animation data}
					if {[N ubyte 5 0 0 {} {} < 255]} {
						>
							emit {\b, %i frames}
							if {[N beshort 7 0 0 {} {} x {}]} {
								>
									emit {\b, %u}
								<
							}
	
							if {[N beshort 9 0 0 {} {} x {}]} {
								>
									emit {\bx%u}
								<
							}
	
							if {[S string 6 0 {} {} eq 1]} {
								>
									emit {\b, 8-bit/color}
								<
							}
	
							if {[S string 6 0 {} {} eq 2]} {
								>
									emit {\b, 16-bit/color}
								<
							}
	
						<
					}
	
					if {[N ubyte 5 0 0 {} {} == 255]} {
						>
							if {[N beshort 6 0 0 {} {} x {}]} {
								>
									emit {\b, %i frames,}
								<
							}
	
							if {[N beshort 9 0 0 {} {} x {}]} {
								>
									emit {\b, %u}
								<
							}
	
							if {[N beshort 11 0 0 {} {} x {}]} {
								>
									emit {\bx%u}
								<
							}
	
							if {[S string 8 0 {} {} eq 1]} {
								>
									emit {\b, 8-bit/color}
								<
							}
	
							if {[S string 8 0 {} {} eq 2]} {
								>
									emit {\b, 16-bit/color}
								<
							}
	
						<
					}
	
					if {[S string 4 0 {} {} eq Q]} {
						>
							emit {\b, grayscale, non-interlaced}
						<
					}
	
					if {[S string 4 0 {} {} eq S]} {
						>
							emit {\b, RGB, non-interlaced}
						<
					}
	
					if {[S string 4 0 {} {} eq T]} {
						>
							emit {\b, RGBA, non-interlaced}
						<
					}
	
					if {[S string 4 0 {} {} eq a]} {
						>
							emit {\b, grayscale}
						<
					}
	
					if {[S string 4 0 {} {} eq c]} {
						>
							emit {\b, RGB, interlaced}
						<
					}
	
					if {[S string 4 0 {} {} eq d]} {
						>
							emit {\b, RGBA, interlaced}
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S search 0 0 {} 1 eq FONT]} {
		>
			emit {ASCII vfont text}
		<
	}
	
	if {[S string 0 0 {} {} eq %!PS-AdobeFont-1.]} {
		>
			emit {PostScript Type 1 font text}
			if {[S string 20 0 {} {} > \0]} {
				>
					emit (%s)
				<
			}
	
		<
	}
	
	if {[S string 6 0 {} {} eq %!PS-AdobeFont-1.]} {
		>
			emit {PostScript Type 1 font program data}
		<
	}
	
	if {[S string 0 0 {} {} eq %!FontType1]} {
		>
			emit {PostScript Type 1 font program data}
		<
	}
	
	if {[S string 6 0 {} {} eq %!FontType1]} {
		>
			emit {PostScript Type 1 font program data}
		<
	}
	
	if {[S string 0 0 {} {} eq %!PS-Adobe-3.0\ Resource-Font]} {
		>
			emit {PostScript Type 1 font text}
		<
	}
	
	if {[N uleshort 0 0 0 {} {} == 256]} {
		>
			if {[N uleshort 66 0 0 {} {} == 129]} {
				>
					if {[S string [I 101 ulelong 0 + 0 0] 0 c {} eq Postscript]} {
						>
							emit {Printer Font Metrics}
							if {[N ulelong 139 0 0 {} {} > 0]} {
								>
									if {[S string [I 139 ulelong 0 + 0 0] 0 {} {} x {}]} {
										>
											emit %s
										<
									}
	
								<
							}
	
							if {[N ulelong 2 0 0 {} {} x {}]} {
								>
									emit {\b, %d bytes}
								<
							}
	
							if {[N ulelong 105 0 0 {} {} > 0]} {
								>
									if {[S string [I 105 ulelong 0 + 0 0] 0 {} {} x {}]} {
										>
											emit {\b, %s}
										<
									}
	
								<
							}
	
							if {[N ubyte 80 0 0 {} {} == 1]} {
								>
									emit italic
								<
							}
	
							if {[N ubyte 81 0 0 {} {} == 1]} {
								>
									emit underline
								<
							}
	
							if {[N ubyte 82 0 0 {} {} == 1]} {
								>
									emit strikeout
								<
							}
	
							if {[N uleshort 83 0 0 {} {} > 699]} {
								>
									emit bold
								<
							}
	
							switch [Nv ubyte 90 0 {} {}] {
								16 {
									>
										emit serif
									<
								}
								17 {
									>
										emit {serif proportional}
									<
								}
								49 {
									>
										emit proportional
									<
								}
								64 {
									>
										emit script
									<
								}
								65 {
									>
										emit {script proportional}
									<
								}
							}
	
							mime application/x-font-pfm
							ext pfm
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S search 0 0 {} 1 eq STARTFONT\ ]} {
		>
			emit {X11 BDF font text}
		<
	}
	
	if {[S string 0 0 {} {} eq FILE]} {
		>
			if {[S string 8 0 {} {} eq PFF2]} {
				>
					if {[N ubelong 4 0 0 {} {} == 4]} {
						>
							if {[S string 12 0 {} {} eq NAME]} {
								>
									emit {GRUB2 font}
									if {[N ubelong 16 0 0 {} {} > 0]} {
										>
											if {[S string 20 0 {} {} > \0]} {
												>
													emit {"%-s"}
												<
											}
	
										<
									}
	
									mime application/x-font-pf2
									ext pf2
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \001fcp]} {
		>
			emit {X11 Portable Compiled Font data,}
			if {[N lelong 12 0 0 {} {} ^ 8]} {
				>
					emit {bit: LSB,}
				<
			}
	
			if {[N lelong 12 0 0 {} {} & 8]} {
				>
					emit {bit: MSB,}
				<
			}
	
			if {[N lelong 12 0 0 {} {} ^ 4]} {
				>
					emit {byte: LSB first}
				<
			}
	
			if {[N lelong 12 0 0 {} {} & 4]} {
				>
					emit {byte: MSB first}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq D1.0\015]} {
		>
			emit {X11 Speedo font data}
		<
	}
	
	if {[S string 0 0 {} {} eq flf]} {
		>
			emit {FIGlet font}
			if {[S string 3 0 {} {} > 2a]} {
				>
					emit {version %-2.2s}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq flc]} {
		>
			emit {FIGlet controlfile}
			if {[S string 3 0 {} {} > 2a]} {
				>
					emit {version %-2.2s}
				<
			}
	
		<
	}
	
	switch [Nv belong 7 0 {} {}] {
		4540225 {
			>
				emit {DOS code page font data}
			<
		}
		5654852 {
			>
				emit {DOS code page font data (from Linux?)}
			<
		}
	}
	
	if {[S string 4098 0 {} {} eq DOSFONT]} {
		>
			emit {DOSFONT2 encrypted font data}
		<
	}
	
	if {[S string 0 0 {} {} eq PFR1]} {
		>
			emit {Portable Font Resource font data (new)}
			if {[S string 102 0 {} {} > 0]} {
				>
					emit {\b: %s}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq PFR0]} {
		>
			emit {Portable Font Resource font data (old)}
			if {[N beshort 4 0 0 {} {} > 0]} {
				>
					emit {version %d}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq typ1]} {
		>
			U 83 sfnt-font 0
	
			U 83 sfnt-names 0
	
		<
	}
	
	if {[S string 0 0 {} {} eq true]} {
		>
			U 83 sfnt-font 0
	
			U 83 sfnt-names 0
	
		<
	}
	
	if {[S string 0 0 {} {} eq \000\001\000\000]} {
		>
			U 83 sfnt-font 0
	
			U 83 sfnt-names 0
	
		<
	}
	
	if {[S string 0 0 {} {} eq \007\001\001\000Copyright\ (c)\ 199]} {
		>
			emit {Adobe Multiple Master font}
		<
	}
	
	if {[S string 0 0 {} {} eq \012\001\001\000Copyright\ (c)\ 199]} {
		>
			emit {Adobe Multiple Master font}
		<
	}
	
	if {[S string 0 0 {} {} eq ttcf]} {
		>
			if {[N ubyte 4 0 0 {} {} == 0]} {
				>
					if {[N ubelong [I 12 ubelong 0 + 0 0] 0 0 {} {} != 1330926671]} {
						>
							emit TrueType
							ext ttc
						<
					}
	
					if {[N ubelong [I 12 ubelong 0 + 0 0] 0 0 {} {} == 1330926671]} {
						>
							emit OpenType
							ext ttc/otc
						<
					}
	
					if {[N ubyte 4 0 0 {} {} x {}]} {
						>
							emit {font collection data}
							mime application/font-sfnt
						<
					}
	
					switch [Nv belong 4 0 {} {}] {
						65536 {
							>
								emit {\b, 1.0}
							<
						}
						131072 {
							>
								emit {\b, 2.0}
							<
						}
					}
	
					if {[N ubelong 8 0 0 {} {} > 0]} {
						>
							emit {\b, %d fonts}
						<
					}
	
					if {[N ubequad [I 8 ubelong 0 * 0 4] 0 0 {} {} x {}]} {
						>
							if {[N belong [R 4] 0 0 {} {} == 1146308935]} {
								>
									emit {\b, digitally signed}
								<
							}
	
						<
					}
	
					if {[N ubelong 12 0 0 {} {} x {}]} {
						>
							emit {\b, at 0x%x}
						<
					}
	
					U 83 sfnt-font [I 12 ubelong 0 + 0 0]
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq OTTO]} {
		>
			emit {OpenType font data}
			mime application/vnd.ms-opentype
		<
	}
	
	if {[S string 0 0 {} {} eq SplineFontDB:]} {
		>
			emit {Spline Font Database}
			if {[S string 14 0 {} {} x {}]} {
				>
					emit {version %s}
				<
			}
	
			mime application/vnd.font-fontforge-sfd
		<
	}
	
	if {[S string 64 0 {} {} eq \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0]} {
		>
			if {[S string 34 0 {} {} eq LP]} {
				>
					emit {Embedded OpenType (EOT)}
					if {[N short 82 0 0 {} {} != 0]} {
						>
							if {[S lestring16 84 0 {} {} x {}]} {
								>
									emit {\b, %s family}
									mime application/vnd.ms-fontobject
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq wOFF]} {
		>
			emit {Web Open Font Format}
			U 83 woff 0
	
			if {[N beshort 20 0 0 {} {} x {}]} {
				>
					emit {\b, version %d}
				<
			}
	
			if {[N beshort 22 0 0 {} {} x {}]} {
				>
					emit {\b.%d}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq wOF2]} {
		>
			emit {Web Open Font Format (Version 2)}
			U 83 woff 0
	
			if {[N beshort 24 0 0 {} {} x {}]} {
				>
					emit {\b, version %d}
				<
			}
	
			if {[N beshort 26 0 0 {} {} x {}]} {
				>
					emit {\b.%d}
				<
			}
	
		<
	}
	
	if {[S regex 0 0 l 100 ne ^\[^Cc\ \t\].*\$]} {
		>
			if {[S regex 0 0 l 100 eq ^\[Cc\]\[\ \t\]]} {
				>
					emit {FORTRAN program text}
					mime text/x-fortran
					strength {- 5}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq <MakerFile]} {
		>
			emit {FrameMaker document}
			if {[S string 11 0 {} {} eq 5.5]} {
				>
					emit (5.5
				<
			}
	
			if {[S string 11 0 {} {} eq 5.0]} {
				>
					emit (5.0
				<
			}
	
			if {[S string 11 0 {} {} eq 4.0]} {
				>
					emit (4.0
				<
			}
	
			if {[S string 11 0 {} {} eq 3.0]} {
				>
					emit (3.0
				<
			}
	
			if {[S string 11 0 {} {} eq 2.0]} {
				>
					emit (2.0
				<
			}
	
			if {[S string 11 0 {} {} eq 1.0]} {
				>
					emit (1.0
				<
			}
	
			if {[N byte 14 0 0 {} {} x {}]} {
				>
					emit %c)
				<
			}
	
			mime application/x-mif
		<
	}
	
	if {[S string 0 0 {} {} eq <MIFFile]} {
		>
			emit {FrameMaker MIF (ASCII) file}
			if {[S string 9 0 {} {} eq 4.0]} {
				>
					emit (4.0)
				<
			}
	
			if {[S string 9 0 {} {} eq 3.0]} {
				>
					emit (3.0)
				<
			}
	
			if {[S string 9 0 {} {} eq 2.0]} {
				>
					emit (2.0)
				<
			}
	
			if {[S string 9 0 {} {} eq 1.0]} {
				>
					emit (1.x)
				<
			}
	
			mime application/x-mif
		<
	}
	
	if {[S search 0 0 {} 1 eq <MakerDictionary]} {
		>
			emit {FrameMaker Dictionary text}
			if {[S string 17 0 {} {} eq 3.0]} {
				>
					emit (3.0)
				<
			}
	
			if {[S string 17 0 {} {} eq 2.0]} {
				>
					emit (2.0)
				<
			}
	
			if {[S string 17 0 {} {} eq 1.0]} {
				>
					emit (1.x)
				<
			}
	
			mime application/x-mif
		<
	}
	
	if {[S string 0 0 {} {} eq <MakerScreenFont]} {
		>
			emit {FrameMaker Font file}
			if {[S string 17 0 {} {} eq 1.01]} {
				>
					emit (%s)
				<
			}
	
			mime application/x-mif
		<
	}
	
	if {[S string 0 0 {} {} eq <MML]} {
		>
			emit {FrameMaker MML file}
			mime application/x-mif
		<
	}
	
	if {[S string 0 0 {} {} eq <BookFile]} {
		>
			emit {FrameMaker Book file}
			if {[S string 10 0 {} {} eq 3.0]} {
				>
					emit (3.0
				<
			}
	
			if {[S string 10 0 {} {} eq 2.0]} {
				>
					emit (2.0
				<
			}
	
			if {[S string 10 0 {} {} eq 1.0]} {
				>
					emit (1.0
				<
			}
	
			if {[N byte 13 0 0 {} {} x {}]} {
				>
					emit %c)
				<
			}
	
			mime application/x-mif
		<
	}
	
	if {[S string 0 0 {} {} eq <Maker\040Intermediate\040Print\040File]} {
		>
			emit {FrameMaker IPL file}
			mime application/x-mif
		<
	}
	
	switch [Nv lelong 0 0 & 67108863] {
		8782028 {
			>
				emit {FreeBSD/i386 compact demand paged}
				if {[N lelong 20 0 0 {} {} < 4096]} {
					>
						if {[N byte 3 0 0 & -64 & -128]} {
							>
								emit {shared library}
							<
						}
	
						switch [Nv byte 3 0 & -64] {
							0 {
								>
									emit object
								<
							}
							64 {
								>
									emit {PIC object}
								<
							}
						}
	
					<
				}
	
				if {[N lelong 20 0 0 {} {} > 4095]} {
					>
						switch [Nv byte 3 0 & -128] {
							-128 {
								>
									emit {dynamically linked executable}
								<
							}
							0 {
								>
									emit executable
								<
							}
						}
	
					<
				}
	
				if {[N lelong 16 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		8782087 {
			>
				emit FreeBSD/i386
				if {[N lelong 20 0 0 {} {} < 4096]} {
					>
						if {[N byte 3 0 0 & -64 & -128]} {
							>
								emit {shared library}
							<
						}
	
						switch [Nv byte 3 0 & -64] {
							0 {
								>
									emit object
								<
							}
							64 {
								>
									emit {PIC object}
								<
							}
						}
	
					<
				}
	
				if {[N lelong 20 0 0 {} {} > 4095]} {
					>
						switch [Nv byte 3 0 & -128] {
							-128 {
								>
									emit {dynamically linked executable}
								<
							}
							0 {
								>
									emit executable
								<
							}
						}
	
					<
				}
	
				if {[N lelong 16 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		8782088 {
			>
				emit {FreeBSD/i386 pure}
				if {[N lelong 20 0 0 {} {} < 4096]} {
					>
						if {[N byte 3 0 0 & -64 & -128]} {
							>
								emit {shared library}
							<
						}
	
						switch [Nv byte 3 0 & -64] {
							0 {
								>
									emit object
								<
							}
							64 {
								>
									emit {PIC object}
								<
							}
						}
	
					<
				}
	
				if {[N lelong 20 0 0 {} {} > 4095]} {
					>
						switch [Nv byte 3 0 & -128] {
							-128 {
								>
									emit {dynamically linked executable}
								<
							}
							0 {
								>
									emit executable
								<
							}
						}
	
					<
				}
	
				if {[N lelong 16 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
		8782091 {
			>
				emit {FreeBSD/i386 demand paged}
				if {[N lelong 20 0 0 {} {} < 4096]} {
					>
						if {[N byte 3 0 0 & -64 & -128]} {
							>
								emit {shared library}
							<
						}
	
						switch [Nv byte 3 0 & -64] {
							0 {
								>
									emit object
								<
							}
							64 {
								>
									emit {PIC object}
								<
							}
						}
	
					<
				}
	
				if {[N lelong 20 0 0 {} {} > 4095]} {
					>
						switch [Nv byte 3 0 & -128] {
							-128 {
								>
									emit {dynamically linked executable}
								<
							}
							0 {
								>
									emit executable
								<
							}
						}
	
					<
				}
	
				if {[N lelong 16 0 0 {} {} > 0]} {
					>
						emit {not stripped}
					<
				}
	
			<
		}
	}
	
	if {[S string 7 0 {} {} eq \357\020\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0]} {
		>
			emit {FreeBSD/i386 a.out core file}
			if {[S string 1039 0 {} {} > \0]} {
				>
					emit {from '%s'}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq SCRSHOT_]} {
		>
			emit {scrshot(1) screenshot,}
			if {[N byte 8 0 0 {} {} x {}]} {
				>
					emit {version %d,}
				<
			}
	
			if {[N byte 9 0 0 {} {} == 2]} {
				>
					emit {%d bytes in header,}
					if {[N byte 10 0 0 {} {} x {}]} {
						>
							emit {%d chars wide by}
						<
					}
	
					if {[N byte 11 0 0 {} {} x {}]} {
						>
							emit {%d chars high}
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq ClamAV-VDB:]} {
		>
			if {[S string 11 0 {} {} > \0]} {
				>
					emit {Clam AntiVirus database %-.23s}
					if {[S string 34 0 {} {} eq :]} {
						>
							if {[S string 35 0 {} {} ne :]} {
								>
									emit {\b, version}
									if {[S string 35 0 {} {} x {}]} {
										>
											emit {\b %-.1s}
											if {[S string 36 0 {} {} ne :]} {
												>
													if {[S string 36 0 {} {} x {}]} {
														>
															emit {\b%-.1s}
															if {[S string 37 0 {} {} ne :]} {
																>
																	if {[S string 37 0 {} {} x {}]} {
																		>
																			emit {\b%-.1s}
																			if {[S string 38 0 {} {} ne :]} {
																				>
																					if {[S string 38 0 {} {} x {}]} {
																						>
																							emit {\b%-.1s}
																							if {[S string 39 0 {} {} ne :]} {
																								>
																									if {[S string 39 0 {} {} x {}]} {
																										>
																											emit {\b%-.1s}
																										<
																									}
	
																								<
																							}
	
																						<
																					}
	
																				<
																			}
	
																		<
																	}
	
																<
															}
	
														<
													}
	
												<
											}
	
										<
									}
	
								<
							}
	
						<
					}
	
				<
			}
	
			if {[S string 512 0 {} {} eq \037\213]} {
				>
					emit {\b, gzipped}
				<
			}
	
			if {[S string 769 0 {} {} eq ustar\0]} {
				>
					emit {\b, tarred}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq AVG7_ANTIVIRUS_VAULT_FILE]} {
		>
			emit {AVG 7 Antivirus vault file data}
		<
	}
	
	if {[S string 0 0 {} {} eq X5O!P%@AP\[4\\PZX54(P^)7CC)7\}\$EICAR]} {
		>
			if {[S string 33 0 {} {} eq -STANDARD-ANTIVIRUS-TEST-FILE!\$H+H*]} {
				>
					emit {EICAR virus test files}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \037\135\211]} {
		>
			emit {FuseCompress(ed) data}
			switch [Nv byte 3 0 {} {}] {
				0 {
					>
						emit {(none format)}
					<
				}
				1 {
					>
						emit {(bz2 format)}
					<
				}
				2 {
					>
						emit {(gz format)}
					<
				}
				3 {
					>
						emit {(lzo format)}
					<
				}
				4 {
					>
						emit {(xor format)}
					<
				}
			}
	
			if {[N byte 3 0 0 {} {} > 4]} {
				>
					emit {(unknown format)}
				<
			}
	
			if {[N long 4 0 0 {} {} x {}]} {
				>
					emit {uncompressed size: %d}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq IDP2]} {
		>
			emit {Quake II 3D Model file,}
			if {[N long 20 0 0 {} {} x {}]} {
				>
					emit {%u skin(s),}
				<
			}
	
			if {[N long 8 0 0 {} {} x {}]} {
				>
					emit {(%u x}
				<
			}
	
			if {[N long 12 0 0 {} {} x {}]} {
				>
					emit %u),
				<
			}
	
			if {[N long 40 0 0 {} {} x {}]} {
				>
					emit {%u frame(s),}
				<
			}
	
			if {[N long 16 0 0 {} {} x {}]} {
				>
					emit {Frame size %u bytes,}
				<
			}
	
			if {[N long 24 0 0 {} {} x {}]} {
				>
					emit {%u vertices/frame,}
				<
			}
	
			if {[N long 28 0 0 {} {} x {}]} {
				>
					emit {%u texture coordinates,}
				<
			}
	
			if {[N long 32 0 0 {} {} x {}]} {
				>
					emit {%u triangles/frame}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq IBSP]} {
		>
			emit Quake
			switch [Nv long 4 0 {} {}] {
				38 {
					>
						emit {II Map file (BSP)}
					<
				}
				46 {
					>
						emit {III Map file (BSP)}
					<
				}
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq IDS2]} {
		>
			emit {Quake II SP2 sprite file}
		<
	}
	
	if {[S string 0 0 {} {} eq \xcb\x1dBoom\xe6\xff\x03\x01]} {
		>
			emit {Boom or linuxdoom demo}
		<
	}
	
	if {[S string 24 0 {} {} eq LxD\ 203]} {
		>
			emit {Linuxdoom save}
			if {[S string 0 0 {} {} x {}]} {
				>
					emit {, name=%s}
				<
			}
	
			if {[S string 44 0 {} {} x {}]} {
				>
					emit {, world=%s}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq PACK]} {
		>
			if {[N ulelong 8 0 0 {} {} < 16777216]} {
				>
					if {[N ubyte [I 4 ulelong 0 + 0 55] 0 0 {} {} == 0]} {
						>
							emit {Quake I or II world or extension}
							if {[N ulelong 8 0 0 / 64 x {}]} {
								>
									emit {\b, %u files}
								<
							}
	
							if {[N ulelong 4 0 0 {} {} x {}]} {
								>
									emit {\b, offset 0x%x}
								<
							}
	
							U 89 pak-entry [I 4 ulelong 0 + 0 0]
	
							mime application/x-dzip
							ext pak
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aIntroduction]} {
		>
			emit {Quake I save: start Introduction}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0athe_Slipgate_Complex]} {
		>
			emit {Quake I save: e1m1 The slipgate complex}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aCastle_of_the_Damned]} {
		>
			emit {Quake I save: e1m2 Castle of the damned}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0athe_Necropolis]} {
		>
			emit {Quake I save: e1m3 The necropolis}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0athe_Grisly_Grotto]} {
		>
			emit {Quake I save: e1m4 The grisly grotto}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aZiggurat_Vertigo]} {
		>
			emit {Quake I save: e1m8 Ziggurat vertigo (secret)}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aGloom_Keep]} {
		>
			emit {Quake I save: e1m5 Gloom keep}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aThe_Door_To_Chthon]} {
		>
			emit {Quake I save: e1m6 The door to Chthon}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aThe_House_of_Chthon]} {
		>
			emit {Quake I save: e1m7 The house of Chthon}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0athe_Installation]} {
		>
			emit {Quake I save: e2m1 The installation}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0athe_Ogre_Citadel]} {
		>
			emit {Quake I save: e2m2 The ogre citadel}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0athe_Crypt_of_Decay]} {
		>
			emit {Quake I save: e2m3 The crypt of decay (dopefish lives!)}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aUnderearth]} {
		>
			emit {Quake I save: e2m7 Underearth (secret)}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0athe_Ebon_Fortress]} {
		>
			emit {Quake I save: e2m4 The ebon fortress}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0athe_Wizard's_Manse]} {
		>
			emit {Quake I save: e2m5 The wizard's manse}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0athe_Dismal_Oubliette]} {
		>
			emit {Quake I save: e2m6 The dismal oubliette}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aTermination_Central]} {
		>
			emit {Quake I save: e3m1 Termination central}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aVaults_of_Zin]} {
		>
			emit {Quake I save: e3m2 Vaults of Zin}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0athe_Tomb_of_Terror]} {
		>
			emit {Quake I save: e3m3 The tomb of terror}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aSatan's_Dark_Delight]} {
		>
			emit {Quake I save: e3m4 Satan's dark delight}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0athe_Haunted_Halls]} {
		>
			emit {Quake I save: e3m7 The haunted halls (secret)}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aWind_Tunnels]} {
		>
			emit {Quake I save: e3m5 Wind tunnels}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aChambers_of_Torment]} {
		>
			emit {Quake I save: e3m6 Chambers of torment}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0athe_Sewage_System]} {
		>
			emit {Quake I save: e4m1 The sewage system}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aThe_Tower_of_Despair]} {
		>
			emit {Quake I save: e4m2 The tower of despair}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aThe_Elder_God_Shrine]} {
		>
			emit {Quake I save: e4m3 The elder god shrine}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0athe_Palace_of_Hate]} {
		>
			emit {Quake I save: e4m4 The palace of hate}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aHell's_Atrium]} {
		>
			emit {Quake I save: e4m5 Hell's atrium}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0athe_Nameless_City]} {
		>
			emit {Quake I save: e4m8 The nameless city (secret)}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aThe_Pain_Maze]} {
		>
			emit {Quake I save: e4m6 The pain maze}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aAzure_Agony]} {
		>
			emit {Quake I save: e4m7 Azure agony}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aShub-Niggurath's_Pit]} {
		>
			emit {Quake I save: end Shub-Niggurath's pit}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aPlace_of_Two_Deaths]} {
		>
			emit {Quake I save: dm1 Place of two deaths}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aClaustrophobopolis]} {
		>
			emit {Quake I save: dm2 Claustrophobopolis}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aThe_Abandoned_Base]} {
		>
			emit {Quake I save: dm3 The abandoned base}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aThe_Bad_Place]} {
		>
			emit {Quake I save: dm4 The bad place}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aThe_Cistern]} {
		>
			emit {Quake I save: dm5 The cistern}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aThe_Dark_Zone]} {
		>
			emit {Quake I save: dm6 The dark zone}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aCommand_HQ]} {
		>
			emit {Quake I save: start Command HQ}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aThe_Pumping_Station]} {
		>
			emit {Quake I save: hip1m1 The pumping station}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aStorage_Facility]} {
		>
			emit {Quake I save: hip1m2 Storage facility}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aMilitary_Complex]} {
		>
			emit {Quake I save: hip1m5 Military complex (secret)}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0athe_Lost_Mine]} {
		>
			emit {Quake I save: hip1m3 The lost mine}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aResearch_Facility]} {
		>
			emit {Quake I save: hip1m4 Research facility}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aAncient_Realms]} {
		>
			emit {Quake I save: hip2m1 Ancient realms}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aThe_Gremlin's_Domain]} {
		>
			emit {Quake I save: hip2m6 The gremlin's domain (secret)}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aThe_Black_Cathedral]} {
		>
			emit {Quake I save: hip2m2 The black cathedral}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aThe_Catacombs]} {
		>
			emit {Quake I save: hip2m3 The catacombs}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0athe_Crypt__]} {
		>
			emit {Quake I save: hip2m4 The crypt}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aMortum's_Keep]} {
		>
			emit {Quake I save: hip2m5 Mortum's keep}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aTur_Torment]} {
		>
			emit {Quake I save: hip3m1 Tur torment}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aPandemonium]} {
		>
			emit {Quake I save: hip3m2 Pandemonium}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aLimbo]} {
		>
			emit {Quake I save: hip3m3 Limbo}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0athe_Edge_of_Oblivion]} {
		>
			emit {Quake I save: hipdm1 The edge of oblivion (secret)}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aThe_Gauntlet]} {
		>
			emit {Quake I save: hip3m4 The gauntlet}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aArmagon's_Lair]} {
		>
			emit {Quake I save: hipend Armagon's lair}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aThe_Academy]} {
		>
			emit {Quake I save: start The academy}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aThe_Lab]} {
		>
			emit {Quake I save: d1 The lab}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aArea_33]} {
		>
			emit {Quake I save: d1b Area 33}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aSECRET_MISSIONS]} {
		>
			emit {Quake I save: d3b Secret missions}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aThe_Hospital]} {
		>
			emit {Quake I save: d10 The hospital (secret)}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aThe_Genetics_Lab]} {
		>
			emit {Quake I save: d11 The genetics lab (secret)}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aBACK_2_MALICE]} {
		>
			emit {Quake I save: d4b Back to Malice}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aArea44]} {
		>
			emit {Quake I save: d1c Area 44}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aTakahiro_Towers]} {
		>
			emit {Quake I save: d2 Takahiro towers}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aA_Rat's_Life]} {
		>
			emit {Quake I save: d3 A rat's life}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aInto_The_Flood]} {
		>
			emit {Quake I save: d4 Into the flood}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aThe_Flood]} {
		>
			emit {Quake I save: d5 The flood}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aNuclear_Plant]} {
		>
			emit {Quake I save: d6 Nuclear plant}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aThe_Incinerator_Plant]} {
		>
			emit {Quake I save: d7 The incinerator plant}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aThe_Foundry]} {
		>
			emit {Quake I save: d7b The foundry}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aThe_Underwater_Base]} {
		>
			emit {Quake I save: d8 The underwater base}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aTakahiro_Base]} {
		>
			emit {Quake I save: d9 Takahiro base}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aTakahiro_Laboratories]} {
		>
			emit {Quake I save: d12 Takahiro laboratories}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aStayin'_Alive]} {
		>
			emit {Quake I save: d13 Stayin' alive}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aB.O.S.S._HQ]} {
		>
			emit {Quake I save: d14 B.O.S.S. HQ}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aSHOWDOWN!]} {
		>
			emit {Quake I save: d15 Showdown!}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aThe_Seventh_Precinct]} {
		>
			emit {Quake I save: ddm1 The seventh precinct}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aSub_Station]} {
		>
			emit {Quake I save: ddm2 Sub station}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aCrazy_Eights!]} {
		>
			emit {Quake I save: ddm3 Crazy eights!}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aEast_Side_Invertationa]} {
		>
			emit {Quake I save: ddm4 East side invertationa}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aSlaughterhouse]} {
		>
			emit {Quake I save: ddm5 Slaughterhouse}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aDOMINO]} {
		>
			emit {Quake I save: ddm6 Domino}
		<
	}
	
	if {[S string 0 0 {} {} eq 5\x0aSANDRA'S_LADDER]} {
		>
			emit {Quake I save: ddm7 Sandra's ladder}
		<
	}
	
	if {[S string 0 0 {} {} eq MComprHD]} {
		>
			emit {MAME CHD compressed hard disk image,}
			if {[N belong 12 0 0 {} {} x {}]} {
				>
					emit {version %u}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq IWAD]} {
		>
			emit {doom main IWAD data}
			if {[N lelong 4 0 0 {} {} x {}]} {
				>
					emit {containing %d lumps}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq PWAD]} {
		>
			emit {doom patch PWAD data}
			if {[N lelong 4 0 0 {} {} x {}]} {
				>
					emit {containing %d lumps}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq KenSilverman]} {
		>
			emit {Build engine group file}
			if {[N lelong 12 0 0 {} {} x {}]} {
				>
					emit {containing %d files}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq Warcraft\ III\ recorded\ game]} {
		>
			emit %s
		<
	}
	
	if {[S string 0 0 {} {} eq HM3W]} {
		>
			emit {Warcraft III map file}
		<
	}
	
	if {[S regex 0 0 {} {} eq \\(\;.*GM\\\[\[0-9\]\{1,2\}\\\]]} {
		>
			emit {Smart Game Format}
			if {[S search 2 0 b 512 eq GM\[]} {
				>
					if {[S string [R 0] 0 {} {} eq 1\]]} {
						>
							emit (Go)
						<
					}
	
					if {[S string [R 0] 0 {} {} eq 2\]]} {
						>
							emit (Othello)
						<
					}
	
					if {[S string [R 0] 0 {} {} eq 3\]]} {
						>
							emit (chess)
						<
					}
	
					if {[S string [R 0] 0 {} {} eq 4\]]} {
						>
							emit (Gomoku+Renju)
						<
					}
	
					if {[S string [R 0] 0 {} {} eq 5\]]} {
						>
							emit {(Nine Men's Morris)}
						<
					}
	
					if {[S string [R 0] 0 {} {} eq 6\]]} {
						>
							emit (Backgammon)
						<
					}
	
					if {[S string [R 0] 0 {} {} eq 7\]]} {
						>
							emit {(Chinese chess)}
						<
					}
	
					if {[S string [R 0] 0 {} {} eq 8\]]} {
						>
							emit (Shogi)
						<
					}
	
					if {[S string [R 0] 0 {} {} eq 9\]]} {
						>
							emit {(Lines of Action)}
						<
					}
	
					if {[S string [R 0] 0 {} {} eq 10\]]} {
						>
							emit (Ataxx)
						<
					}
	
					if {[S string [R 0] 0 {} {} eq 11\]]} {
						>
							emit (Hex)
						<
					}
	
					if {[S string [R 0] 0 {} {} eq 12\]]} {
						>
							emit (Jungle)
						<
					}
	
					if {[S string [R 0] 0 {} {} eq 13\]]} {
						>
							emit (Neutron)
						<
					}
	
					if {[S string [R 0] 0 {} {} eq 14\]]} {
						>
							emit {(Philosopher's Football)}
						<
					}
	
					if {[S string [R 0] 0 {} {} eq 15\]]} {
						>
							emit (Quadrature)
						<
					}
	
					if {[S string [R 0] 0 {} {} eq 16\]]} {
						>
							emit (Trax)
						<
					}
	
					if {[S string [R 0] 0 {} {} eq 17\]]} {
						>
							emit (Tantrix)
						<
					}
	
					if {[S string [R 0] 0 {} {} eq 18\]]} {
						>
							emit (Amazons)
						<
					}
	
					if {[S string [R 0] 0 {} {} eq 19\]]} {
						>
							emit (Octi)
						<
					}
	
					if {[S string [R 0] 0 {} {} eq 20\]]} {
						>
							emit (Gess)
						<
					}
	
					if {[S string [R 0] 0 {} {} eq 21\]]} {
						>
							emit (Twixt)
						<
					}
	
					if {[S string [R 0] 0 {} {} eq 22\]]} {
						>
							emit (Zertz)
						<
					}
	
					if {[S string [R 0] 0 {} {} eq 23\]]} {
						>
							emit (Plateau)
						<
					}
	
					if {[S string [R 0] 0 {} {} eq 24\]]} {
						>
							emit (Yinsh)
						<
					}
	
					if {[S string [R 0] 0 {} {} eq 25\]]} {
						>
							emit (Punct)
						<
					}
	
					if {[S string [R 0] 0 {} {} eq 26\]]} {
						>
							emit (Gobblet)
						<
					}
	
					if {[S string [R 0] 0 {} {} eq 27\]]} {
						>
							emit (hive)
						<
					}
	
					if {[S string [R 0] 0 {} {} eq 28\]]} {
						>
							emit (Exxit)
						<
					}
	
					if {[S string [R 0] 0 {} {} eq 29\]]} {
						>
							emit (Hnefatal)
						<
					}
	
					if {[S string [R 0] 0 {} {} eq 30\]]} {
						>
							emit (Kuba)
						<
					}
	
					if {[S string [R 0] 0 {} {} eq 31\]]} {
						>
							emit (Tripples)
						<
					}
	
					if {[S string [R 0] 0 {} {} eq 32\]]} {
						>
							emit (Chase)
						<
					}
	
					if {[S string [R 0] 0 {} {} eq 33\]]} {
						>
							emit {(Tumbling Down)}
						<
					}
	
					if {[S string [R 0] 0 {} {} eq 34\]]} {
						>
							emit (Sahara)
						<
					}
	
					if {[S string [R 0] 0 {} {} eq 35\]]} {
						>
							emit (Byte)
						<
					}
	
					if {[S string [R 0] 0 {} {} eq 36\]]} {
						>
							emit (Focus)
						<
					}
	
					if {[S string [R 0] 0 {} {} eq 37\]]} {
						>
							emit (Dvonn)
						<
					}
	
					if {[S string [R 0] 0 {} {} eq 38\]]} {
						>
							emit (Tamsk)
						<
					}
	
					if {[S string [R 0] 0 {} {} eq 39\]]} {
						>
							emit (Gipf)
						<
					}
	
					if {[S string [R 0] 0 {} {} eq 40\]]} {
						>
							emit (Kropki)
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq Gamebryo\ File\ Format,\ Version\ ]} {
		>
			emit {Gamebryo game engine file}
			if {[S regex [R 0] 0 {} {} eq \[0-9a-z.\]+]} {
				>
					emit {\b, version %s}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \;Gamebryo\ KFM\ File\ Version\ ]} {
		>
			emit {Gamebryo game engine animation File}
			if {[S regex [R 0] 0 {} {} eq \[0-9a-z.\]+]} {
				>
					emit {\b, version %s}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq NetImmerse\ File\ Format,\ Versio]} {
		>
			if {[S string [R 0] 0 {} {} eq n\ ]} {
				>
					emit {NetImmerse game engine file}
					if {[S regex [R 0] 0 {} {} eq \[0-9a-z.\]+]} {
						>
							emit {\b, version %s}
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S regex 2 0 c {} eq \\(\;.*GM\\\[\[0-9\]\{1,2\}\\\]]} {
		>
			emit {Smart Game Format}
			if {[S regex 2 0 c {} eq GM\\\[1\\\]]} {
				>
					emit {- Go Game}
				<
			}
	
			if {[S regex 2 0 c {} eq GM\\\[6\\\]]} {
				>
					emit {- BackGammon Game}
				<
			}
	
			if {[S regex 2 0 c {} eq GM\\\[11\\\]]} {
				>
					emit {- Hex Game}
				<
			}
	
			if {[S regex 2 0 c {} eq GM\\\[18\\\]]} {
				>
					emit {- Amazons Game}
				<
			}
	
			if {[S regex 2 0 c {} eq GM\\\[19\\\]]} {
				>
					emit {- Octi Game}
				<
			}
	
			if {[S regex 2 0 c {} eq GM\\\[20\\\]]} {
				>
					emit {- Gess Game}
				<
			}
	
			if {[S regex 2 0 c {} eq GM\\\[21\\\]]} {
				>
					emit {- twix Game}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq gpch]} {
		>
			emit {GCC precompiled header}
			if {[N byte 5 0 0 {} {} x {}]} {
				>
					emit {(version %c}
				<
			}
	
			if {[N byte 6 0 0 {} {} x {}]} {
				>
					emit {\b%c}
				<
			}
	
			if {[N byte 7 0 0 {} {} x {}]} {
				>
					emit {\b%c)}
				<
			}
	
			switch [Nv byte 4 0 {} {}] {
				43 {
					>
						emit {for C++}
					<
				}
				67 {
					>
						emit {for C}
					<
				}
				79 {
					>
						emit {for Objective-C++}
					<
				}
				111 {
					>
						emit {for Objective-C}
					<
				}
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq Identification_Information]} {
		>
			emit {FGDC ASCII metadata}
		<
	}
	
	if {[S string 0 0 {} {} eq KEB\ ]} {
		>
			emit {Knudsen seismic KEL binary (KEB) -}
			if {[S regex 4 0 {} {} eq \[-A-Z0-9\]*]} {
				>
					emit {Software: %s}
					if {[S regex [R 1] 0 {} {} eq V\[0-9\]*.\[0-9\]*]} {
						>
							emit {version %s}
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq HCA]} {
		>
			emit {LADS Caris Ascii Format (CAF) bathymetric lidar}
			if {[S regex 4 0 {} {} eq \[0-9\]*.\[0-9\]*]} {
				>
					emit {version %s}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq HCB]} {
		>
			emit {LADS Caris Binary Format (CBF) bathymetric lidar waveform data}
			if {[N byte 3 0 0 {} {} x {}]} {
				>
					emit {version %d .}
				<
			}
	
			if {[N byte 4 0 0 {} {} x {}]} {
				>
					emit %d
				<
			}
	
		<
	}
	
	if {[N beshort 4 0 0 {} {} == 8194]} {
		>
			emit {GeoSwath RDF}
		<
	}
	
	if {[S string 0 0 {} {} eq Start:-]} {
		>
			emit {GeoSwatch auf text file}
		<
	}
	
	if {[S string 0 0 {} {} eq SB2100]} {
		>
			emit {SeaBeam 2100 multibeam sonar}
		<
	}
	
	if {[S string 0 0 {} {} eq SB2100DR]} {
		>
			emit {SeaBeam 2100 DR multibeam sonar}
		<
	}
	
	if {[S string 0 0 {} {} eq SB2100PR]} {
		>
			emit {SeaBeam 2100 PR multibeam sonar}
		<
	}
	
	if {[S string 0 0 {} {} eq \$HSF]} {
		>
			emit {XSE multibeam}
		<
	}
	
	if {[S string 8 0 {} {} eq GSF-v]} {
		>
			emit {SAIC generic sensor format (GSF) sonar data,}
			if {[S regex [R 0] 0 {} {} eq \[0-9\]*.\[0-9\]*]} {
				>
					emit {version %s}
				<
			}
	
		<
	}
	
	if {[S string 9 0 {} {} eq MGD77]} {
		>
			emit {MGD77 Header, Marine Geophysical Data Exchange Format}
		<
	}
	
	if {[S string 1 0 {} {} eq Swath\ Data\ File:]} {
		>
			emit {mbsystem info cache}
		<
	}
	
	if {[S string 0 0 {} {} eq HDCS]} {
		>
			emit {Caris multibeam sonar related data}
		<
	}
	
	if {[S string 1 0 {} {} eq Start/Stop\ parameter\ header:]} {
		>
			emit {Caris ASCII project summary}
		<
	}
	
	if {[S string 0 0 {} {} eq %%\ TDR\ 2.0]} {
		>
			emit {IVS Fledermaus TDR file}
		<
	}
	
	if {[S string 0 0 {} {} eq U3D]} {
		>
			emit {ECMA-363, Universal 3D}
		<
	}
	
	if {[S string 0 0 {} {} eq \$@MID@\$]} {
		>
			emit {elog journal entry}
		<
	}
	
	if {[S string 0 0 {} {} eq DSBB]} {
		>
			emit {Surfer 6 binary grid file}
			if {[N leshort 4 0 0 {} {} x {}]} {
				>
					emit {\b, %d}
				<
			}
	
			if {[N leshort 6 0 0 {} {} x {}]} {
				>
					emit {\bx%d}
				<
			}
	
			if {[N ledouble 8 0 0 {} {} x {}]} {
				>
					emit {\b, minx=%g}
				<
			}
	
			if {[N ledouble 16 0 0 {} {} x {}]} {
				>
					emit {\b, maxx=%g}
				<
			}
	
			if {[N ledouble 24 0 0 {} {} x {}]} {
				>
					emit {\b, miny=%g}
				<
			}
	
			if {[N ledouble 32 0 0 {} {} x {}]} {
				>
					emit {\b, maxy=%g}
				<
			}
	
			if {[N ledouble 40 0 0 {} {} x {}]} {
				>
					emit {\b, minz=%g}
				<
			}
	
			if {[N ledouble 48 0 0 {} {} x {}]} {
				>
					emit {\b, maxz=%g}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq LASF]} {
		>
			emit {LIDAR point data records}
			if {[N byte 24 0 0 {} {} > 0]} {
				>
					emit {\b, version %u}
				<
			}
	
			if {[N byte 25 0 0 {} {} > 0]} {
				>
					emit {\b.%u}
				<
			}
	
			if {[S string 26 0 {} {} > \0]} {
				>
					emit {\b, SYSID %s}
				<
			}
	
			if {[S string 58 0 {} {} > \0]} {
				>
					emit {\b, Generating Software %s}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \#\ .PCD]} {
		>
			emit {Point Cloud Data}
		<
	}
	
	if {[S string 0 0 t {} eq GIMP\ Gradient]} {
		>
			emit {GIMP gradient data}
		<
	}
	
	if {[S string 0 0 t {} eq GIMP\ Palette]} {
		>
			emit {GIMP palette data}
		<
	}
	
	if {[S string 0 0 {} {} eq gimp\ xcf]} {
		>
			emit {GIMP XCF image data,}
			if {[S string 9 0 {} {} eq file]} {
				>
					emit {version 0,}
				<
			}
	
			if {[S string 9 0 {} {} eq v]} {
				>
					emit version
					if {[S string 10 0 {} {} > \0]} {
						>
							emit %s,
						<
					}
	
				<
			}
	
			if {[N belong 14 0 0 {} {} x {}]} {
				>
					emit {%u x}
				<
			}
	
			if {[N belong 18 0 0 {} {} x {}]} {
				>
					emit %u,
				<
			}
	
			switch [Nv belong 22 0 {} {}] {
				0 {
					>
						emit {RGB Color}
					<
				}
				1 {
					>
						emit Greyscale
					<
				}
				2 {
					>
						emit {Indexed Color}
					<
				}
			}
	
			if {[N belong 22 0 0 {} {} > 2]} {
				>
					emit {Unknown Image Type.}
				<
			}
	
			mime image/x-xcf
		<
	}
	
	if {[S string 20 0 {} {} eq GPAT]} {
		>
			emit {GIMP pattern data,}
			if {[S string 24 0 {} {} x {}]} {
				>
					emit %s
				<
			}
	
		<
	}
	
	if {[S string 20 0 {} {} eq GIMP]} {
		>
			emit {GIMP brush data}
		<
	}
	
	if {[S string 0 0 {} {} eq \#\040GIMP\040Curves\040File]} {
		>
			emit {GIMP curve file}
		<
	}
	
	if {[S string 0 0 {} {} eq GnomeKeyring\n\r\0\n]} {
		>
			emit {GNOME keyring}
			if {[N ubyte [R 0] 0 0 {} {} == 0]} {
				>
					emit {\b, major version 0}
					if {[N ubyte [R 0] 0 0 {} {} == 0]} {
						>
							emit {\b, minor version 0}
							if {[N ubyte [R 0] 0 0 {} {} == 0]} {
								>
									emit {\b, crypto type 0 (AES)}
								<
							}
	
							if {[N ubyte [R 0] 0 0 {} {} > 0]} {
								>
									emit {\b, crypto type %u (unknown)}
								<
							}
	
							if {[N ubyte [R 1] 0 0 {} {} == 0]} {
								>
									emit {\b, hash type 0 (MD5)}
								<
							}
	
							if {[N ubyte [R 1] 0 0 {} {} > 0]} {
								>
									emit {\b, hash type %u (unknown)}
								<
							}
	
							if {[N ubelong [R 2] 0 0 {} {} == 4294967295]} {
								>
									emit {\b, name NULL}
								<
							}
	
							if {[N ubelong [R 2] 0 0 {} {} != 4294967295]} {
								>
									if {[N ubelong [R -4] 0 0 {} {} > 255]} {
										>
											emit {\b, name too long for file's pstring type}
										<
									}
	
									if {[N ubelong [R -4] 0 0 {} {} < 256]} {
										>
											if {[S pstring [R -1] 0 {} {} x {}]} {
												>
													emit {\b, name "%s"}
													if {[N ubeqdate [R 0] 0 0 {} {} x {}]} {
														>
															emit {\b, last modified %s}
														<
													}
	
													if {[N ubeqdate [R 8] 0 0 {} {} x {}]} {
														>
															emit {\b, created %s}
														<
													}
	
													if {[N ubelong [R 16] 0 0 {} {} & 1]} {
														>
															if {[N ubelong [R 0] 0 0 {} {} x {}]} {
																>
																	emit {\b, locked if idle for %u seconds}
																<
															}
	
														<
													}
	
													if {[N ubelong [R 16] 0 0 {} {} ^ 1]} {
														>
															emit {\b, not locked if idle}
														<
													}
	
													if {[N ubelong [R 24] 0 0 {} {} x {}]} {
														>
															emit {\b, hash iterations %u}
														<
													}
	
													if {[N ubequad [R 28] 0 0 {} {} x {}]} {
														>
															emit {\b, salt %llu}
														<
													}
	
													if {[N ubelong [R 52] 0 0 {} {} x {}]} {
														>
															emit {\b, %u item(s)}
														<
													}
	
												<
											}
	
										<
									}
	
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 4 0 {} {} eq gtktalog]} {
		>
			emit {GNOME Catalogue (gtktalog)}
			if {[S string 13 0 {} {} > \0]} {
				>
					emit {version %s}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq GVariant]} {
		>
			emit {GVariant Database file,}
			if {[N lelong 8 0 0 {} {} x {}]} {
				>
					emit {version %d}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq GOBJ\nMETADATA\r\n\032]} {
		>
			emit {G-IR binary database}
			if {[N byte 16 0 0 {} {} x {}]} {
				>
					emit {\b, v%d}
				<
			}
	
			if {[N byte 17 0 0 {} {} x {}]} {
				>
					emit {\b.%d}
				<
			}
	
			if {[N leshort 20 0 0 {} {} x {}]} {
				>
					emit {\b, %d entries}
				<
			}
	
			if {[N leshort 22 0 0 {} {} x {}]} {
				>
					emit {\b/%d local}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \336\22\4\225]} {
		>
			emit {GNU message catalog (little endian),}
			if {[N ulelong 4 0 0 {} {} x {}]} {
				>
					emit revision
					mime application/x-gettext-translation
					ext gmo/mo
				<
			}
	
			if {[N ulelong 4 0 0 / 65535 x {}]} {
				>
					emit %u.
				<
			}
	
			if {[N ulelong 4 0 0 & 65535 x {}]} {
				>
					emit {\b%u}
					if {[N ulelong 8 0 0 {} {} x {}]} {
						>
							emit {\b, %u message}
						<
					}
	
					if {[N ulelong 8 0 0 {} {} > 1]} {
						>
							emit {\bs}
						<
					}
	
				<
			}
	
			if {[N ulelong 4 0 0 & 65535 == 0]} {
				>
					if {[N ulelong 12 0 0 {} {} != 28]} {
						>
							emit {\b, at 0x%x string table}
						<
					}
	
				<
			}
	
			if {[N ulelong 4 0 0 & 65535 > 0]} {
				>
					if {[N ulelong 12 0 0 {} {} != 48]} {
						>
							emit {\b, at 0x%x string table}
						<
					}
	
					if {[N ulelong 36 0 0 {} {} x {}]} {
						>
							emit {\b, %u sysdep message}
						<
					}
	
					if {[N ulelong 36 0 0 {} {} > 1]} {
						>
							emit {\bs}
						<
					}
	
				<
			}
	
			if {[N ulelong [I 16 ulelong 0 + 0 0] 0 0 {} {} > 0]} {
				>
					if {[N ulelong [R 0] 0 0 {} {} x {}]} {
						>
							if {[S string [I [R -4] long 0 + 0 0] 0 {} {} x {}]} {
								>
									emit {\b, %s}
								<
							}
	
						<
					}
	
				<
			}
	
			if {[N ulelong [I 16 ulelong 0 + 0 8] 0 0 {} {} > 1]} {
				>
					if {[N ulelong [R 0] 0 0 {} {} x {}]} {
						>
							if {[N ubyte [I [R -4] long 0 + 0 0] 0 0 {} {} != 10]} {
								>
									if {[S string [R -1] 0 {} {} x {}]} {
										>
											emit '%s'
										<
									}
	
								<
							}
	
							if {[N ubyte [I [R -4] long 0 + 0 0] 0 0 {} {} == 10]} {
								>
									if {[N ubyte [R 0] 0 0 {} {} != 10]} {
										>
											if {[S string [R -1] 0 {} {} x {}]} {
												>
													emit '%s'
												<
											}
	
										<
									}
	
									if {[N ubyte [R 0] 0 0 {} {} == 10]} {
										>
											if {[S string [R 0] 0 {} {} x {}]} {
												>
													emit '%s'
												<
											}
	
										<
									}
	
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \225\4\22\336]} {
		>
			emit {GNU message catalog (big endian),}
			if {[N beshort 4 0 0 {} {} x {}]} {
				>
					emit {revision %d.}
				<
			}
	
			if {[N beshort 6 0 0 {} {} > 0]} {
				>
					emit {\b%d,}
					if {[N belong 8 0 0 {} {} x {}]} {
						>
							emit {%d messages,}
						<
					}
	
					if {[N belong 36 0 0 {} {} x {}]} {
						>
							emit {%d sysdep messages}
						<
					}
	
				<
			}
	
			if {[N beshort 6 0 0 {} {} == 0]} {
				>
					emit {\b%d,}
					if {[N belong 8 0 0 {} {} x {}]} {
						>
							emit {%d messages}
						<
					}
	
				<
			}
	
			mime application/x-gettext-translation
			ext gmo/mo
		<
	}
	
	if {[S string 0 0 {} {} eq \001gpg]} {
		>
			emit {GPG key trust database}
			if {[N byte 4 0 0 {} {} x {}]} {
				>
					emit {version %d}
				<
			}
	
		<
	}
	
	if {[S string 39 0 {} {} eq <gmr:Workbook]} {
		>
			emit {Gnumeric spreadsheet}
		<
	}
	
	if {[S string 0 0 {} {} eq \0LOCATE]} {
		>
			emit {GNU findutils locate database data}
			if {[S string 7 0 {} {} > \0]} {
				>
					emit {\b, format %s}
				<
			}
	
			if {[S string 7 0 {} {} eq 02]} {
				>
					emit {\b (frcode)}
				<
			}
	
		<
	}
	
	if {[S search 0 0 {} 1024 eq \nmsgid]} {
		>
			if {[S search [R 0] 0 {} 1024 eq \nmsgstr]} {
				>
					emit {GNU gettext message catalogue text}
					mime text/x-po
					strength +100
				<
			}
	
		<
	}
	
	if {[S string 39 0 {} {} eq <gmr:Workbook]} {
		>
			emit {Gnumeric spreadsheet}
			mime application/x-gnumeric
		<
	}
	
	if {[S string 0 0 {} {} eq EFI\ PART]} {
		>
			emit {GPT data structure (nonstandard: at LBA 0)}
			U 98 gpt-table 0
	
			if {[N ubyte 0 0 0 {} {} x {}]} {
				>
					emit {(sector size unknown)}
				<
			}
	
		<
	}
	
	if {[N lequad 8 0 0 {} {} == -6075971174239896308]} {
		>
			emit {Vulkan trace file, little-endian}
			if {[N leshort 0 0 0 {} {} x {}]} {
				>
					emit {\b, version %d}
				<
			}
	
		<
	}
	
	if {[N bequad 8 0 0 {} {} == -6075971174239896308]} {
		>
			emit {Vulkan trace file, big-endian}
			if {[N beshort 0 0 0 {} {} x {}]} {
				>
					emit {\b, version %d}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \000\000\0001\000\000\0000\000\000\0000\000\000\0002\000\000\0000\000\000\0000\000\000\0003]} {
		>
			emit {old ACE/gr binary file}
			if {[N byte 39 0 0 {} {} > 0]} {
				>
					emit {- version %c}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \#\ xvgr\ parameter\ file]} {
		>
			emit {ACE/gr ascii file}
		<
	}
	
	if {[S string 0 0 {} {} eq \#\ xmgr\ parameter\ file]} {
		>
			emit {ACE/gr ascii file}
		<
	}
	
	if {[S string 0 0 {} {} eq \#\ ACE/gr\ parameter\ file]} {
		>
			emit {ACE/gr ascii file}
		<
	}
	
	if {[S string 0 0 {} {} eq \#\ Grace\ project\ file]} {
		>
			emit {Grace project file}
			if {[S string 23 0 {} {} eq @version\ ]} {
				>
					emit (version
					if {[N byte 32 0 0 {} {} > 0]} {
						>
							emit %c
						<
					}
	
					if {[S string 33 0 {} {} > \0]} {
						>
							emit {\b.%.2s}
						<
					}
	
					if {[S string 35 0 {} {} > \0]} {
						>
							emit {\b.%.2s)}
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \#\ ACE/gr\ fit\ description\ ]} {
		>
			emit {ACE/gr fit description file}
		<
	}
	
	if {[S string 0 0 {} {} eq GRG]} {
		>
			emit {Gringotts data file}
			if {[S string 3 0 {} {} eq 1]} {
				>
					emit {v.1, MCRYPT S2K, SERPENT crypt, SHA-256 hash, ZLib lvl.9}
				<
			}
	
			if {[S string 3 0 {} {} eq 2]} {
				>
					emit {v.2, MCRYPT S2K,}
					switch [Nv byte 8 0 & 112] {
						0 {
							>
								emit {RIJNDAEL-128 crypt,}
							<
						}
						16 {
							>
								emit {SERPENT crypt,}
							<
						}
						32 {
							>
								emit {TWOFISH crypt,}
							<
						}
						48 {
							>
								emit {CAST-256 crypt,}
							<
						}
						64 {
							>
								emit {SAFER+ crypt,}
							<
						}
						80 {
							>
								emit {LOKI97 crypt,}
							<
						}
						96 {
							>
								emit {3DES crypt,}
							<
						}
						112 {
							>
								emit {RIJNDAEL-256 crypt,}
							<
						}
					}
	
					switch [Nv byte 8 0 & 8] {
						0 {
							>
								emit {SHA1 hash,}
							<
						}
						8 {
							>
								emit {RIPEMD-160 hash,}
							<
						}
					}
	
					switch [Nv byte 8 0 & 4] {
						0 {
							>
								emit ZLib
							<
						}
						4 {
							>
								emit BZip2
							<
						}
					}
	
					switch [Nv byte 8 0 & 3] {
						0 {
							>
								emit lvl.0
							<
						}
						1 {
							>
								emit lvl.3
							<
						}
						2 {
							>
								emit lvl.6
							<
						}
						3 {
							>
								emit lvl.9
							<
						}
					}
	
				<
			}
	
			if {[S string 3 0 {} {} eq 3]} {
				>
					emit {v.3, OpenPGP S2K,}
					switch [Nv byte 8 0 & 112] {
						0 {
							>
								emit {RIJNDAEL-128 crypt,}
							<
						}
						16 {
							>
								emit {SERPENT crypt,}
							<
						}
						32 {
							>
								emit {TWOFISH crypt,}
							<
						}
						48 {
							>
								emit {CAST-256 crypt,}
							<
						}
						64 {
							>
								emit {SAFER+ crypt,}
							<
						}
						80 {
							>
								emit {LOKI97 crypt,}
							<
						}
						96 {
							>
								emit {3DES crypt,}
							<
						}
						112 {
							>
								emit {RIJNDAEL-256 crypt,}
							<
						}
					}
	
					switch [Nv byte 8 0 & 8] {
						0 {
							>
								emit {SHA1 hash,}
							<
						}
						8 {
							>
								emit {RIPEMD-160 hash,}
							<
						}
					}
	
					switch [Nv byte 8 0 & 4] {
						0 {
							>
								emit ZLib
							<
						}
						4 {
							>
								emit BZip2
							<
						}
					}
	
					switch [Nv byte 8 0 & 3] {
						0 {
							>
								emit lvl.0
							<
						}
						1 {
							>
								emit lvl.3
							<
						}
						2 {
							>
								emit lvl.6
							<
						}
						3 {
							>
								emit lvl.9
							<
						}
					}
	
				<
			}
	
			if {[S string 3 0 {} {} > 3]} {
				>
					emit {v.%.1s (unknown details)}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq GOOF----]} {
		>
			emit {Guile Object}
			if {[S string 8 0 {} {} eq LE]} {
				>
					emit {\b, little endian}
				<
			}
	
			if {[S string 8 0 {} {} eq BE]} {
				>
					emit {\b, big endian}
				<
			}
	
			if {[S string 11 0 {} {} eq 4]} {
				>
					emit {\b, 32bit}
				<
			}
	
			if {[S string 11 0 {} {} eq 8]} {
				>
					emit {\b, 64bit}
				<
			}
	
			if {[S regex 13 0 {} {} eq ...]} {
				>
					emit {\b, bytecode v%s}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq Bitmapfile]} {
		>
			emit {HP Bitmapfile}
		<
	}
	
	if {[S string 0 0 {} {} eq IMGfile]} {
		>
			emit {CIS 	compimg HP Bitmapfile}
		<
	}
	
	if {[S string 0 0 {} {} eq msgcat01]} {
		>
			emit {HP NLS message catalog,}
			if {[N long 8 0 0 {} {} > 0]} {
				>
					emit {%d messages}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq HPHP]} {
		>
			emit HP
			if {[S string 4 0 {} {} eq 48]} {
				>
					emit {48 binary}
				<
			}
	
			if {[S string 4 0 {} {} eq 49]} {
				>
					emit {49 binary}
				<
			}
	
			if {[N byte 7 0 0 {} {} > 64]} {
				>
					emit {- Rev %c}
				<
			}
	
			switch [Nv leshort 8 0 {} {}] {
				10513 {
					>
						emit (ADR)
					<
				}
				10547 {
					>
						emit (REAL)
					<
				}
				10581 {
					>
						emit (LREAL)
					<
				}
				10615 {
					>
						emit (COMPLX)
					<
				}
				10653 {
					>
						emit (LCOMPLX)
					<
				}
				10687 {
					>
						emit (CHAR)
					<
				}
				10728 {
					>
						emit (ARRAY)
					<
				}
				10762 {
					>
						emit (LNKARRAY)
					<
				}
				10796 {
					>
						emit (STRING)
					<
				}
				10830 {
					>
						emit (HXS)
					<
				}
				10868 {
					>
						emit (LIST)
					<
				}
				10902 {
					>
						emit (DIR)
					<
				}
				10936 {
					>
						emit (ALG)
					<
				}
				10970 {
					>
						emit (UNIT)
					<
				}
				11004 {
					>
						emit (TAGGED)
					<
				}
				11038 {
					>
						emit (GROB)
					<
				}
				11072 {
					>
						emit (LIB)
					<
				}
				11106 {
					>
						emit (BACKUP)
					<
				}
				11144 {
					>
						emit (LIBDATA)
					<
				}
				11677 {
					>
						emit (PROG)
					<
				}
				11724 {
					>
						emit (CODE)
					<
				}
				11848 {
					>
						emit (GNAME)
					<
				}
				11885 {
					>
						emit (LNAME)
					<
				}
				11922 {
					>
						emit (XLIB)
					<
				}
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq %%HP:]} {
		>
			emit {HP text}
			if {[S string 6 0 {} {} eq T(0)]} {
				>
					emit {- T(0)}
				<
			}
	
			if {[S string 6 0 {} {} eq T(1)]} {
				>
					emit {- T(1)}
				<
			}
	
			if {[S string 6 0 {} {} eq T(2)]} {
				>
					emit {- T(2)}
				<
			}
	
			if {[S string 6 0 {} {} eq T(3)]} {
				>
					emit {- T(3)}
				<
			}
	
			if {[S string 10 0 {} {} eq A(D)]} {
				>
					emit A(D)
				<
			}
	
			if {[S string 10 0 {} {} eq A(R)]} {
				>
					emit A(R)
				<
			}
	
			if {[S string 10 0 {} {} eq A(G)]} {
				>
					emit A(G)
				<
			}
	
			if {[S string 14 0 {} {} eq F(.)]} {
				>
					emit {F(.);}
				<
			}
	
			if {[S string 14 0 {} {} eq F(,)]} {
				>
					emit {F(,);}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq HP3]} {
		>
			if {[S string 3 0 {} {} eq 8]} {
				>
					emit {HP 38}
				<
			}
	
			if {[S string 3 0 {} {} eq 9]} {
				>
					emit {HP 39}
				<
			}
	
			if {[S string 4 0 {} {} eq Bin]} {
				>
					emit binary
				<
			}
	
			if {[S string 4 0 {} {} eq Asc]} {
				>
					emit ASCII
				<
			}
	
			if {[S string 7 0 {} {} eq A]} {
				>
					emit {(Directory List)}
				<
			}
	
			if {[S string 7 0 {} {} eq B]} {
				>
					emit (Zaplet)
				<
			}
	
			if {[S string 7 0 {} {} eq C]} {
				>
					emit (Note)
				<
			}
	
			if {[S string 7 0 {} {} eq D]} {
				>
					emit (Program)
				<
			}
	
			if {[S string 7 0 {} {} eq E]} {
				>
					emit (Variable)
				<
			}
	
			if {[S string 7 0 {} {} eq F]} {
				>
					emit (List)
				<
			}
	
			if {[S string 7 0 {} {} eq G]} {
				>
					emit (Matrix)
				<
			}
	
			if {[S string 7 0 {} {} eq H]} {
				>
					emit (Library)
				<
			}
	
			if {[S string 7 0 {} {} eq I]} {
				>
					emit {(Target List)}
				<
			}
	
			if {[S string 7 0 {} {} eq J]} {
				>
					emit {(ASCII Vector specification)}
				<
			}
	
			if {[S string 7 0 {} {} eq K]} {
				>
					emit (wildcard)
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq HP3]} {
		>
			if {[S string 3 0 {} {} eq 8]} {
				>
					emit {HP 38}
				<
			}
	
			if {[S string 3 0 {} {} eq 9]} {
				>
					emit {HP 39}
				<
			}
	
			if {[S string 4 0 {} {} eq Bin]} {
				>
					emit binary
				<
			}
	
			if {[S string 4 0 {} {} eq Asc]} {
				>
					emit ASCII
				<
			}
	
			if {[S string 7 0 {} {} eq A]} {
				>
					emit {(Directory List)}
				<
			}
	
			if {[S string 7 0 {} {} eq B]} {
				>
					emit (Zaplet)
				<
			}
	
			if {[S string 7 0 {} {} eq C]} {
				>
					emit (Note)
				<
			}
	
			if {[S string 7 0 {} {} eq D]} {
				>
					emit (Program)
				<
			}
	
			if {[S string 7 0 {} {} eq E]} {
				>
					emit (Variable)
				<
			}
	
			if {[S string 7 0 {} {} eq F]} {
				>
					emit (List)
				<
			}
	
			if {[S string 7 0 {} {} eq G]} {
				>
					emit (Matrix)
				<
			}
	
			if {[S string 7 0 {} {} eq H]} {
				>
					emit (Library)
				<
			}
	
			if {[S string 7 0 {} {} eq I]} {
				>
					emit {(Target List)}
				<
			}
	
			if {[S string 7 0 {} {} eq J]} {
				>
					emit {(ASCII Vector specification)}
				<
			}
	
			if {[S string 7 0 {} {} eq K]} {
				>
					emit (wildcard)
				<
			}
	
		<
	}
	
	if {[S string 16 0 {} {} eq HP-UX]} {
		>
			if {[N belong 0 0 0 {} {} == 2]} {
				>
					if {[N belong 12 0 0 {} {} == 60]} {
						>
							switch [Nv belong 76 0 {} {}] {
								1 {
									>
										if {[N belong 88 0 0 {} {} == 4]} {
											>
												if {[N belong 92 0 0 {} {} == 1]} {
													>
														if {[N belong 96 0 0 {} {} == 256]} {
															>
																if {[N belong 108 0 0 {} {} == 68]} {
																	>
																		if {[N belong 180 0 0 {} {} == 4]} {
																			>
																				emit {core file}
																				if {[S string 164 0 {} {} > \0]} {
																					>
																						emit {from '%s'}
																					<
																				}
	
																				switch [Nv belong 196 0 {} {}] {
																					3 {
																						>
																							emit {- received SIGQUIT}
																						<
																					}
																					4 {
																						>
																							emit {- received SIGILL}
																						<
																					}
																					5 {
																						>
																							emit {- received SIGTRAP}
																						<
																					}
																					6 {
																						>
																							emit {- received SIGABRT}
																						<
																					}
																					7 {
																						>
																							emit {- received SIGEMT}
																						<
																					}
																					8 {
																						>
																							emit {- received SIGFPE}
																						<
																					}
																					10 {
																						>
																							emit {- received SIGBUS}
																						<
																					}
																					11 {
																						>
																							emit {- received SIGSEGV}
																						<
																					}
																					12 {
																						>
																							emit {- received SIGSYS}
																						<
																					}
																					33 {
																						>
																							emit {- received SIGXCPU}
																						<
																					}
																					34 {
																						>
																							emit {- received SIGXFSZ}
																						<
																					}
																				}
	
																			<
																		}
	
																	<
																}
	
															<
														}
	
													<
												}
	
											<
										}
	
									<
								}
								256 {
									>
										if {[N belong 88 0 0 {} {} == 68]} {
											>
												if {[N belong 160 0 0 {} {} == 1]} {
													>
														if {[N belong 172 0 0 {} {} == 4]} {
															>
																if {[N belong 176 0 0 {} {} == 1]} {
																	>
																		if {[N belong 180 0 0 {} {} == 4]} {
																			>
																				emit {core file}
																				if {[S string 144 0 {} {} > \0]} {
																					>
																						emit {from '%s'}
																					<
																				}
	
																				switch [Nv belong 196 0 {} {}] {
																					3 {
																						>
																							emit {- received SIGQUIT}
																						<
																					}
																					4 {
																						>
																							emit {- received SIGILL}
																						<
																					}
																					5 {
																						>
																							emit {- received SIGTRAP}
																						<
																					}
																					6 {
																						>
																							emit {- received SIGABRT}
																						<
																					}
																					7 {
																						>
																							emit {- received SIGEMT}
																						<
																					}
																					8 {
																						>
																							emit {- received SIGFPE}
																						<
																					}
																					10 {
																						>
																							emit {- received SIGBUS}
																						<
																					}
																					11 {
																						>
																							emit {- received SIGSEGV}
																						<
																					}
																					12 {
																						>
																							emit {- received SIGSYS}
																						<
																					}
																					33 {
																						>
																							emit {- received SIGXCPU}
																						<
																					}
																					34 {
																						>
																							emit {- received SIGXFSZ}
																						<
																					}
																				}
	
																			<
																		}
	
																	<
																}
	
															<
														}
	
													<
												}
	
											<
										}
	
									<
								}
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 36 0 {} {} eq HP-UX]} {
		>
			if {[N belong 0 0 0 {} {} == 1]} {
				>
					if {[N belong 12 0 0 {} {} == 4]} {
						>
							if {[N belong 16 0 0 {} {} == 1]} {
								>
									if {[N belong 20 0 0 {} {} == 2]} {
										>
											if {[N belong 32 0 0 {} {} == 60]} {
												>
													if {[N belong 96 0 0 {} {} == 256]} {
														>
															if {[N belong 108 0 0 {} {} == 68]} {
																>
																	if {[N belong 180 0 0 {} {} == 4]} {
																		>
																			emit {core file}
																			if {[S string 164 0 {} {} > \0]} {
																				>
																					emit {from '%s'}
																				<
																			}
	
																			switch [Nv belong 196 0 {} {}] {
																				3 {
																					>
																						emit {- received SIGQUIT}
																					<
																				}
																				4 {
																					>
																						emit {- received SIGILL}
																					<
																				}
																				5 {
																					>
																						emit {- received SIGTRAP}
																					<
																				}
																				6 {
																					>
																						emit {- received SIGABRT}
																					<
																				}
																				7 {
																					>
																						emit {- received SIGEMT}
																					<
																				}
																				8 {
																					>
																						emit {- received SIGFPE}
																					<
																				}
																				10 {
																					>
																						emit {- received SIGBUS}
																					<
																				}
																				11 {
																					>
																						emit {- received SIGSEGV}
																					<
																				}
																				12 {
																					>
																						emit {- received SIGSYS}
																					<
																				}
																				33 {
																					>
																						emit {- received SIGXCPU}
																					<
																				}
																				34 {
																					>
																						emit {- received SIGXFSZ}
																					<
																				}
																			}
	
																		<
																	}
	
																<
															}
	
														<
													}
	
												<
											}
	
										<
									}
	
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 100 0 {} {} eq HP-UX]} {
		>
			if {[N belong 0 0 0 {} {} == 256]} {
				>
					if {[N belong 12 0 0 {} {} == 68]} {
						>
							if {[N belong 84 0 0 {} {} == 2]} {
								>
									if {[N belong 96 0 0 {} {} == 60]} {
										>
											if {[N belong 160 0 0 {} {} == 1]} {
												>
													if {[N belong 172 0 0 {} {} == 4]} {
														>
															if {[N belong 176 0 0 {} {} == 1]} {
																>
																	if {[N belong 180 0 0 {} {} == 4]} {
																		>
																			emit {core file}
																			if {[S string 68 0 {} {} > \0]} {
																				>
																					emit {from '%s'}
																				<
																			}
	
																			switch [Nv belong 196 0 {} {}] {
																				3 {
																					>
																						emit {- received SIGQUIT}
																					<
																				}
																				4 {
																					>
																						emit {- received SIGILL}
																					<
																				}
																				5 {
																					>
																						emit {- received SIGTRAP}
																					<
																				}
																				6 {
																					>
																						emit {- received SIGABRT}
																					<
																				}
																				7 {
																					>
																						emit {- received SIGEMT}
																					<
																				}
																				8 {
																					>
																						emit {- received SIGFPE}
																					<
																				}
																				10 {
																					>
																						emit {- received SIGBUS}
																					<
																				}
																				11 {
																					>
																						emit {- received SIGSEGV}
																					<
																				}
																				12 {
																					>
																						emit {- received SIGSYS}
																					<
																				}
																				33 {
																					>
																						emit {- received SIGXCPU}
																					<
																				}
																				34 {
																					>
																						emit {- received SIGXFSZ}
																					<
																				}
																			}
	
																		<
																	}
	
																<
															}
	
														<
													}
	
												<
											}
	
										<
									}
	
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 120 0 {} {} eq HP-UX]} {
		>
			switch [Nv belong 0 0 {} {}] {
				1 {
					>
						if {[N belong 12 0 0 {} {} == 4]} {
							>
								if {[N belong 16 0 0 {} {} == 1]} {
									>
										if {[N belong 20 0 0 {} {} == 256]} {
											>
												if {[N belong 32 0 0 {} {} == 68]} {
													>
														if {[N belong 104 0 0 {} {} == 2]} {
															>
																if {[N belong 116 0 0 {} {} == 60]} {
																	>
																		if {[N belong 180 0 0 {} {} == 4]} {
																			>
																				emit {core file}
																				if {[S string 88 0 {} {} > \0]} {
																					>
																						emit {from '%s'}
																					<
																				}
	
																				switch [Nv belong 196 0 {} {}] {
																					3 {
																						>
																							emit {- received SIGQUIT}
																						<
																					}
																					4 {
																						>
																							emit {- received SIGILL}
																						<
																					}
																					5 {
																						>
																							emit {- received SIGTRAP}
																						<
																					}
																					6 {
																						>
																							emit {- received SIGABRT}
																						<
																					}
																					7 {
																						>
																							emit {- received SIGEMT}
																						<
																					}
																					8 {
																						>
																							emit {- received SIGFPE}
																						<
																					}
																					10 {
																						>
																							emit {- received SIGBUS}
																						<
																					}
																					11 {
																						>
																							emit {- received SIGSEGV}
																						<
																					}
																					12 {
																						>
																							emit {- received SIGSYS}
																						<
																					}
																					33 {
																						>
																							emit {- received SIGXCPU}
																						<
																					}
																					34 {
																						>
																							emit {- received SIGXFSZ}
																						<
																					}
																				}
	
																			<
																		}
	
																	<
																}
	
															<
														}
	
													<
												}
	
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
				256 {
					>
						if {[N belong 12 0 0 {} {} == 68]} {
							>
								if {[N belong 84 0 0 {} {} == 1]} {
									>
										if {[N belong 96 0 0 {} {} == 4]} {
											>
												if {[N belong 100 0 0 {} {} == 1]} {
													>
														if {[N belong 104 0 0 {} {} == 2]} {
															>
																if {[N belong 116 0 0 {} {} == 44]} {
																	>
																		if {[N belong 180 0 0 {} {} == 4]} {
																			>
																				emit {core file}
																				if {[S string 68 0 {} {} > \0]} {
																					>
																						emit {from '%s'}
																					<
																				}
	
																				switch [Nv belong 196 0 {} {}] {
																					3 {
																						>
																							emit {- received SIGQUIT}
																						<
																					}
																					4 {
																						>
																							emit {- received SIGILL}
																						<
																					}
																					5 {
																						>
																							emit {- received SIGTRAP}
																						<
																					}
																					6 {
																						>
																							emit {- received SIGABRT}
																						<
																					}
																					7 {
																						>
																							emit {- received SIGEMT}
																						<
																					}
																					8 {
																						>
																							emit {- received SIGFPE}
																						<
																					}
																					10 {
																						>
																							emit {- received SIGBUS}
																						<
																					}
																					11 {
																						>
																							emit {- received SIGSEGV}
																						<
																					}
																					12 {
																						>
																							emit {- received SIGSYS}
																						<
																					}
																					33 {
																						>
																							emit {- received SIGXCPU}
																						<
																					}
																					34 {
																						>
																							emit {- received SIGXFSZ}
																						<
																					}
																				}
	
																			<
																		}
	
																	<
																}
	
															<
														}
	
													<
												}
	
											<
										}
	
									<
								}
	
							<
						}
	
					<
				}
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq 0xabcdef]} {
		>
			emit {AIX message catalog}
		<
	}
	
	if {[S string 0 0 {} {} eq <aiaff>]} {
		>
			emit archive
		<
	}
	
	if {[S string 0 0 {} {} eq <bigaf>]} {
		>
			emit {archive (big format)}
		<
	}
	
	if {[N belong 4 0 0 {} {} & 267312560]} {
		>
			if {[N byte 7 0 0 & 3 != 3]} {
				>
					emit {AIX core file}
					if {[N byte 1 0 0 {} {} & 1]} {
						>
							emit fulldump
						<
					}
	
					if {[N byte 7 0 0 {} {} & 1]} {
						>
							emit 32-bit
							if {[S string 1760 0 {} {} > \0]} {
								>
									emit {\b, %s}
								<
							}
	
						<
					}
	
					if {[N byte 7 0 0 {} {} & 2]} {
						>
							emit 64-bit
							if {[S string 1316 0 {} {} > \0]} {
								>
									emit {\b, %s}
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 36 0 {} {} eq acsp]} {
		>
			U 109 color-profile 0
	
		<
	}
	
	if {[S string 0 0 {} {} eq FORM]} {
		>
			emit {IFF data}
			if {[S string 8 0 {} {} eq AIFF]} {
				>
					emit {\b, AIFF audio}
					mime audio/x-aiff
				<
			}
	
			if {[S string 8 0 {} {} eq AIFC]} {
				>
					emit {\b, AIFF-C compressed audio}
					mime audio/x-aiff
				<
			}
	
			if {[S string 8 0 {} {} eq 8SVX]} {
				>
					emit {\b, 8SVX 8-bit sampled sound voice}
					mime audio/x-aiff
				<
			}
	
			if {[S string 8 0 {} {} eq 16SV]} {
				>
					emit {\b, 16SV 16-bit sampled sound voice}
				<
			}
	
			if {[S string 8 0 {} {} eq SAMP]} {
				>
					emit {\b, SAMP sampled audio}
				<
			}
	
			if {[S string 8 0 {} {} eq MAUD]} {
				>
					emit {\b, MAUD MacroSystem audio}
				<
			}
	
			if {[S string 8 0 {} {} eq SMUS]} {
				>
					emit {\b, SMUS simple music}
				<
			}
	
			if {[S string 8 0 {} {} eq CMUS]} {
				>
					emit {\b, CMUS complex music}
				<
			}
	
			if {[S string 8 0 {} {} eq ILBMBMHD]} {
				>
					emit {\b, ILBM interleaved image}
					if {[N beshort 20 0 0 {} {} x {}]} {
						>
							emit {\b, %d x}
						<
					}
	
					if {[N beshort 22 0 0 {} {} x {}]} {
						>
							emit %d
						<
					}
	
				<
			}
	
			if {[S string 8 0 {} {} eq RGBN]} {
				>
					emit {\b, RGBN 12-bit RGB image}
				<
			}
	
			if {[S string 8 0 {} {} eq RGB8]} {
				>
					emit {\b, RGB8 24-bit RGB image}
				<
			}
	
			if {[S string 8 0 {} {} eq DEEP]} {
				>
					emit {\b, DEEP TVPaint/XiPaint image}
				<
			}
	
			if {[S string 8 0 {} {} eq DR2D]} {
				>
					emit {\b, DR2D 2-D object}
				<
			}
	
			if {[S string 8 0 {} {} eq TDDD]} {
				>
					emit {\b, TDDD 3-D rendering}
				<
			}
	
			if {[S string 8 0 {} {} eq LWOB]} {
				>
					emit {\b, LWOB 3-D object}
				<
			}
	
			if {[S string 8 0 {} {} eq LWO2]} {
				>
					emit {\b, LWO2 3-D object, v2}
				<
			}
	
			if {[S string 8 0 {} {} eq LWLO]} {
				>
					emit {\b, LWLO 3-D layered object}
				<
			}
	
			if {[S string 8 0 {} {} eq REAL]} {
				>
					emit {\b, REAL Real3D rendering}
				<
			}
	
			if {[S string 8 0 {} {} eq MC4D]} {
				>
					emit {\b, MC4D MaxonCinema4D rendering}
				<
			}
	
			if {[S string 8 0 {} {} eq ANIM]} {
				>
					emit {\b, ANIM animation}
				<
			}
	
			if {[S string 8 0 {} {} eq YAFA]} {
				>
					emit {\b, YAFA animation}
				<
			}
	
			if {[S string 8 0 {} {} eq SSA\ ]} {
				>
					emit {\b, SSA super smooth animation}
				<
			}
	
			if {[S string 8 0 {} {} eq ACBM]} {
				>
					emit {\b, ACBM continuous image}
				<
			}
	
			if {[S string 8 0 {} {} eq FAXX]} {
				>
					emit {\b, FAXX fax image}
				<
			}
	
			if {[S string 8 0 {} {} eq FTXT]} {
				>
					emit {\b, FTXT formatted text}
				<
			}
	
			if {[S string 8 0 {} {} eq CTLG]} {
				>
					emit {\b, CTLG message catalog}
				<
			}
	
			if {[S string 8 0 {} {} eq PREF]} {
				>
					emit {\b, PREF preferences}
				<
			}
	
			if {[S string 8 0 {} {} eq DTYP]} {
				>
					emit {\b, DTYP datatype description}
				<
			}
	
			if {[S string 8 0 {} {} eq PTCH]} {
				>
					emit {\b, PTCH binary patch}
				<
			}
	
			if {[S string 8 0 {} {} eq AMFF]} {
				>
					emit {\b, AMFF AmigaMetaFile format}
				<
			}
	
			if {[S string 8 0 {} {} eq WZRD]} {
				>
					emit {\b, WZRD StormWIZARD resource}
				<
			}
	
			if {[S string 8 0 {} {} eq DOC\ ]} {
				>
					emit {\b, DOC desktop publishing document}
				<
			}
	
			if {[S string 8 0 {} {} eq WVQA]} {
				>
					emit {\b, Westwood Studios VQA Multimedia,}
					if {[N leshort 24 0 0 {} {} x {}]} {
						>
							emit {%d video frames,}
						<
					}
	
					if {[N leshort 26 0 0 {} {} x {}]} {
						>
							emit {%d x}
						<
					}
	
					if {[N leshort 28 0 0 {} {} x {}]} {
						>
							emit %d
						<
					}
	
				<
			}
	
			if {[S string 8 0 {} {} eq MOVE]} {
				>
					emit {\b, Wing Commander III Video}
					if {[S string 12 0 {} {} eq _PC_]} {
						>
							emit {\b, PC version}
						<
					}
	
					if {[S string 12 0 {} {} eq 3DO_]} {
						>
							emit {\b, 3DO version}
						<
					}
	
				<
			}
	
			if {[S string 8 0 {} {} eq IFRS]} {
				>
					emit {\b, Blorb Interactive Fiction}
					if {[S string 24 0 {} {} eq Exec]} {
						>
							emit {with executable chunk}
						<
					}
	
				<
			}
	
			if {[S string 8 0 {} {} eq IFZS]} {
				>
					emit {\b, Z-machine or Glulx saved game file (Quetzal)}
					mime application/x-blorb
				<
			}
	
		<
	}
	
	if {[N ubequad 0 0 0 & 71710148363550912 == 0]} {
		>
			if {[N ubyte 2 0 0 {} {} > 0]} {
				>
					if {[N ubyte 2 0 0 {} {} < 34]} {
						>
							switch [Nv ubyte 16 0 {} {}] {
								1 {
									>
										U 111 tga-image 0
	
									<
								}
								8 {
									>
										U 111 tga-image 0
	
									<
								}
								15 {
									>
										U 111 tga-image 0
	
									<
								}
								16 {
									>
										U 111 tga-image 0
	
									<
								}
								24 {
									>
										U 111 tga-image 0
	
									<
								}
								32 {
									>
										U 111 tga-image 0
	
									<
								}
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S search 0 0 {} 1 eq P1]} {
		>
			if {[S regex 0 0 {} 4 eq P1\[\040\t\f\r\n\]]} {
				>
					U 111 netpbm 0
	
				<
			}
	
		<
	}
	
	if {[S search 0 0 {} 1 eq P2]} {
		>
			if {[S regex 0 0 {} 4 eq P2\[\040\t\f\r\n\]]} {
				>
					U 111 netpbm 0
	
				<
			}
	
		<
	}
	
	if {[S search 0 0 {} 1 eq P3]} {
		>
			if {[S regex 0 0 {} 4 eq P3\[\040\t\f\r\n\]]} {
				>
					U 111 netpbm 0
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq P4]} {
		>
			if {[S regex 0 0 {} 4 eq P4\[\040\t\f\r\n\]]} {
				>
					U 111 netpbm 0
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq P5]} {
		>
			if {[S regex 0 0 {} 4 eq P5\[\040\t\f\r\n\]]} {
				>
					U 111 netpbm 0
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq P6]} {
		>
			if {[S regex 0 0 {} 4 eq P6\[\040\t\f\r\n\]]} {
				>
					U 111 netpbm 0
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq P7]} {
		>
			emit {Netpbm PAM image file}
			mime image/x-portable-pixmap
		<
	}
	
	if {[S string 0 0 {} {} eq \117\072]} {
		>
			emit {Solitaire Image Recorder format}
			if {[S string 4 0 {} {} eq \013]} {
				>
					emit {MGI Type 11}
				<
			}
	
			if {[S string 4 0 {} {} eq \021]} {
				>
					emit {MGI Type 17}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq .MDA]} {
		>
			emit {MicroDesign data}
			switch [Nv byte 21 0 {} {}] {
				48 {
					>
						emit {version 2}
					<
				}
				51 {
					>
						emit {version 3}
					<
				}
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq .MDP]} {
		>
			emit {MicroDesign page data}
			switch [Nv byte 21 0 {} {}] {
				48 {
					>
						emit {version 2}
					<
				}
				51 {
					>
						emit {version 3}
					<
				}
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq IIN1]} {
		>
			emit {NIFF image data}
			mime image/x-niff
		<
	}
	
	if {[S string 0 0 {} {} eq II\x1a\0\0\0HEAPCCDR]} {
		>
			emit {Canon CIFF raw image data}
			if {[N leshort 16 0 0 {} {} x {}]} {
				>
					emit {\b, version %d.}
				<
			}
	
			if {[N leshort 14 0 0 {} {} x {}]} {
				>
					emit {\b%d}
				<
			}
	
			mime image/x-canon-crw
		<
	}
	
	if {[S string 0 0 {} {} eq II\x2a\0\x10\0\0\0CR]} {
		>
			emit {Canon CR2 raw image data}
			if {[N byte 10 0 0 {} {} x {}]} {
				>
					emit {\b, version %d.}
				<
			}
	
			if {[N byte 11 0 0 {} {} x {}]} {
				>
					emit {\b%d}
				<
			}
	
			mime image/x-canon-cr2
		<
	}
	
	if {[S string 0 0 {} {} eq MM\x00\x2a]} {
		>
			emit {TIFF image data, big-endian}
			U 111 tiff_ifd [I 4 ubelong 0 + 0 0]
	
			mime image/tiff
			strength +70
		<
	}
	
	if {[S string 0 0 {} {} eq II\x2a\x00]} {
		>
			emit {TIFF image data, little-endian}
			U 111 tiff_ifd [I 4 ulelong 0 + 0 0]
	
			mime image/tiff
			strength +70
		<
	}
	
	if {[S string 0 0 {} {} eq MM\x00\x2b]} {
		>
			emit {Big TIFF image data, big-endian}
			mime image/tiff
		<
	}
	
	if {[S string 0 0 {} {} eq II\x2b\x00]} {
		>
			emit {Big TIFF image data, little-endian}
			mime image/tiff
		<
	}
	
	if {[S string 0 0 {} {} eq \x89PNG\x0d\x0a\x1a\x0a\x00\x00\x00\x0DIHDR]} {
		>
			emit {PNG image data}
			U 111 png-ihdr 16
	
			mime image/png
			strength +10
		<
	}
	
	if {[S string 0 0 {} {} eq \x89PNG\x0d\x0a\x1a\x0a\x00\x00\x00\x04CgBI]} {
		>
			if {[S string 24 0 {} {} eq \x00\x00\x00\x0DIHDR]} {
				>
					emit {PNG image data (CgBI)}
					U 111 png-ihdr 32
	
					mime image/png
					strength +10
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq GIF94z]} {
		>
			emit {ZIF image (GIF+deflate alpha)}
			mime image/x-unknown
		<
	}
	
	if {[S string 0 0 {} {} eq FGF95a]} {
		>
			emit {FGF image (GIF+deflate beta)}
			mime image/x-unknown
		<
	}
	
	if {[S string 0 0 {} {} eq PBF]} {
		>
			emit {PBF image (deflate compression)}
			mime image/x-unknown
		<
	}
	
	if {[S string 0 0 {} {} eq GIF8]} {
		>
			emit {GIF image data}
			if {[S string 4 0 {} {} eq 7a]} {
				>
					emit {\b, version 8%s,}
				<
			}
	
			if {[S string 4 0 {} {} eq 9a]} {
				>
					emit {\b, version 8%s,}
				<
			}
	
			if {[N leshort 6 0 0 {} {} > 0]} {
				>
					emit {%d x}
				<
			}
	
			if {[N leshort 8 0 0 {} {} > 0]} {
				>
					emit %d
				<
			}
	
			mime image/gif
			strength +80
		<
	}
	
	if {[S string 0 0 {} {} eq \361\0\100\273]} {
		>
			emit {CMU window manager raster image data}
			if {[N lelong 4 0 0 {} {} > 0]} {
				>
					emit {%d x}
				<
			}
	
			if {[N lelong 8 0 0 {} {} > 0]} {
				>
					emit %d,
				<
			}
	
			if {[N lelong 12 0 0 {} {} > 0]} {
				>
					emit %d-bit
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq id=ImageMagick]} {
		>
			emit {MIFF image data}
		<
	}
	
	if {[S search 0 0 {} 1 eq \#FIG]} {
		>
			emit {FIG image text}
			if {[S string 5 0 {} {} x {}]} {
				>
					emit {\b, version %.3s}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq ARF_BEGARF]} {
		>
			emit {PHIGS clear text archive}
		<
	}
	
	if {[S string 0 0 {} {} eq @(\#)SunPHIGS]} {
		>
			emit SunPHIGS
			if {[S string 40 0 {} {} eq SunBin]} {
				>
					emit binary
				<
			}
	
			if {[S string 32 0 {} {} eq archive]} {
				>
					emit archive
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq GKSM]} {
		>
			emit {GKS Metafile}
			if {[S string 24 0 {} {} eq SunGKS]} {
				>
					emit {\b, SunGKS}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq BEGMF]} {
		>
			emit {clear text Computer Graphics Metafile}
		<
	}
	
	if {[S string 0 0 {} {} eq yz]} {
		>
			emit {MGR bitmap, modern format, 8-bit aligned}
		<
	}
	
	if {[S string 0 0 {} {} eq zz]} {
		>
			emit {MGR bitmap, old format, 1-bit deep, 16-bit aligned}
		<
	}
	
	if {[S string 0 0 {} {} eq xz]} {
		>
			emit {MGR bitmap, old format, 1-bit deep, 32-bit aligned}
		<
	}
	
	if {[S string 0 0 {} {} eq yx]} {
		>
			emit {MGR bitmap, modern format, squeezed}
		<
	}
	
	if {[S string 0 0 {} {} eq %bitmap\0]} {
		>
			emit {FBM image data}
			switch [Nv long 30 0 {} {}] {
				49 {
					>
						emit {\b, mono}
					<
				}
				51 {
					>
						emit {\b, color}
					<
				}
			}
	
		<
	}
	
	if {[S string 1 0 {} {} eq PC\ Research,\ Inc]} {
		>
			emit {group 3 fax data}
			switch [Nv byte 29 0 {} {}] {
				0 {
					>
						emit {\b, normal resolution (204x98 DPI)}
					<
				}
				1 {
					>
						emit {\b, fine resolution (204x196 DPI)}
					<
				}
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq Sfff]} {
		>
			emit {structured fax file}
		<
	}
	
	if {[S string 0 0 {} {} eq \x11\x06]} {
		>
			emit {Award BIOS Logo, 136 x 84}
			mime image/x-award-bioslogo
		<
	}
	
	if {[S string 0 0 {} {} eq \x11\x09]} {
		>
			emit {Award BIOS Logo, 136 x 126}
			mime image/x-award-bioslogo
		<
	}
	
	if {[S string 0 0 {} {} eq AWBM]} {
		>
			if {[N leshort 4 0 0 {} {} < 1981]} {
				>
					emit {Award BIOS bitmap}
					if {[N leshort 4 0 0 & 3 == 0]} {
						>
							if {[N leshort 4 0 0 {} {} x {}]} {
								>
									emit {\b, %d}
								<
							}
	
							if {[N leshort 6 0 0 {} {} x {}]} {
								>
									emit {x %d}
								<
							}
	
						<
					}
	
					if {[N leshort 4 0 0 & 3 > 0]} {
						>
							emit {\b,}
							switch [Nv leshort 4 0 & 3] {
								1 {
									>
										if {[N leshort 4 0 0 {} {} x {}]} {
											>
												emit %d+3
											<
										}
	
									<
								}
								2 {
									>
										if {[N leshort 4 0 0 {} {} x {}]} {
											>
												emit %d+2
											<
										}
	
									<
								}
								3 {
									>
										if {[N leshort 4 0 0 {} {} x {}]} {
											>
												emit %d+1
											<
										}
	
									<
								}
							}
	
							if {[N leshort 6 0 0 {} {} x {}]} {
								>
									emit {x %d}
								<
							}
	
						<
					}
	
					mime image/x-award-bmp
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq BM]} {
		>
			switch [Nv leshort 14 0 {} {}] {
				12 {
					>
						emit {PC bitmap, OS/2 1.x format}
						mime image/x-ms-bmp
						if {[N leshort 18 0 0 {} {} x {}]} {
							>
								emit {\b, %d x}
							<
						}
	
						if {[N leshort 20 0 0 {} {} x {}]} {
							>
								emit %d
							<
						}
	
					<
				}
				40 {
					>
						emit {PC bitmap, Windows 3.x format}
						mime image/x-ms-bmp
						if {[N lelong 18 0 0 {} {} x {}]} {
							>
								emit {\b, %d x}
							<
						}
	
						if {[N lelong 22 0 0 {} {} x {}]} {
							>
								emit {%d x}
							<
						}
	
						if {[N leshort 28 0 0 {} {} x {}]} {
							>
								emit %d
							<
						}
	
					<
				}
				64 {
					>
						emit {PC bitmap, OS/2 2.x format}
						mime image/x-ms-bmp
						if {[N leshort 18 0 0 {} {} x {}]} {
							>
								emit {\b, %d x}
							<
						}
	
						if {[N leshort 20 0 0 {} {} x {}]} {
							>
								emit %d
							<
						}
	
					<
				}
				108 {
					>
						emit {PC bitmap, Windows 95/NT4 and newer format}
						mime image/x-ms-bmp
						if {[N lelong 18 0 0 {} {} x {}]} {
							>
								emit {\b, %d x}
							<
						}
	
						if {[N lelong 22 0 0 {} {} x {}]} {
							>
								emit {%d x}
							<
						}
	
						if {[N leshort 28 0 0 {} {} x {}]} {
							>
								emit %d
							<
						}
	
					<
				}
				124 {
					>
						emit {PC bitmap, Windows 98/2000 and newer format}
						mime image/x-ms-bmp
						if {[N lelong 18 0 0 {} {} x {}]} {
							>
								emit {\b, %d x}
							<
						}
	
						if {[N lelong 22 0 0 {} {} x {}]} {
							>
								emit {%d x}
							<
						}
	
						if {[N leshort 28 0 0 {} {} x {}]} {
							>
								emit %d
							<
						}
	
					<
				}
				128 {
					>
						emit {PC bitmap, Windows NT/2000 format}
						mime image/x-ms-bmp
						if {[N lelong 18 0 0 {} {} x {}]} {
							>
								emit {\b, %d x}
							<
						}
	
						if {[N lelong 22 0 0 {} {} x {}]} {
							>
								emit {%d x}
							<
						}
	
						if {[N leshort 28 0 0 {} {} x {}]} {
							>
								emit %d
							<
						}
	
					<
				}
			}
	
		<
	}
	
	if {[S search 0 0 {} 1 eq /*\ XPM\ */]} {
		>
			emit {X pixmap image text}
			mime image/x-xpmi
		<
	}
	
	if {[S string 0 0 {} {} eq Imagefile\ version-]} {
		>
			emit {iff image data}
			if {[S string 10 0 {} {} > \0]} {
				>
					emit %s
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq IT01]} {
		>
			emit {FIT image data}
			if {[N belong 4 0 0 {} {} x {}]} {
				>
					emit {\b, %d x}
				<
			}
	
			if {[N belong 8 0 0 {} {} x {}]} {
				>
					emit {%d x}
				<
			}
	
			if {[N belong 12 0 0 {} {} x {}]} {
				>
					emit %d
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq IT02]} {
		>
			emit {FIT image data}
			if {[N belong 4 0 0 {} {} x {}]} {
				>
					emit {\b, %d x}
				<
			}
	
			if {[N belong 8 0 0 {} {} x {}]} {
				>
					emit {%d x}
				<
			}
	
			if {[N belong 12 0 0 {} {} x {}]} {
				>
					emit %d
				<
			}
	
		<
	}
	
	if {[S string 2048 0 {} {} eq PCD_IPI]} {
		>
			emit {Kodak Photo CD image pack file}
			switch [Nv byte 3586 0 & 3] {
				0 {
					>
						emit {, landscape mode}
					<
				}
				1 {
					>
						emit {, portrait mode}
					<
				}
				2 {
					>
						emit {, landscape mode}
					<
				}
				3 {
					>
						emit {, portrait mode}
					<
				}
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq PCD_OPA]} {
		>
			emit {Kodak Photo CD overview pack file}
		<
	}
	
	if {[S string 0 0 {} {} eq SIMPLE\ \ =]} {
		>
			emit {FITS image data}
			if {[S string 109 0 {} {} eq 8]} {
				>
					emit {\b, 8-bit, character or unsigned binary integer}
				<
			}
	
			if {[S string 108 0 {} {} eq 16]} {
				>
					emit {\b, 16-bit, two's complement binary integer}
				<
			}
	
			if {[S string 107 0 {} {} eq \ 32]} {
				>
					emit {\b, 32-bit, two's complement binary integer}
				<
			}
	
			if {[S string 107 0 {} {} eq -32]} {
				>
					emit {\b, 32-bit, floating point, single precision}
				<
			}
	
			if {[S string 107 0 {} {} eq -64]} {
				>
					emit {\b, 64-bit, floating point, double precision}
				<
			}
	
			mime image/fits
			ext fits/fts
		<
	}
	
	if {[S string 0 0 {} {} eq This\ is\ a\ BitMap\ file]} {
		>
			emit {Lisp Machine bit-array-file}
		<
	}
	
	if {[S string 128 0 {} {} eq DICM]} {
		>
			emit {DICOM medical imaging data}
			mime application/dicom
			ext dcm/dicom/dic
		<
	}
	
	if {[N belong 0 0 0 {} {} > 100]} {
		>
			if {[N belong 8 0 0 {} {} < 3]} {
				>
					if {[N belong 12 0 0 {} {} < 33]} {
						>
							if {[N belong 4 0 0 {} {} == 7]} {
								>
									emit {XWD X Window Dump image data}
									if {[S string 100 0 {} {} > \0]} {
										>
											emit {\b, "%s"}
										<
									}
	
									if {[N belong 16 0 0 {} {} x {}]} {
										>
											emit {\b, %dx}
										<
									}
	
									if {[N belong 20 0 0 {} {} x {}]} {
										>
											emit {\b%dx}
										<
									}
	
									if {[N belong 12 0 0 {} {} x {}]} {
										>
											emit {\b%d}
										<
									}
	
									mime image/x-xwindowdump
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq NJPL1I00]} {
		>
			emit {PDS (JPL) image data}
		<
	}
	
	if {[S string 2 0 {} {} eq NJPL1I]} {
		>
			emit {PDS (JPL) image data}
		<
	}
	
	if {[S string 0 0 {} {} eq CCSD3ZF]} {
		>
			emit {PDS (CCSD) image data}
		<
	}
	
	if {[S string 2 0 {} {} eq CCSD3Z]} {
		>
			emit {PDS (CCSD) image data}
		<
	}
	
	if {[S string 0 0 {} {} eq PDS_]} {
		>
			emit {PDS image data}
		<
	}
	
	if {[S string 0 0 {} {} eq LBLSIZE=]} {
		>
			emit {PDS (VICAR) image data}
		<
	}
	
	if {[S string 0 0 {} {} eq pM85]} {
		>
			emit {Atari ST STAD bitmap image data (hor)}
			switch [Nv byte 5 0 {} {}] {
				-1 {
					>
						emit {(black background)}
					<
				}
				0 {
					>
						emit {(white background)}
					<
				}
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq pM86]} {
		>
			emit {Atari ST STAD bitmap image data (vert)}
			switch [Nv byte 5 0 {} {}] {
				-1 {
					>
						emit {(black background)}
					<
				}
				0 {
					>
						emit {(white background)}
					<
				}
			}
	
		<
	}
	
	if {[N ubelong 0 0 0 & 4294508032 == 167772160]} {
		>
			if {[N ubyte 3 0 0 {} {} > 0]} {
				>
					if {[N ubyte 1 0 0 {} {} < 6]} {
						>
							if {[N ubyte 1 0 0 {} {} != 1]} {
								>
									emit PCX
									switch [Nv ubyte 1 0 {} {}] {
										0 {
											>
												emit {ver. 2.5 image data}
											<
										}
										2 {
											>
												emit {ver. 2.8 image data, with palette}
											<
										}
										3 {
											>
												emit {ver. 2.8 image data, without palette}
											<
										}
										4 {
											>
												emit {for Windows image data}
											<
										}
										5 {
											>
												emit {ver. 3.0 image data}
											<
										}
									}
	
									if {[N uleshort 4 0 0 {} {} x {}]} {
										>
											emit {bounding box [%d,}
										<
									}
	
									if {[N uleshort 6 0 0 {} {} x {}]} {
										>
											emit {%d] -}
										<
									}
	
									if {[N uleshort 8 0 0 {} {} x {}]} {
										>
											emit {[%d,}
										<
									}
	
									if {[N uleshort 10 0 0 {} {} x {}]} {
										>
											emit %d\],
										<
									}
	
									if {[N ubyte 65 0 0 {} {} > 1]} {
										>
											emit {%d planes each of}
										<
									}
	
									if {[N ubyte 3 0 0 {} {} x {}]} {
										>
											emit %d-bit
										<
									}
	
									switch [Nv byte 68 0 {} {}] {
										1 {
											>
												emit colour,
											<
										}
										2 {
											>
												emit grayscale,
											<
										}
									}
	
									if {[D 68]} {
										>
											emit image,
										<
									}
	
									if {[N leshort 12 0 0 {} {} > 0]} {
										>
											emit {%d x}
											if {[N uleshort 14 0 0 {} {} x {}]} {
												>
													emit {%d dpi,}
												<
											}
	
										<
									}
	
									switch [Nv byte 2 0 {} {}] {
										0 {
											>
												emit uncompressed
											<
										}
										1 {
											>
												emit {RLE compressed}
											<
										}
									}
	
									mime image/x-pcx
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq 8BPS]} {
		>
			emit {Adobe Photoshop Image}
			if {[N beshort 4 0 0 {} {} == 2]} {
				>
					emit (PSB)
				<
			}
	
			if {[N belong 18 0 0 {} {} x {}]} {
				>
					emit {\b, %d x}
				<
			}
	
			if {[N belong 14 0 0 {} {} x {}]} {
				>
					emit %d,
				<
			}
	
			switch [Nv beshort 24 0 {} {}] {
				0 {
					>
						emit bitmap
					<
				}
				1 {
					>
						emit grayscale
						if {[N beshort 12 0 0 {} {} == 2]} {
							>
								emit {with alpha}
							<
						}
	
					<
				}
				2 {
					>
						emit indexed
					<
				}
				3 {
					>
						emit RGB
						if {[N beshort 12 0 0 {} {} == 4]} {
							>
								emit {\bA}
							<
						}
	
					<
				}
				4 {
					>
						emit CMYK
						if {[N beshort 12 0 0 {} {} == 5]} {
							>
								emit {\bA}
							<
						}
	
					<
				}
				7 {
					>
						emit multichannel
					<
				}
				8 {
					>
						emit duotone
					<
				}
				9 {
					>
						emit lab
					<
				}
			}
	
			if {[N beshort 12 0 0 {} {} > 1]} {
				>
					if {[N beshort 12 0 0 {} {} x {}]} {
						>
							emit {\b, %dx}
						<
					}
	
				<
			}
	
			if {[N beshort 12 0 0 {} {} == 1]} {
				>
					emit {\b,}
				<
			}
	
			if {[N beshort 22 0 0 {} {} x {}]} {
				>
					emit {%d-bit channel}
				<
			}
	
			if {[N beshort 12 0 0 {} {} > 1]} {
				>
					emit {\bs}
				<
			}
	
			mime image/vnd.adobe.photoshop
		<
	}
	
	if {[S string 0 0 {} {} eq P7\ 332]} {
		>
			emit {XV thumbnail image data}
		<
	}
	
	if {[S string 0 0 {} {} eq NITF]} {
		>
			emit {National Imagery Transmission Format}
			if {[S string 25 0 {} {} > \0]} {
				>
					emit {dated %.14s}
				<
			}
	
		<
	}
	
	if {[S string 16 0 {} {} eq XIMG\0]} {
		>
			U 111 gem_info 0
	
		<
	}
	
	if {[S string 16 0 {} {} eq STTT\0\x10]} {
		>
			U 111 gem_info 0
	
		<
	}
	
	if {[S string 16 0 {} {} eq TIMG\0]} {
		>
			U 111 gem_info 0
	
		<
	}
	
	if {[S string 0 0 {} {} eq \0\nSMJPEG]} {
		>
			emit SMJPEG
			if {[N belong 8 0 0 {} {} x {}]} {
				>
					emit {%d.x data}
				<
			}
	
			if {[S string 16 0 {} {} eq _SND]} {
				>
					emit {\b,}
					if {[N beshort 24 0 0 {} {} > 0]} {
						>
							emit {%d Hz}
						<
					}
	
					switch [Nv byte 26 0 {} {}] {
						8 {
							>
								emit 8-bit
							<
						}
						16 {
							>
								emit 16-bit
							<
						}
					}
	
					if {[S string 28 0 {} {} eq NONE]} {
						>
							emit uncompressed
						<
					}
	
					if {[N byte 27 0 0 {} {} == 1]} {
						>
							emit mono
						<
					}
	
					if {[N byte 28 0 0 {} {} == 2]} {
						>
							emit stereo
						<
					}
	
					if {[S string 32 0 {} {} eq _VID]} {
						>
							emit {\b,}
							if {[N belong 40 0 0 {} {} > 0]} {
								>
									emit {%d frames}
								<
							}
	
							if {[N beshort 44 0 0 {} {} > 0]} {
								>
									emit {(%d x}
								<
							}
	
							if {[N beshort 46 0 0 {} {} > 0]} {
								>
									emit %d)
								<
							}
	
						<
					}
	
				<
			}
	
			if {[S string 16 0 {} {} eq _VID]} {
				>
					emit {\b,}
					if {[N belong 24 0 0 {} {} > 0]} {
						>
							emit {%d frames}
						<
					}
	
					if {[N beshort 28 0 0 {} {} > 0]} {
						>
							emit {(%d x}
						<
					}
	
					if {[N beshort 30 0 0 {} {} > 0]} {
						>
							emit %d)
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq Paint\ Shop\ Pro\ Image\ File]} {
		>
			emit {Paint Shop Pro Image File}
		<
	}
	
	if {[S string 0 0 {} {} eq P7\ 332]} {
		>
			emit {XV "thumbnail file" (icon) data}
		<
	}
	
	if {[S string 0 0 {} {} eq KiSS]} {
		>
			emit KISS/GS
			switch [Nv byte 4 0 {} {}] {
				16 {
					>
						emit color
						if {[N byte 5 0 0 {} {} x {}]} {
							>
								emit {%d bit}
							<
						}
	
						if {[N leshort 8 0 0 {} {} x {}]} {
							>
								emit {%d colors}
							<
						}
	
						if {[N leshort 10 0 0 {} {} x {}]} {
							>
								emit {%d groups}
							<
						}
	
					<
				}
				32 {
					>
						emit cell
						if {[N byte 5 0 0 {} {} x {}]} {
							>
								emit {%d bit}
							<
						}
	
						if {[N leshort 8 0 0 {} {} x {}]} {
							>
								emit {%d x}
							<
						}
	
						if {[N leshort 10 0 0 {} {} x {}]} {
							>
								emit %d
							<
						}
	
						if {[N leshort 12 0 0 {} {} x {}]} {
							>
								emit +%d
							<
						}
	
						if {[N leshort 14 0 0 {} {} x {}]} {
							>
								emit +%d
							<
						}
	
					<
				}
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq C\253\221g\230\0\0\0]} {
		>
			emit {Webshots Desktop .wbz file}
		<
	}
	
	if {[S string 0 0 {} {} eq CKD_P370]} {
		>
			emit {Hercules CKD DASD image file}
			if {[N long 8 0 0 {} {} x {}]} {
				>
					emit {\b, %d heads per cylinder}
				<
			}
	
			if {[N long 12 0 0 {} {} x {}]} {
				>
					emit {\b, track size %d bytes}
				<
			}
	
			if {[N byte 16 0 0 {} {} x {}]} {
				>
					emit {\b, device type 33%2.2X}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq CKD_C370]} {
		>
			emit {Hercules compressed CKD DASD image file}
			if {[N long 8 0 0 {} {} x {}]} {
				>
					emit {\b, %d heads per cylinder}
				<
			}
	
			if {[N long 12 0 0 {} {} x {}]} {
				>
					emit {\b, track size %d bytes}
				<
			}
	
			if {[N byte 16 0 0 {} {} x {}]} {
				>
					emit {\b, device type 33%2.2X}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq CKD_S370]} {
		>
			emit {Hercules CKD DASD shadow file}
			if {[N long 8 0 0 {} {} x {}]} {
				>
					emit {\b, %d heads per cylinder}
				<
			}
	
			if {[N long 12 0 0 {} {} x {}]} {
				>
					emit {\b, track size %d bytes}
				<
			}
	
			if {[N byte 16 0 0 {} {} x {}]} {
				>
					emit {\b, device type 33%2.2X}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \146\031\0\0]} {
		>
			emit {Squeak image data}
		<
	}
	
	if {[S search 0 0 {} 1 eq 'From\040Squeak]} {
		>
			emit {Squeak program text}
		<
	}
	
	if {[S string 0 0 {} {} eq PaRtImAgE-VoLuMe]} {
		>
			emit PartImage
			if {[S string 32 0 {} {} eq 0.6.1]} {
				>
					emit {file version %s}
					if {[N lelong 96 0 0 {} {} > -1]} {
						>
							emit {volume %d}
						<
					}
	
					if {[S string 512 0 {} {} > \0]} {
						>
							emit {type %s}
						<
					}
	
					if {[S string 5120 0 {} {} > \0]} {
						>
							emit {device %s,}
						<
					}
	
					if {[S string 5632 0 {} {} > \0]} {
						>
							emit {original filename %s,}
						<
					}
	
					switch [Nv lelong 10052 0 {} {}] {
						0 {
							>
								emit {not compressed}
							<
						}
						1 {
							>
								emit {gzip compressed}
							<
						}
						2 {
							>
								emit {bzip2 compressed}
							<
						}
					}
	
					if {[N lelong 10052 0 0 {} {} > 2]} {
						>
							emit {compressed with unknown algorithm}
						<
					}
	
				<
			}
	
			if {[S string 32 0 {} {} > 0.6.1]} {
				>
					emit {file version %s}
				<
			}
	
			if {[S string 32 0 {} {} < 0.6.1]} {
				>
					emit {file version %s}
				<
			}
	
		<
	}
	
	if {[N leshort 14 0 0 {} {} < 2]} {
		>
			if {[N leshort 62 0 0 {} {} < 2]} {
				>
					if {[N leshort 54 0 0 {} {} == 12345]} {
						>
							emit {Bio-Rad .PIC Image File}
							if {[N leshort 0 0 0 {} {} > 0]} {
								>
									emit {%d x}
								<
							}
	
							if {[N leshort 2 0 0 {} {} > 0]} {
								>
									emit %d,
								<
							}
	
							if {[N leshort 4 0 0 {} {} == 1]} {
								>
									emit {1 image in file}
								<
							}
	
							if {[N leshort 4 0 0 {} {} > 1]} {
								>
									emit {%d images in file}
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \000MRM]} {
		>
			emit {Minolta Dimage camera raw image data}
		<
	}
	
	if {[S string 0 0 {} {} eq AT&TFORM]} {
		>
			if {[S string 12 0 {} {} eq DJVM]} {
				>
					emit {DjVu multiple page document}
					mime image/vnd.djvu
				<
			}
	
			if {[S string 12 0 {} {} eq DJVU]} {
				>
					emit {DjVu image or single page document}
					mime image/vnd.djvu
				<
			}
	
			if {[S string 12 0 {} {} eq DJVI]} {
				>
					emit {DjVu shared document}
					mime image/vnd.djvu
				<
			}
	
			if {[S string 12 0 {} {} eq THUM]} {
				>
					emit {DjVu page thumbnails}
					mime image/vnd.djvu
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq SDPX]} {
		>
			emit {DPX image data, big-endian,}
			U 111 dpx_info 0
	
			mime image/x-dpx
		<
	}
	
	if {[S string 0 0 {} {} eq XPDS]} {
		>
			emit {DPX image data, little-endian,}
			U 111 dpx_info 0
	
			mime image/x-dpx
		<
	}
	
	if {[S string 0 0 {} {} eq CDF\001]} {
		>
			emit {NetCDF Data Format data}
		<
	}
	
	if {[S string 0 0 {} {} eq \211HDF\r\n\032\n]} {
		>
			emit {Hierarchical Data Format (version 5) data}
			mime application/x-hdf
		<
	}
	
	if {[S string 512 0 {} {} eq \211HDF\r\n\032\n]} {
		>
			emit {Hierarchical Data Format (version 5) with 512 bytes user block}
			mime application/x-hdf
		<
	}
	
	if {[S string 1024 0 {} {} eq \211HDF\r\n\032\n]} {
		>
			emit {Hierarchical Data Format (version 5) with 1k user block}
			mime application/x-hdf
		<
	}
	
	if {[S string 2048 0 {} {} eq \211HDF\r\n\032\n]} {
		>
			emit {Hierarchical Data Format (version 5) with 2k user block}
			mime application/x-hdf
		<
	}
	
	if {[S string 4096 0 {} {} eq \211HDF\r\n\032\n]} {
		>
			emit {Hierarchical Data Format (version 5) with 4k user block}
			mime application/x-hdf
		<
	}
	
	if {[S string 0 0 {} {} eq XARA\243\243]} {
		>
			emit {Xara graphics file}
		<
	}
	
	if {[S string 0 0 {} {} eq CPC\262]} {
		>
			emit {Cartesian Perceptual Compression image}
			mime image/x-cpi
		<
	}
	
	if {[S string 0 0 {} {} eq C565]} {
		>
			emit {OLPC firmware icon image data}
			if {[N leshort 4 0 0 {} {} x {}]} {
				>
					emit {%u x}
				<
			}
	
			if {[N leshort 6 0 0 {} {} x {}]} {
				>
					emit %u
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \xce\xda\xde\xfa]} {
		>
			emit {Cytovision Metaphases file}
		<
	}
	
	if {[S string 0 0 {} {} eq \xed\xad\xef\xac]} {
		>
			emit {Cytovision Karyotype file}
		<
	}
	
	if {[S string 0 0 {} {} eq \x0b\x00\x03\x00]} {
		>
			emit {Cytovision FISH Probe file}
		<
	}
	
	if {[S string 0 0 {} {} eq \xed\xfe\xda\xbe]} {
		>
			emit {Cytovision FLEX file}
		<
	}
	
	if {[S string 0 0 {} {} eq \xed\xab\xed\xfe]} {
		>
			emit {Cytovision FLEX file}
		<
	}
	
	if {[S string 0 0 {} {} eq \xad\xfd\xea\xad]} {
		>
			emit {Cytovision RATS file}
		<
	}
	
	if {[S string 0 0 {} {} eq \xff\xa0\xff\xa8\x00]} {
		>
			emit {Wavelet Scalar Quantization image data}
		<
	}
	
	if {[S string 0 0 b {} eq PCO-]} {
		>
			emit {PCO B16 image data}
			if {[N lelong 12 0 0 {} {} x {}]} {
				>
					emit {\b, %dx}
				<
			}
	
			if {[N lelong 16 0 0 {} {} x {}]} {
				>
					emit {\b%d}
				<
			}
	
			switch [Nv lelong 20 0 {} {}] {
				-1 {
					>
						emit {\b, extended header}
						switch [Nv lelong 24 0 {} {}] {
							0 {
								>
									emit {\b, grayscale}
									switch [Nv lelong 36 0 {} {}] {
										0 {
											>
												emit {linear LUT}
											<
										}
										1 {
											>
												emit {logarithmic LUT}
											<
										}
									}
	
									if {[N lelong 28 0 0 {} {} x {}]} {
										>
											emit {[%d}
										<
									}
	
									if {[N lelong 32 0 0 {} {} x {}]} {
										>
											emit {\b,%d]}
										<
									}
	
								<
							}
							1 {
								>
									emit {\b, color}
									switch [Nv lelong 64 0 {} {}] {
										0 {
											>
												emit {linear LUT}
											<
										}
										1 {
											>
												emit {logarithmic LUT}
											<
										}
									}
	
									if {[N lelong 40 0 0 {} {} x {}]} {
										>
											emit {r[%d}
										<
									}
	
									if {[N lelong 44 0 0 {} {} x {}]} {
										>
											emit {\b,%d]}
										<
									}
	
									if {[N lelong 48 0 0 {} {} x {}]} {
										>
											emit {g[%d}
										<
									}
	
									if {[N lelong 52 0 0 {} {} x {}]} {
										>
											emit {\b,%d]}
										<
									}
	
									if {[N lelong 56 0 0 {} {} x {}]} {
										>
											emit {b[%d}
										<
									}
	
									if {[N lelong 60 0 0 {} {} x {}]} {
										>
											emit {\b,%d]}
										<
									}
	
								<
							}
						}
	
					<
				}
				0 {
					>
						emit {\b, short header}
					<
				}
			}
	
		<
	}
	
	if {[S string 0 0 t {} eq \[BitmapInfo2\]]} {
		>
			emit {Polar Monitor Bitmap text}
			mime image/x-polar-monitor-bitmap
		<
	}
	
	if {[S string 0 0 {} {} eq GARMIN\ BITMAP\ 01]} {
		>
			emit {Garmin Bitmap file}
			if {[S string 47 0 {} {} > 0]} {
				>
					emit {\b, version %4.4s}
				<
			}
	
			if {[N uleshort 85 0 0 {} {} > 0]} {
				>
					emit {\b, %dx}
					if {[N uleshort 83 0 0 {} {} x {}]} {
						>
							emit {\b%d}
						<
					}
	
				<
			}
	
			ext srf
		<
	}
	
	if {[S string 0 0 {} {} eq IIO2H]} {
		>
			emit {Ulead Photo Explorer5}
		<
	}
	
	if {[S string 0 0 {} {} eq Xcur]} {
		>
			emit {X11 cursor}
		<
	}
	
	if {[S string 0 0 {} {} eq MMOR]} {
		>
			emit {Olympus ORF raw image data, big-endian}
			mime image/x-olympus-orf
		<
	}
	
	if {[S string 0 0 {} {} eq IIRO]} {
		>
			emit {Olympus ORF raw image data, little-endian}
			mime image/x-olympus-orf
		<
	}
	
	if {[S string 0 0 {} {} eq IIRS]} {
		>
			emit {Olympus ORF raw image data, little-endian}
			mime image/x-olympus-orf
		<
	}
	
	if {[S string 0 0 {} {} eq HDMV0100]} {
		>
			emit {AVCHD Clip Information}
		<
	}
	
	if {[S string 0 0 {} {} eq \#?RADIANCE\n]} {
		>
			emit {Radiance HDR image data}
		<
	}
	
	if {[S string 0 0 {} {} eq PFS1\x0a]} {
		>
			emit {PFS HDR image data}
			if {[S regex 1 0 {} {} eq \[0-9\]*\ ]} {
				>
					emit {\b, %s}
					if {[S regex 1 0 {} {} eq \ \[0-9\]\{4\}]} {
						>
							emit {\bx%s}
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq FOVb]} {
		>
			emit {Foveon X3F raw image data}
			if {[N leshort 6 0 0 {} {} x {}]} {
				>
					emit {\b, version %d.}
				<
			}
	
			if {[N leshort 4 0 0 {} {} x {}]} {
				>
					emit {\b%d}
				<
			}
	
			if {[N lelong 28 0 0 {} {} x {}]} {
				>
					emit {\b, %dx}
				<
			}
	
			if {[N lelong 32 0 0 {} {} x {}]} {
				>
					emit {\b%d}
				<
			}
	
			mime image/x-x3f
		<
	}
	
	if {[S string 0 0 {} {} eq PDN3]} {
		>
			emit {Paint.NET image data}
			mime image/x-paintnet
		<
	}
	
	if {[S string 0 0 {} {} eq \x46\x4d\x52\x00]} {
		>
			emit {ISO/IEC 19794-2 Format Minutiae Record (FMR)}
		<
	}
	
	if {[N bequad 90 0 0 {} {} == 6290772526005243648]} {
		>
			emit {JPEG-XR Image}
			if {[N byte 98 0 0 & 8 == 8]} {
				>
					emit {\b, hard tiling}
				<
			}
	
			if {[N byte 99 0 0 & -128 == -128]} {
				>
					emit {\b, tiling present}
				<
			}
	
			if {[N byte 99 0 0 & 64 == 64]} {
				>
					emit {\b, codestream present}
				<
			}
	
			if {[N byte 99 0 0 & 56 x {}]} {
				>
					emit {\b, spatial xform=}
				<
			}
	
			switch [Nv byte 99 0 & 56] {
				0 {
					>
						emit {\bTL}
					<
				}
				8 {
					>
						emit {\bBL}
					<
				}
				16 {
					>
						emit {\bTR}
					<
				}
				24 {
					>
						emit {\bBR}
					<
				}
				32 {
					>
						emit {\bBT}
					<
				}
				40 {
					>
						emit {\bRB}
					<
				}
				48 {
					>
						emit {\bLT}
					<
				}
				56 {
					>
						emit {\bLB}
					<
				}
			}
	
			switch [Nv byte 100 0 & -128] {
				-128 {
					>
						emit {\b, short header}
						if {[N beshort 102 0 0 + 1 x {}]} {
							>
								emit {\b, %d}
							<
						}
	
						if {[N beshort 104 0 0 + 1 x {}]} {
							>
								emit {\bx%d}
							<
						}
	
					<
				}
				0 {
					>
						emit {\b, long header}
						if {[N belong 102 0 0 + 1 x {}]} {
							>
								emit {\b, %x}
							<
						}
	
						if {[N belong 106 0 0 + 1 x {}]} {
							>
								emit {\bx%x}
							<
						}
	
					<
				}
			}
	
			if {[N beshort 101 0 0 & 15 x {}]} {
				>
					emit {\b, bitdepth=}
					switch [Nv beshort 101 0 & 15] {
						0 {
							>
								emit {\b1-WHITE=1}
							<
						}
						1 {
							>
								emit {\b8}
							<
						}
						2 {
							>
								emit {\b16}
							<
						}
						3 {
							>
								emit {\b16-SIGNED}
							<
						}
						4 {
							>
								emit {\b16-FLOAT}
							<
						}
						5 {
							>
								emit {\b(reserved 5)}
							<
						}
						6 {
							>
								emit {\b32-SIGNED}
							<
						}
						7 {
							>
								emit {\b32-FLOAT}
							<
						}
						8 {
							>
								emit {\b5}
							<
						}
						9 {
							>
								emit {\b10}
							<
						}
						10 {
							>
								emit {\b5-6-5}
							<
						}
						11 {
							>
								emit {\b(reserved %d)}
							<
						}
						12 {
							>
								emit {\b(reserved %d)}
							<
						}
						13 {
							>
								emit {\b(reserved %d)}
							<
						}
						14 {
							>
								emit {\b(reserved %d)}
							<
						}
						15 {
							>
								emit {\b1-BLACK=1}
							<
						}
					}
	
				<
			}
	
			if {[N beshort 101 0 0 & 240 x {}]} {
				>
					emit {\b, colorfmt=}
					switch [Nv beshort 101 0 & 240] {
						0 {
							>
								emit {\bYONLY}
							<
						}
						16 {
							>
								emit {\bYUV240}
							<
						}
						32 {
							>
								emit {\bYWV422}
							<
						}
						48 {
							>
								emit {\bYWV444}
							<
						}
						64 {
							>
								emit {\bCMYK}
							<
						}
						80 {
							>
								emit {\bCMYKDIRECT}
							<
						}
						96 {
							>
								emit {\bNCOMPONENT}
							<
						}
						112 {
							>
								emit {\bRGB}
							<
						}
						128 {
							>
								emit {\bRGBE}
							<
						}
					}
	
					if {[N beshort 101 0 0 & 240 > 128]} {
						>
							emit {\b(reserved 0x%x)}
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \x42\x50\x47\xFB]} {
		>
			emit {BPG (Better Portable Graphics)}
			mime image/bpg
		<
	}
	
	if {[S string 0 0 {} {} eq icns]} {
		>
			emit {Mac OS X icon}
			if {[N ubelong 4 0 0 {} {} > 0]} {
				>
					if {[N ubelong 4 0 0 {} {} x {}]} {
						>
							emit {\b, %d bytes}
						<
					}
	
					if {[S string 8 0 {} {} x {}]} {
						>
							emit {\b, "%4.4s" type}
						<
					}
	
				<
			}
	
			mime image/x-icns
			ext icns
		<
	}
	
	if {[S string 0 0 {} {} eq farbfeld]} {
		>
			emit {farbfeld image data,}
			if {[N ubelong 8 0 0 {} {} x {}]} {
				>
					emit %dx
				<
			}
	
			if {[N ubelong 12 0 0 {} {} x {}]} {
				>
					emit {\b%d}
				<
			}
	
		<
	}
	
	if {[S string 0 0 b {} eq DDS\040\174\000\000\000]} {
		>
			emit {Microsoft DirectDraw Surface (DDS):}
			U 111 ms-directdraw-surface 0
	
		<
	}
	
	if {[S string 0 0 {} {} eq PVRT]} {
		>
			if {[S string 16 0 {} {} eq DDS\040\174\000\000\000]} {
				>
					emit {Sega PVR (Xbox) image:}
					U 111 ms-directdraw-surface 32
	
				<
			}
	
			if {[N belong 16 0 0 {} {} != 1145328416]} {
				>
					emit {Sega PVR image:}
					U 111 sega-pvr-image-header 0
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq GBIX]} {
		>
			if {[S string 16 0 {} {} eq PVRT]} {
				>
					if {[S string 16 0 {} {} eq DDS\040\174\000\000\000]} {
						>
							emit {Sega PVR (Xbox) image:}
						<
					}
	
					U 111 ms-directdraw-surface 32
	
					if {[N belong 16 0 0 {} {} != 1145328416]} {
						>
							emit {Sega PVR image:}
							U 111 sega-pvr-image-header 16
	
						<
					}
	
					if {[N lelong 8 0 0 {} {} x {}]} {
						>
							emit {\b, global index = %u}
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq GVRT]} {
		>
			emit {Sega GVR image:}
			U 111 sega-gvr-image-header 16
	
		<
	}
	
	if {[S string 0 0 {} {} eq GBIX]} {
		>
			if {[S string 16 0 {} {} eq GVRT]} {
				>
					emit {Sega GVR image:}
					U 111 sega-gvr-image-header 16
	
					if {[N belong 8 0 0 {} {} x {}]} {
						>
							emit {\b, global index = %u}
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq GCIX]} {
		>
			if {[S string 16 0 {} {} eq GVRT]} {
				>
					emit {Sega GVR image:}
					U 111 sega-gvr-image-header 16
	
					if {[N belong 8 0 0 {} {} x {}]} {
						>
							emit {\b, global index = %u}
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq CI]} {
		>
			if {[N leshort 2 0 0 {} {} == 44]} {
				>
					emit {Vision Research CINE Video,}
					switch [Nv leshort 4 0 {} {}] {
						0 {
							>
								emit Grayscale,
							<
						}
						1 {
							>
								emit {JPEG Compressed,}
							<
						}
						2 {
							>
								emit RAW,
							<
						}
					}
	
					if {[N leshort 6 0 0 {} {} x {}]} {
						>
							emit {version %d,}
						<
					}
	
					if {[N lelong 20 0 0 {} {} x {}]} {
						>
							emit {%d frames,}
						<
					}
	
					if {[N lelong 48 0 0 {} {} x {}]} {
						>
							emit %dx
						<
					}
	
					if {[N lelong 52 0 0 {} {} x {}]} {
						>
							emit {\b%d}
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq ARRI]} {
		>
			emit {ARRI ARI image data,}
			switch [Nv lelong 4 0 {} {}] {
				305419896 {
					>
						emit big-endian,
					<
				}
				2018915346 {
					>
						emit little-endian,
					<
				}
			}
	
			if {[N lelong 12 0 0 {} {} x {}]} {
				>
					emit {version %d,}
				<
			}
	
			if {[N lelong 20 0 0 {} {} x {}]} {
				>
					emit %dx
				<
			}
	
			if {[N lelong 24 0 0 {} {} x {}]} {
				>
					emit {\b%d}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \xABKTX\ 11\xBB\r\n\x1A\n]} {
		>
			emit {Khronos KTX texture}
			if {[N lelong 12 0 0 {} {} == 67305985]} {
				>
					emit (little-endian)
					U 111 khronos-ktx-endian-header 16
	
				<
			}
	
			if {[N belong 12 0 0 {} {} == 67305985]} {
				>
					emit (big-endian)
					U 111 khronos-ktx-endian-header 16
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq VTF\0]} {
		>
			emit {Valve Texture Format}
			if {[N lelong 4 0 0 {} {} x {}]} {
				>
					emit v%u
				<
			}
	
			if {[N lelong 8 0 0 {} {} x {}]} {
				>
					emit {\b.%u}
				<
			}
	
			if {[N leshort 16 0 0 {} {} x {}]} {
				>
					emit {\b, %u}
				<
			}
	
			if {[N leshort 18 0 0 {} {} > 1]} {
				>
					emit {x %u}
				<
			}
	
			if {[N lequad 4 0 0 {} {} == 30064771074]} {
				>
					if {[N leshort 63 0 0 {} {} > 1]} {
						>
							emit {x %u}
						<
					}
	
				<
			}
	
			if {[N leshort 24 0 0 {} {} > 1]} {
				>
					emit {\b, %u frames}
				<
			}
	
			if {[N byte 56 0 0 {} {} x {}]} {
				>
					emit {\b, mipmaps: %u}
				<
			}
	
			if {[N lelong 52 0 0 {} {} > -1]} {
				>
					emit {\b,}
					U 111 vtf-image-format 52
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq VTF3]} {
		>
			emit {Valve Texture Format (PS3)}
			if {[N beshort 20 0 0 {} {} x {}]} {
				>
					emit {\b, %u}
				<
			}
	
			if {[N beshort 22 0 0 {} {} x {}]} {
				>
					emit {\b x %u}
				<
			}
	
			switch [Nv belong 16 0 & 8192] {
				0 {
					>
						emit {\b, DXT1}
					<
				}
				8192 {
					>
						emit {\b, DXT5}
					<
				}
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq DanM]} {
		>
			emit {icrosoft Paint image data (version 1.x)}
			if {[N leshort 4 0 0 {} {} x {}]} {
				>
					emit (%d
					if {[N leshort 6 0 0 {} {} x {}]} {
						>
							emit {x %d)}
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq LinS]} {
		>
			emit {Microsoft Paint image data (version 2.0)}
			if {[N leshort 4 0 0 {} {} x {}]} {
				>
					emit (%d
					if {[N leshort 6 0 0 {} {} x {}]} {
						>
							emit {x %d)}
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S search 0 0 {c W} 100 eq constant\ story]} {
		>
			emit {Inform source text}
		<
	}
	
	if {[N lelong 16 0 0 {} {} == 267429210]} {
		>
			emit {Intel serial flash for PCH ROM}
		<
	}
	
	if {[S string 0 0 {} {} eq \210OPS]} {
		>
			emit {Interleaf saved data}
		<
	}
	
	if {[S string 0 0 {} {} eq <!OPS]} {
		>
			emit {Interleaf document text}
			if {[S string 5 0 {} {} eq ,\ Version\ =]} {
				>
					emit {\b, version}
					if {[S string 17 0 {} {} > \0]} {
						>
							emit %.3s
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 4 0 {} {} eq pgscriptver]} {
		>
			emit {IslandWrite document}
		<
	}
	
	if {[S string 13 0 {} {} eq DrawFile]} {
		>
			emit {IslandDraw document}
		<
	}
	
	if {[N leshort 0 0 0 & -4 == -27136]} {
		>
			emit {little endian ispell}
			switch [Nv byte 0 0 {} {}] {
				0 {
					>
						emit {hash file (?),}
					<
				}
				1 {
					>
						emit {3.0 hash file,}
					<
				}
				2 {
					>
						emit {3.1 hash file,}
					<
				}
				3 {
					>
						emit {hash file (?),}
					<
				}
			}
	
			switch [Nv leshort 2 0 {} {}] {
				0 {
					>
						emit {8-bit, no capitalization, 26 flags}
					<
				}
				1 {
					>
						emit {7-bit, no capitalization, 26 flags}
					<
				}
				2 {
					>
						emit {8-bit, capitalization, 26 flags}
					<
				}
				3 {
					>
						emit {7-bit, capitalization, 26 flags}
					<
				}
				4 {
					>
						emit {8-bit, no capitalization, 52 flags}
					<
				}
				5 {
					>
						emit {7-bit, no capitalization, 52 flags}
					<
				}
				6 {
					>
						emit {8-bit, capitalization, 52 flags}
					<
				}
				7 {
					>
						emit {7-bit, capitalization, 52 flags}
					<
				}
				8 {
					>
						emit {8-bit, no capitalization, 128 flags}
					<
				}
				9 {
					>
						emit {7-bit, no capitalization, 128 flags}
					<
				}
				10 {
					>
						emit {8-bit, capitalization, 128 flags}
					<
				}
				11 {
					>
						emit {7-bit, capitalization, 128 flags}
					<
				}
				12 {
					>
						emit {8-bit, no capitalization, 256 flags}
					<
				}
				13 {
					>
						emit {7-bit, no capitalization, 256 flags}
					<
				}
				14 {
					>
						emit {8-bit, capitalization, 256 flags}
					<
				}
				15 {
					>
						emit {7-bit, capitalization, 256 flags}
					<
				}
			}
	
			if {[N leshort 4 0 0 {} {} > 0]} {
				>
					emit {and %d string characters}
				<
			}
	
		<
	}
	
	if {[N beshort 0 0 0 & -4 == -27136]} {
		>
			emit {big endian ispell}
			switch [Nv byte 1 0 {} {}] {
				0 {
					>
						emit {hash file (?),}
					<
				}
				1 {
					>
						emit {3.0 hash file,}
					<
				}
				2 {
					>
						emit {3.1 hash file,}
					<
				}
				3 {
					>
						emit {hash file (?),}
					<
				}
			}
	
			switch [Nv beshort 2 0 {} {}] {
				0 {
					>
						emit {8-bit, no capitalization, 26 flags}
					<
				}
				1 {
					>
						emit {7-bit, no capitalization, 26 flags}
					<
				}
				2 {
					>
						emit {8-bit, capitalization, 26 flags}
					<
				}
				3 {
					>
						emit {7-bit, capitalization, 26 flags}
					<
				}
				4 {
					>
						emit {8-bit, no capitalization, 52 flags}
					<
				}
				5 {
					>
						emit {7-bit, no capitalization, 52 flags}
					<
				}
				6 {
					>
						emit {8-bit, capitalization, 52 flags}
					<
				}
				7 {
					>
						emit {7-bit, capitalization, 52 flags}
					<
				}
				8 {
					>
						emit {8-bit, no capitalization, 128 flags}
					<
				}
				9 {
					>
						emit {7-bit, no capitalization, 128 flags}
					<
				}
				10 {
					>
						emit {8-bit, capitalization, 128 flags}
					<
				}
				11 {
					>
						emit {7-bit, capitalization, 128 flags}
					<
				}
				12 {
					>
						emit {8-bit, no capitalization, 256 flags}
					<
				}
				13 {
					>
						emit {7-bit, no capitalization, 256 flags}
					<
				}
				14 {
					>
						emit {8-bit, capitalization, 256 flags}
					<
				}
				15 {
					>
						emit {7-bit, capitalization, 256 flags}
					<
				}
			}
	
			if {[N beshort 4 0 0 {} {} > 0]} {
				>
					emit {and %d string characters}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq ISPL]} {
		>
			emit ispell
			if {[N long 4 0 0 {} {} x {}]} {
				>
					emit {hash file version %d,}
				<
			}
	
			if {[N long 8 0 0 {} {} x {}]} {
				>
					emit {lexletters %d,}
				<
			}
	
			if {[N long 12 0 0 {} {} x {}]} {
				>
					emit {lexsize %d,}
				<
			}
	
			if {[N long 16 0 0 {} {} x {}]} {
				>
					emit {hashsize %d,}
				<
			}
	
			if {[N long 20 0 0 {} {} x {}]} {
				>
					emit {stblsize %d}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq IsZ!]} {
		>
			emit {ISO Zipped file}
			if {[N byte 4 0 0 {} {} x {}]} {
				>
					emit {\b, header size %u}
				<
			}
	
			if {[N byte 5 0 0 {} {} x {}]} {
				>
					emit {\b, version %u}
				<
			}
	
			if {[N lelong 8 0 0 {} {} x {}]} {
				>
					emit {\b, serial %u}
				<
			}
	
			if {[N byte 17 0 0 {} {} > 0]} {
				>
					emit {\b, password protected}
				<
			}
	
		<
	}
	
	if {[S regex 0 0 {} {} eq ^import.*\;\$]} {
		>
			emit {Java source}
			mime text/x-java
		<
	}
	
	if {[S string 0 0 {} {} eq JAVA\x20PROFILE\x201.0.]} {
		>
			if {[N short 18 0 0 {} {} == 0]} {
				>
					if {[N ushort 17 0 0 - 49 < 2]} {
						>
							emit {Java HPROF dump,}
						<
					}
	
					if {[N beqdate 23 0 0 / 1000 x {}]} {
						>
							emit {created %s}
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S search 0 0 w 1 eq \#!/bin/node]} {
		>
			emit {Node.js script text executable}
			mime application/javascript
		<
	}
	
	if {[S search 0 0 w 1 eq \#!/usr/bin/node]} {
		>
			emit {Node.js script text executable}
			mime application/javascript
		<
	}
	
	if {[S search 0 0 w 1 eq \#!/bin/nodejs]} {
		>
			emit {Node.js script text executable}
			mime application/javascript
		<
	}
	
	if {[S search 0 0 w 1 eq \#!/usr/bin/nodejs]} {
		>
			emit {Node.js script text executable}
			mime application/javascript
		<
	}
	
	if {[S search 0 0 {} 1 eq \#!/usr/bin/env\ node]} {
		>
			emit {Node.js script text executable}
			mime application/javascript
		<
	}
	
	if {[S search 0 0 {} 1 eq \#!/usr/bin/env\ nodejs]} {
		>
			emit {Node.js script text executable}
			mime application/javascript
		<
	}
	
	if {[S string 0 0 {} {} eq hsi1]} {
		>
			emit {JPEG image data, HSI proprietary}
		<
	}
	
	if {[S string 0 0 {} {} eq \x00\x00\x00\x0C\x6A\x50\x20\x20\x0D\x0A\x87\x0A]} {
		>
			emit {JPEG 2000}
			if {[S string 20 0 {} {} eq \x6a\x70\x32\x20]} {
				>
					emit {Part 1 (JP2)}
					mime image/jp2
				<
			}
	
			if {[S string 20 0 {} {} eq \x6a\x70\x78\x20]} {
				>
					emit {Part 2 (JPX)}
					mime image/jpx
				<
			}
	
			if {[S string 20 0 {} {} eq \x6a\x70\x6d\x20]} {
				>
					emit {Part 6 (JPM)}
					mime image/jpm
				<
			}
	
			if {[S string 20 0 {} {} eq \x6d\x6a\x70\x32]} {
				>
					emit {Part 3 (MJ2)}
					mime video/mj2
				<
			}
	
		<
	}
	
	if {[N beshort 45 0 0 {} {} == -174]} {
		>
		<
	}
	
	if {[S string 0 0 {} {} eq \x49\x49\xbc]} {
		>
			if {[N byte 3 0 0 {} {} == 1]} {
				>
					if {[N lelong 4 0 0 % 2 == 0]} {
						>
							emit JPEG-XR
							mime image/jxr
							ext jxr
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq KarmaRHD\040Version]} {
		>
			emit {Karma Data Structure Version}
			if {[N belong 16 0 0 {} {} x {}]} {
				>
					emit %u
				<
			}
	
		<
	}
	
	if {[S string 0 0 t {} eq \[KDE\ Desktop\ Entry\]]} {
		>
			emit {KDE desktop entry}
			mime application/x-kdelnk
		<
	}
	
	if {[S string 0 0 t {} eq \#\ KDE\ Config\ File]} {
		>
			emit {KDE config file}
			mime application/x-kdelnk
		<
	}
	
	if {[S string 0 0 t {} eq \#\ xmcd]} {
		>
			emit {xmcd database file for kscd}
			mime text/x-xmcd
		<
	}
	
	if {[S string 0 0 t {} eq <?xml]} {
		>
			if {[S search 20 0 {} 400 eq \ xmlns=]} {
				>
					if {[S regex [R 0] 0 {} {} eq \['\"\]http://earth.google.com/kml]} {
						>
							emit {Google KML document}
							if {[S string [R 1] 0 {} {} eq 2.0']} {
								>
									emit {\b, version 2.0}
								<
							}
	
							if {[S string [R 1] 0 {} {} eq 2.1']} {
								>
									emit {\b, version 2.1}
								<
							}
	
							if {[S string [R 1] 0 {} {} eq 2.2']} {
								>
									emit {\b, version 2.2}
								<
							}
	
							mime application/vnd.google-earth.kml+xml
						<
					}
	
					if {[S regex [R 0] 0 {} {} eq \['\"\]http://www.opengis.net/kml]} {
						>
							emit {OpenGIS KML document}
							if {[S string [R 1] 0 t {} eq 2.2]} {
								>
									emit {\b, version 2.2}
								<
							}
	
							mime application/vnd.google-earth.kml+xml
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq PK\003\004]} {
		>
			if {[N byte 4 0 0 {} {} == 20]} {
				>
					if {[S string 30 0 {} {} eq doc.kml]} {
						>
							emit {Compressed Google KML Document, including resources.}
							mime application/vnd.google-earth.kmz
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq lect]} {
		>
			emit {DEC SRC Virtual Paper Lectern file}
		<
	}
	
	if {[S search 0 0 {} 100 eq yyprevious]} {
		>
			emit {C program text (from lex)}
			if {[S search 3 0 {} 1 > \0]} {
				>
					emit {for %s}
				<
			}
	
		<
	}
	
	if {[S search 0 0 {} 100 eq generated\ by\ flex]} {
		>
			emit {C program text (from flex)}
		<
	}
	
	if {[S search 0 0 {} 1 eq %\{]} {
		>
			emit {lex description text}
		<
	}
	
	if {[S string 0 0 {} {} eq \007\001\000]} {
		>
			emit {Linux/i386 object file}
			if {[N lelong 20 0 0 {} {} > 4128]} {
				>
					emit {\b, DLL library}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \01\03\020\04]} {
		>
			emit {Linux-8086 impure executable}
			if {[N long 28 0 0 {} {} != 0]} {
				>
					emit {not stripped}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \01\03\040\04]} {
		>
			emit {Linux-8086 executable}
			if {[N long 28 0 0 {} {} != 0]} {
				>
					emit {not stripped}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \243\206\001\0]} {
		>
			emit {Linux-8086 object file}
		<
	}
	
	if {[S string 0 0 {} {} eq \01\03\020\20]} {
		>
			emit {Minix-386 impure executable}
			if {[N long 28 0 0 {} {} != 0]} {
				>
					emit {not stripped}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \01\03\040\20]} {
		>
			emit {Minix-386 executable}
			if {[N long 28 0 0 {} {} != 0]} {
				>
					emit {not stripped}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \01\03\04\20]} {
		>
			emit {Minix-386 NSYM/GNU executable}
			if {[N long 28 0 0 {} {} != 0]} {
				>
					emit {not stripped}
				<
			}
	
		<
	}
	
	if {[N lelong 216 0 0 {} {} == 273]} {
		>
			emit {Linux/i386 core file}
			if {[S string 220 0 {} {} > \0]} {
				>
					emit {of '%s'}
				<
			}
	
			if {[N lelong 200 0 0 {} {} > 0]} {
				>
					emit {(signal %d)}
				<
			}
	
			strength {/ 2}
		<
	}
	
	if {[S string 2 0 {} {} eq LILO]} {
		>
			emit {Linux/i386 LILO boot/chain loader}
		<
	}
	
	if {[S string 28 0 {} {} eq make\ config]} {
		>
			emit {Linux make config build file (old)}
		<
	}
	
	if {[S search 49 0 {} 70 eq Kernel\ Configuration]} {
		>
			emit {Linux make config build file}
		<
	}
	
	if {[S string 0 0 {} {} eq \x72\xb5\x4a\x86\x00\x00]} {
		>
			emit {Linux/i386 PC Screen Font v2 data,}
			if {[N lelong 16 0 0 {} {} x {}]} {
				>
					emit {%d characters,}
				<
			}
	
			if {[N lelong 12 0 0 & 1 == 0]} {
				>
					emit {no directory,}
				<
			}
	
			if {[N lelong 12 0 0 & 1 != 0]} {
				>
					emit {Unicode directory,}
				<
			}
	
			if {[N lelong 24 0 0 {} {} x {}]} {
				>
					emit %d
				<
			}
	
			if {[N lelong 28 0 0 {} {} x {}]} {
				>
					emit {\bx%d}
				<
			}
	
		<
	}
	
	if {[S string 4086 0 {} {} eq SWAP-SPACE]} {
		>
			emit {Linux/i386 swap file}
		<
	}
	
	if {[S string 4076 0 {} {} eq SWAPSPACE2S1SUSPEND]} {
		>
			emit {Linux/i386 swap file (new style) with SWSUSP1 image}
		<
	}
	
	if {[S string 4076 0 {} {} eq SWAPSPACE2LINHIB0001]} {
		>
			emit {Linux/i386 swap file (new style) (compressed hibernate)}
		<
	}
	
	if {[S string 4086 0 {} {} eq SWAPSPACE2]} {
		>
			emit {Linux/i386 swap file (new style),}
			if {[N long 1024 0 0 {} {} x {}]} {
				>
					emit {version %d (4K pages),}
				<
			}
	
			if {[N long 1028 0 0 {} {} x {}]} {
				>
					emit {size %d pages,}
				<
			}
	
			if {[S string 1052 0 {} {} eq \0]} {
				>
					emit {no label,}
				<
			}
	
			if {[S string 1052 0 {} {} > \0]} {
				>
					emit LABEL=%s,
				<
			}
	
			if {[N belong 1036 0 0 {} {} x {}]} {
				>
					emit UUID=%08x
				<
			}
	
			if {[N beshort 1040 0 0 {} {} x {}]} {
				>
					emit {\b-%04x}
				<
			}
	
			if {[N beshort 1042 0 0 {} {} x {}]} {
				>
					emit {\b-%04x}
				<
			}
	
			if {[N beshort 1044 0 0 {} {} x {}]} {
				>
					emit {\b-%04x}
				<
			}
	
			if {[N belong 1046 0 0 {} {} x {}]} {
				>
					emit {\b-%08x}
				<
			}
	
			if {[N beshort 1050 0 0 {} {} x {}]} {
				>
					emit {\b%04x}
				<
			}
	
		<
	}
	
	if {[S string 65526 0 {} {} eq SWAPSPACE2]} {
		>
			emit {Linux/ppc swap file}
			if {[N long 1024 0 0 {} {} x {}]} {
				>
					emit {version %d,}
				<
			}
	
			if {[N long 1028 0 0 {} {} x {}]} {
				>
					emit {size %d pages,}
				<
			}
	
			if {[S string 1052 0 {} {} eq \0]} {
				>
					emit {no label,}
				<
			}
	
			if {[S string 1052 0 {} {} > \0]} {
				>
					emit LABEL=%s,
				<
			}
	
			if {[N belong 1036 0 0 {} {} x {}]} {
				>
					emit UUID=%08x
				<
			}
	
			if {[N beshort 1040 0 0 {} {} x {}]} {
				>
					emit {\b-%04x}
				<
			}
	
			if {[N beshort 1042 0 0 {} {} x {}]} {
				>
					emit {\b-%04x}
				<
			}
	
			if {[N beshort 1044 0 0 {} {} x {}]} {
				>
					emit {\b-%04x}
				<
			}
	
			if {[N belong 1046 0 0 {} {} x {}]} {
				>
					emit {\b-%08x}
				<
			}
	
			if {[N beshort 1050 0 0 {} {} x {}]} {
				>
					emit {\b%04x}
				<
			}
	
		<
	}
	
	if {[S string 16374 0 {} {} eq SWAPSPACE2]} {
		>
			emit {Linux/ia64 swap file}
		<
	}
	
	if {[S string 514 0 {} {} eq HdrS]} {
		>
			emit {Linux kernel}
			if {[N leshort 510 0 0 {} {} == -21931]} {
				>
					emit {x86 boot executable}
					if {[N leshort 518 0 0 {} {} > 511]} {
						>
							switch [Nv byte 529 0 {} {}] {
								0 {
									>
										emit zImage,
									<
								}
								1 {
									>
										emit bzImage,
									<
								}
							}
	
							if {[N lelong 526 0 0 {} {} > 0]} {
								>
									if {[S string [I 526 uleshort 0 + 0 512] 0 {} {} > \0]} {
										>
											emit {version %s,}
										<
									}
	
								<
							}
	
						<
					}
	
					switch [Nv leshort 498 0 {} {}] {
						0 {
							>
								emit RW-rootFS,
							<
						}
						1 {
							>
								emit RO-rootFS,
							<
						}
					}
	
					if {[N leshort 508 0 0 {} {} > 0]} {
						>
							emit {root_dev 0x%X,}
						<
					}
	
					if {[N leshort 502 0 0 {} {} > 0]} {
						>
							emit {swap_dev 0x%X,}
						<
					}
	
					if {[N leshort 504 0 0 {} {} > 0]} {
						>
							emit {RAMdisksize %u KB,}
						<
					}
	
					switch [Nv leshort 506 0 {} {}] {
						-3 {
							>
								emit {Prompt for Videomode}
							<
						}
						-2 {
							>
								emit {Extended VGA}
							<
						}
						-1 {
							>
								emit {Normal VGA}
							<
						}
					}
	
					if {[N leshort 506 0 0 {} {} > 0]} {
						>
							emit {Video mode %d}
						<
					}
	
				<
			}
	
			strength {+ 55}
		<
	}
	
	if {[S search 8 0 {} 1 eq \ A\ _text]} {
		>
			emit {Linux kernel symbol map text}
		<
	}
	
	if {[S search 0 0 {} 1 eq Begin3]} {
		>
			emit {Linux Software Map entry text}
		<
	}
	
	if {[S search 0 0 {} 1 eq Begin4]} {
		>
			emit {Linux Software Map entry text (new format)}
		<
	}
	
	if {[S string 0 0 {} {} eq \xb8\xc0\x07\x8e\xd8\xb8\x00\x90]} {
		>
			emit Linux
			if {[N leshort 497 0 0 {} {} == 0]} {
				>
					emit {x86 boot sector}
					switch [Nv belong 514 0 {} {}] {
						-1869686604 {
							>
								emit {version 0.99-1.1.42}
							<
						}
						-1869686600 {
							>
								emit {for memtest86}
							<
						}
						142 {
							>
								emit {of a kernel from the dawn of time!}
							<
						}
					}
	
				<
			}
	
			if {[N leshort 497 0 0 {} {} != 0]} {
				>
					emit {x86 kernel}
					if {[N leshort 504 0 0 {} {} > 0]} {
						>
							emit {RAMdisksize=%u KB}
						<
					}
	
					if {[N leshort 502 0 0 {} {} > 0]} {
						>
							emit swap=0x%X
						<
					}
	
					if {[N leshort 508 0 0 {} {} > 0]} {
						>
							emit root=0x%X
							switch [Nv leshort 498 0 {} {}] {
								0 {
									>
										emit {\b-rw}
									<
								}
								1 {
									>
										emit {\b-ro}
									<
								}
							}
	
						<
					}
	
					switch [Nv leshort 506 0 {} {}] {
						-3 {
							>
								emit vga=ask
							<
						}
						-2 {
							>
								emit vga=extended
							<
						}
						-1 {
							>
								emit vga=normal
							<
						}
					}
	
					if {[N leshort 506 0 0 {} {} > 0]} {
						>
							emit vga=%d
						<
					}
	
					switch [Nv belong 514 0 {} {}] {
						-1869686655 {
							>
								emit {version 1.1.43-1.1.45}
							<
						}
						364020173 {
							>
								if {[N belong 2702 0 0 {} {} == 1437227610]} {
									>
										emit {version 1.1.46-1.2.13,1.3.0}
									<
								}
	
								if {[N belong 2713 0 0 {} {} == 1437227610]} {
									>
										emit {version 1.3.1,2}
									<
								}
	
								if {[N belong 2723 0 0 {} {} == 1437227610]} {
									>
										emit {version 1.3.3-1.3.30}
									<
								}
	
								if {[N belong 2726 0 0 {} {} == 1437227610]} {
									>
										emit {version 1.3.31-1.3.41}
									<
								}
	
								if {[N belong 2859 0 0 {} {} == 1437227610]} {
									>
										emit {version 1.3.42-1.3.45}
									<
								}
	
								if {[N belong 2807 0 0 {} {} == 1437227610]} {
									>
										emit {version 1.3.46-1.3.72}
									<
								}
	
							<
						}
					}
	
					if {[S string 514 0 {} {} eq HdrS]} {
						>
							if {[N leshort 518 0 0 {} {} > 511]} {
								>
									switch [Nv byte 529 0 {} {}] {
										0 {
											>
												emit {\b, zImage}
											<
										}
										1 {
											>
												emit {\b, bzImage}
											<
										}
									}
	
									if {[S string [I 526 uleshort 0 + 0 512] 0 {} {} > \0]} {
										>
											emit {\b, version %s}
										<
									}
	
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 8 0 {} {} eq \x02\x00\x00\x18\x60\x00\x00\x50\x02\x00\x00\x68\x60\x00\x00\x50\x40\x40\x40\x40\x40\x40\x40\x40]} {
		>
			emit {Linux S390}
			if {[S search 65536 0 b 4096 eq \x00\x0a\x00\x00\x8b\xad\xcc\xcc]} {
				>
					if {[S string [R 0] 0 {} {} eq \xc1\x00\xef\xe3\xf0\x68\x00\x00]} {
						>
							emit {Z10 64bit kernel}
						<
					}
	
					if {[S string [R 0] 0 {} {} eq \xc1\x00\xef\xc3\x00\x00\x00\x00]} {
						>
							emit {Z9-109 64bit kernel}
						<
					}
	
					if {[S string [R 0] 0 {} {} eq \xc0\x00\x20\x00\x00\x00\x00\x00]} {
						>
							emit {Z990 64bit kernel}
						<
					}
	
					if {[S string [R 0] 0 {} {} eq \x00\x00\x00\x00\x00\x00\x00\x00]} {
						>
							emit {Z900 64bit kernel}
						<
					}
	
					if {[S string [R 0] 0 {} {} eq \x81\x00\xc8\x80\x00\x00\x00\x00]} {
						>
							emit {Z10 32bit kernel}
						<
					}
	
					if {[S string [R 0] 0 {} {} eq \x81\x00\xc8\x80\x00\x00\x00\x00]} {
						>
							emit {Z9-109 32bit kernel}
						<
					}
	
					if {[S string [R 0] 0 {} {} eq \x80\x00\x20\x00\x00\x00\x00\x00]} {
						>
							emit {Z990 32bit kernel}
						<
					}
	
					if {[S string [R 0] 0 {} {} eq \x80\x00\x00\x00\x00\x00\x00\x00]} {
						>
							emit {Z900 32bit kernel}
						<
					}
	
				<
			}
	
		<
	}
	
	if {[N lelong 36 0 0 {} {} == 24061976]} {
		>
			emit {Linux kernel ARM boot executable zImage (little-endian)}
		<
	}
	
	if {[N belong 36 0 0 {} {} == 24061976]} {
		>
			emit {Linux kernel ARM boot executable zImage (big-endian)}
		<
	}
	
	if {[N lelong 0 0 0 & -16776961 == -1023409943]} {
		>
			emit {Linux-Dev86 executable, headerless}
			if {[S string 5 0 {} {} eq .]} {
				>
					if {[S string 4 0 {} {} > \0]} {
						>
							emit {\b, libc version %s}
						<
					}
	
				<
			}
	
		<
	}
	
	if {[N lelong 0 0 0 & -16711681 == 67109633]} {
		>
			emit {Linux-8086 executable}
			if {[N byte 2 0 0 & 1 != 0]} {
				>
					emit {\b, unmapped zero page}
				<
			}
	
			if {[N byte 2 0 0 & 32 == 0]} {
				>
					emit {\b, impure}
				<
			}
	
			if {[N byte 2 0 0 & 32 != 0]} {
				>
					if {[N byte 2 0 0 & 16 != 0]} {
						>
							emit {\b, A_EXEC}
						<
					}
	
				<
			}
	
			if {[N byte 2 0 0 & 2 != 0]} {
				>
					emit {\b, A_PAL}
				<
			}
	
			if {[N byte 2 0 0 & 4 != 0]} {
				>
					emit {\b, A_NSYM}
				<
			}
	
			if {[N byte 2 0 0 & 8 != 0]} {
				>
					emit {\b, A_STAND}
				<
			}
	
			if {[N byte 2 0 0 & 64 != 0]} {
				>
					emit {\b, A_PURE}
				<
			}
	
			if {[N byte 2 0 0 & -128 != 0]} {
				>
					emit {\b, A_TOVLY}
				<
			}
	
			if {[N long 28 0 0 {} {} != 0]} {
				>
					emit {\b, not stripped}
				<
			}
	
			if {[S string 37 0 {} {} eq .]} {
				>
					if {[S string 36 0 {} {} > \0]} {
						>
							emit {\b, libc version %s}
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq OOOM]} {
		>
			emit {User-Mode-Linux's Copy-On-Write disk image}
			if {[N belong 4 0 0 {} {} x {}]} {
				>
					emit {version %d}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq HM\001]} {
		>
			emit {LVM1 (Linux Logical Volume Manager), version 1}
			if {[S string 300 0 {} {} > \0]} {
				>
					emit {, System ID: %s}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq HM\002]} {
		>
			emit {LVM1 (Linux Logical Volume Manager), version 2}
			if {[S string 300 0 {} {} > \0]} {
				>
					emit {, System ID: %s}
				<
			}
	
		<
	}
	
	if {[S string 536 0 {} {} eq LVM2\ 001]} {
		>
			emit {LVM2 PV (Linux Logical Volume Manager)}
			if {[N byte [R [I [R -12] ulelong 0 - 0 33]] 0 0 {} {} x {}]} {
				>
					if {[S string [R 0] 0 {} {} > \x2f]} {
						>
							emit {\b, UUID: %.6s}
						<
					}
	
					if {[S string [R 6] 0 {} {} > \x2f]} {
						>
							emit {\b-%.4s}
						<
					}
	
					if {[S string [R 10] 0 {} {} > \x2f]} {
						>
							emit {\b-%.4s}
						<
					}
	
					if {[S string [R 14] 0 {} {} > \x2f]} {
						>
							emit {\b-%.4s}
						<
					}
	
					if {[S string [R 18] 0 {} {} > \x2f]} {
						>
							emit {\b-%.4s}
						<
					}
	
					if {[S string [R 22] 0 {} {} > \x2f]} {
						>
							emit {\b-%.4s}
						<
					}
	
					if {[S string [R 26] 0 {} {} > \x2f]} {
						>
							emit {\b-%.6s}
						<
					}
	
					if {[N lequad [R 32] 0 0 {} {} x {}]} {
						>
							emit {\b, size: %lld}
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 24 0 {} {} eq LVM2\ 001]} {
		>
			emit {LVM2 PV (Linux Logical Volume Manager)}
			if {[N byte [R [I [R -12] ulelong 0 - 0 33]] 0 0 {} {} x {}]} {
				>
					if {[S string [R 0] 0 {} {} > \x2f]} {
						>
							emit {\b, UUID: %.6s}
						<
					}
	
					if {[S string [R 6] 0 {} {} > \x2f]} {
						>
							emit {\b-%.4s}
						<
					}
	
					if {[S string [R 10] 0 {} {} > \x2f]} {
						>
							emit {\b-%.4s}
						<
					}
	
					if {[S string [R 14] 0 {} {} > \x2f]} {
						>
							emit {\b-%.4s}
						<
					}
	
					if {[S string [R 18] 0 {} {} > \x2f]} {
						>
							emit {\b-%.4s}
						<
					}
	
					if {[S string [R 22] 0 {} {} > \x2f]} {
						>
							emit {\b-%.4s}
						<
					}
	
					if {[S string [R 26] 0 {} {} > \x2f]} {
						>
							emit {\b-%.6s}
						<
					}
	
					if {[N lequad [R 32] 0 0 {} {} x {}]} {
						>
							emit {\b, size: %lld}
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 1048 0 {} {} eq LVM2\ 001]} {
		>
			emit {LVM2 PV (Linux Logical Volume Manager)}
			if {[N byte [R [I [R -12] ulelong 0 - 0 33]] 0 0 {} {} x {}]} {
				>
					if {[S string [R 0] 0 {} {} > \x2f]} {
						>
							emit {\b, UUID: %.6s}
						<
					}
	
					if {[S string [R 6] 0 {} {} > \x2f]} {
						>
							emit {\b-%.4s}
						<
					}
	
					if {[S string [R 10] 0 {} {} > \x2f]} {
						>
							emit {\b-%.4s}
						<
					}
	
					if {[S string [R 14] 0 {} {} > \x2f]} {
						>
							emit {\b-%.4s}
						<
					}
	
					if {[S string [R 18] 0 {} {} > \x2f]} {
						>
							emit {\b-%.4s}
						<
					}
	
					if {[S string [R 22] 0 {} {} > \x2f]} {
						>
							emit {\b-%.4s}
						<
					}
	
					if {[S string [R 26] 0 {} {} > \x2f]} {
						>
							emit {\b-%.6s}
						<
					}
	
					if {[N lequad [R 32] 0 0 {} {} x {}]} {
						>
							emit {\b, size: %lld}
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 1560 0 {} {} eq LVM2\ 001]} {
		>
			emit {LVM2 PV (Linux Logical Volume Manager)}
			if {[N byte [R [I [R -12] ulelong 0 - 0 33]] 0 0 {} {} x {}]} {
				>
					if {[S string [R 0] 0 {} {} > \x2f]} {
						>
							emit {\b, UUID: %.6s}
						<
					}
	
					if {[S string [R 6] 0 {} {} > \x2f]} {
						>
							emit {\b-%.4s}
						<
					}
	
					if {[S string [R 10] 0 {} {} > \x2f]} {
						>
							emit {\b-%.4s}
						<
					}
	
					if {[S string [R 14] 0 {} {} > \x2f]} {
						>
							emit {\b-%.4s}
						<
					}
	
					if {[S string [R 18] 0 {} {} > \x2f]} {
						>
							emit {\b-%.4s}
						<
					}
	
					if {[S string [R 22] 0 {} {} > \x2f]} {
						>
							emit {\b-%.4s}
						<
					}
	
					if {[S string [R 26] 0 {} {} > \x2f]} {
						>
							emit {\b-%.6s}
						<
					}
	
					if {[N lequad [R 32] 0 0 {} {} x {}]} {
						>
							emit {\b, size: %lld}
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq SnAp]} {
		>
			emit {LVM Snapshot (CopyOnWrite store)}
			if {[N lelong 4 0 0 {} {} != 0]} {
				>
					emit {- valid,}
				<
			}
	
			if {[N lelong 4 0 0 {} {} == 0]} {
				>
					emit {- invalid,}
				<
			}
	
			if {[N lelong 8 0 0 {} {} x {}]} {
				>
					emit {version %d,}
				<
			}
	
			if {[N lelong 12 0 0 {} {} x {}]} {
				>
					emit {chunk_size %d}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq LUKS\xba\xbe]} {
		>
			emit {LUKS encrypted file,}
			if {[N beshort 6 0 0 {} {} x {}]} {
				>
					emit {ver %d}
				<
			}
	
			if {[S string 8 0 {} {} x {}]} {
				>
					emit {[%s,}
				<
			}
	
			if {[S string 40 0 {} {} x {}]} {
				>
					emit %s,
				<
			}
	
			if {[S string 72 0 {} {} x {}]} {
				>
					emit %s\]
				<
			}
	
			if {[S string 168 0 {} {} x {}]} {
				>
					emit {UUID: %s}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq LinuxGuestRecord]} {
		>
			emit {Xen saved domain}
			if {[S search 20 0 {} 256 eq (name]} {
				>
					if {[S string [R 1] 0 {} {} x {}]} {
						>
							emit {(name %s)}
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq LinuxGuestRecord]} {
		>
			emit {Xen saved domain}
			if {[S search 20 0 {} 256 eq (name]} {
				>
					emit (name
					if {[S string [R 1] 0 {} {} x {}]} {
						>
							emit %s...)
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq LPKSHHRH]} {
		>
			if {[N ubyte 16 0 0 & 252 == 0]} {
				>
					if {[N ubequad 24 0 0 {} {} > 0]} {
						>
							if {[N ubequad 32 0 0 {} {} > 0]} {
								>
									if {[N ubequad 40 0 0 {} {} > 0]} {
										>
											if {[N ubequad 48 0 0 {} {} > 0]} {
												>
													if {[N ubequad 56 0 0 {} {} > 0]} {
														>
															if {[N ubequad 64 0 0 {} {} > 0]} {
																>
																	emit {Journal file}
																	if {[N leqdate 184 0 0 {} {} == 0]} {
																		>
																			emit empty
																		<
																	}
	
																	switch [Nv ubyte 16 0 {} {}] {
																		0 {
																			>
																				emit {\b, offline}
																			<
																		}
																		1 {
																			>
																				emit {\b, online}
																			<
																		}
																		2 {
																			>
																				emit {\b, archived}
																			<
																		}
																	}
	
																	if {[N ulelong 8 0 0 & 1 == 1]} {
																		>
																			emit {\b, sealed}
																		<
																	}
	
																	if {[N ulelong 12 0 0 & 1 == 1]} {
																		>
																			emit {\b, compressed}
																		<
																	}
	
																	mime application/octet-stream
																<
															}
	
														<
													}
	
												<
											}
	
										<
									}
	
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[N lequad 4104 0 0 {} {} == 8]} {
		>
			if {[S string 4120 0 {} {} eq \xc6\x85\x73\xf6\x4e\x1a\x45\xca\x82\x65\xf5\x7f\x48\xba\x6d\x81]} {
				>
					emit BCache
					switch [Nv ulequad 4112 0 {} {}] {
						0 {
							>
								emit {cache device}
							<
						}
						1 {
							>
								emit {backing device}
							<
						}
						3 {
							>
								emit {cache device}
							<
						}
						4 {
							>
								emit {backing device}
							<
						}
					}
	
					if {[S string 4168 0 {} {} > 0]} {
						>
							emit {\b, label "%.32s"}
						<
					}
	
					if {[N ubelong 4136 0 0 {} {} x {}]} {
						>
							emit {\b, uuid %08x}
						<
					}
	
					if {[N ubeshort 4140 0 0 {} {} x {}]} {
						>
							emit {\b-%04x}
						<
					}
	
					if {[N ubeshort 4142 0 0 {} {} x {}]} {
						>
							emit {\b-%04x}
						<
					}
	
					if {[N ubeshort 4144 0 0 {} {} x {}]} {
						>
							emit {\b-%04x}
						<
					}
	
					if {[N ubelong 4146 0 0 {} {} x {}]} {
						>
							emit {\b-%08x}
						<
					}
	
					if {[N ubeshort 4150 0 0 {} {} x {}]} {
						>
							emit {\b%04x}
						<
					}
	
					if {[N ubelong 4152 0 0 {} {} x {}]} {
						>
							emit {\b, set uuid %08x}
						<
					}
	
					if {[N ubeshort 4156 0 0 {} {} x {}]} {
						>
							emit {\b-%04x}
						<
					}
	
					if {[N ubeshort 4158 0 0 {} {} x {}]} {
						>
							emit {\b-%04x}
						<
					}
	
					if {[N ubeshort 4160 0 0 {} {} x {}]} {
						>
							emit {\b-%04x}
						<
					}
	
					if {[N ubelong 4162 0 0 {} {} x {}]} {
						>
							emit {\b-%08x}
						<
					}
	
					if {[N ubeshort 4166 0 0 {} {} x {}]} {
						>
							emit {\b%04x}
						<
					}
	
				<
			}
	
		<
	}
	
	if {[N lelong 4096 0 0 {} {} == -1456779524]} {
		>
			emit {Linux Software RAID}
			if {[N lelong 4100 0 0 {} {} x {}]} {
				>
					emit {version 1.2 (%d)}
				<
			}
	
			U 129 linuxraid 4096
	
		<
	}
	
	if {[S string 0 0 {} {} eq \0mlocate]} {
		>
			emit {mlocate database}
			if {[N byte 12 0 0 {} {} x {}]} {
				>
					emit {\b, version %d}
				<
			}
	
			if {[N byte 13 0 0 {} {} == 1]} {
				>
					emit {\b, require visibility}
				<
			}
	
			if {[S string 16 0 {} {} x {}]} {
				>
					emit {\b, root %s}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq KDUMP]} {
		>
			emit {Kdump compressed dump}
			if {[N long 8 0 0 {} {} x {}]} {
				>
					emit v%d
				<
			}
	
			if {[S string 12 0 {} {} > \0]} {
				>
					emit {\b, system %s}
				<
			}
	
			if {[S string 77 0 {} {} > \0]} {
				>
					emit {\b, node %s}
				<
			}
	
			if {[S string 142 0 {} {} > \0]} {
				>
					emit {\b, release %s}
				<
			}
	
			if {[S string 207 0 {} {} > \0]} {
				>
					emit {\b, version %s}
				<
			}
	
			if {[S string 272 0 {} {} > \0]} {
				>
					emit {\b, machine %s}
				<
			}
	
			if {[S string 337 0 {} {} > \0]} {
				>
					emit {\b, domain %s}
				<
			}
	
		<
	}
	
	if {[S search 0 0 {} 4096 eq (setq\ ]} {
		>
			emit {Lisp/Scheme program text}
			mime text/x-lisp
		<
	}
	
	if {[S search 0 0 {} 4096 eq (defvar\ ]} {
		>
			emit {Lisp/Scheme program text}
			mime text/x-lisp
		<
	}
	
	if {[S search 0 0 {} 4096 eq (defparam\ ]} {
		>
			emit {Lisp/Scheme program text}
			mime text/x-lisp
		<
	}
	
	if {[S search 0 0 {} 4096 eq (defun\ ]} {
		>
			emit {Lisp/Scheme program text}
			mime text/x-lisp
		<
	}
	
	if {[S search 0 0 {} 4096 eq (autoload\ ]} {
		>
			emit {Lisp/Scheme program text}
			mime text/x-lisp
		<
	}
	
	if {[S search 0 0 {} 4096 eq (custom-set-variables\ ]} {
		>
			emit {Lisp/Scheme program text}
			mime text/x-lisp
		<
	}
	
	if {[S string 0 0 {} {} eq \012(]} {
		>
			if {[S regex [R 0] 0 {} {} eq ^(defun|defvar|defconst|defmacro|setq|fset)]} {
				>
					emit {Emacs v18 byte-compiled Lisp data}
					mime application/x-elc
					ext elc
				<
			}
	
			if {[S regex [R 0] 0 {} {} eq ^(put|provide|require|random)]} {
				>
					emit {Emacs v18 byte-compiled Lisp data}
					mime application/x-elc
					ext elc
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \;ELC]} {
		>
			if {[N byte 4 0 0 {} {} > 18]} {
				>
					emit {Emacs/XEmacs v%d byte-compiled Lisp data}
					mime application/x-elc
					ext elc
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq (SYSTEM::VERSION\040']} {
		>
			emit {CLISP byte-compiled Lisp program (pre 2004-03-27)}
		<
	}
	
	if {[S string 0 0 {} {} eq (|SYSTEM|::|VERSION|\040']} {
		>
			emit {CLISP byte-compiled Lisp program text}
		<
	}
	
	if {[S string 0 0 {} {} eq \372\372\372\372]} {
		>
			emit {MIT scheme (library?)}
		<
	}
	
	if {[S search 0 0 {} 1 eq <TeXmacs|]} {
		>
			emit {TeXmacs document text}
			mime text/texmacs
		<
	}
	
	if {[S string 0 0 {} {} eq llvm]} {
		>
			emit {LLVM byte-codes, uncompressed}
		<
	}
	
	if {[S string 0 0 {} {} eq llvc0]} {
		>
			emit {LLVM byte-codes, null compression}
		<
	}
	
	if {[S string 0 0 {} {} eq llvc1]} {
		>
			emit {LLVM byte-codes, gzip compression}
		<
	}
	
	if {[S string 0 0 {} {} eq llvc2]} {
		>
			emit {LLVM byte-codes, bzip2 compression}
		<
	}
	
	if {[S string 0 0 {} {} eq BC\xc0\xde]} {
		>
			emit {LLVM IR bitcode}
		<
	}
	
	if {[S search 0 0 w 1 eq \#!\ /usr/bin/lua]} {
		>
			emit {Lua script text executable}
			mime text/x-lua
		<
	}
	
	if {[S search 0 0 w 1 eq \#!\ /usr/local/bin/lua]} {
		>
			emit {Lua script text executable}
			mime text/x-lua
		<
	}
	
	if {[S search 0 0 {} 1 eq \#!/usr/bin/env\ lua]} {
		>
			emit {Lua script text executable}
			mime text/x-lua
		<
	}
	
	if {[S search 0 0 {} 1 eq \#!\ /usr/bin/env\ lua]} {
		>
			emit {Lua script text executable}
			mime text/x-lua
		<
	}
	
	if {[S string 0 0 {} {} eq \033Lua]} {
		>
			emit {Lua bytecode,}
			switch [Nv byte 4 0 {} {}] {
				80 {
					>
						emit {version 5.0}
					<
				}
				81 {
					>
						emit {version 5.1}
					<
				}
				82 {
					>
						emit {version 5.2}
					<
				}
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq LUKS\xba\xbe]} {
		>
			emit {LUKS encrypted file,}
			if {[N beshort 6 0 0 {} {} x {}]} {
				>
					emit {ver %d}
				<
			}
	
			if {[S string 8 0 {} {} x {}]} {
				>
					emit {[%s,}
				<
			}
	
			if {[S string 40 0 {} {} x {}]} {
				>
					emit %s,
				<
			}
	
			if {[S string 72 0 {} {} x {}]} {
				>
					emit %s\]
				<
			}
	
			if {[S string 168 0 {} {} x {}]} {
				>
					emit {UUID: %s}
				<
			}
	
		<
	}
	
	if {[S regex 0 0 {} {} eq ^dnl\ ]} {
		>
			emit {M4 macro processor script text}
			mime text/x-m4
		<
	}
	
	if {[S regex 0 0 {} {} eq ^AC_DEFUN\\(\\\[]} {
		>
			emit {M4 macro processor script text}
			mime text/x-m4
			strength {+ 15}
		<
	}
	
	if {[N lelong 0 0 0 & -2 == -17958194]} {
		>
			emit Mach-O
			U 135 mach-o-be 0
	
			mime application/x-mach-binary
			strength +1
		<
	}
	
	switch [Nv belong 0 0 & -2] {
		-17958194 {
			>
				emit Mach-O
				mime application/x-mach-binary
				U 135 mach-o-be 0
	
			<
		}
		931071618 {
			>
				emit {SQLite Write-Ahead Log,}
				ext sqlite-wal/db-wal
				if {[N belong 4 0 0 {} {} x {}]} {
					>
						emit {version %d}
					<
				}
	
			<
		}
	}
	
	if {[S string 11 0 {} {} eq must\ be\ converted\ with\ BinHex]} {
		>
			emit {BinHex binary text}
			if {[S string 41 0 {} {} x {}]} {
				>
					emit {\b, version %.3s}
				<
			}
	
			mime application/mac-binhex40
		<
	}
	
	if {[S string 0 0 {} {} eq SIT!]} {
		>
			emit {StuffIt Archive (data)}
			if {[S string 2 0 {} {} x {}]} {
				>
					emit {: %s}
				<
			}
	
			mime application/x-stuffit
		<
	}
	
	if {[S string 0 0 {} {} eq SITD]} {
		>
			emit {StuffIt Deluxe (data)}
			if {[S string 2 0 {} {} x {}]} {
				>
					emit {: %s}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq Seg]} {
		>
			emit {StuffIt Deluxe Segment (data)}
			if {[S string 2 0 {} {} x {}]} {
				>
					emit {: %s}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq StuffIt]} {
		>
			emit {StuffIt Archive}
			mime application/x-stuffit
		<
	}
	
	if {[S string 0 0 {} {} eq SAS]} {
		>
			emit SAS
			if {[S string 24 0 {} {} eq DATA]} {
				>
					emit {data file}
				<
			}
	
			if {[S string 24 0 {} {} eq CATALOG]} {
				>
					emit catalog
				<
			}
	
			if {[S string 24 0 {} {} eq INDEX]} {
				>
					emit {data file index}
				<
			}
	
			if {[S string 24 0 {} {} eq VIEW]} {
				>
					emit {data view}
				<
			}
	
		<
	}
	
	if {[S string 84 0 {} {} eq SAS]} {
		>
			emit {SAS 7+}
			if {[S string 156 0 {} {} eq DATA]} {
				>
					emit {data file}
				<
			}
	
			if {[S string 156 0 {} {} eq CATALOG]} {
				>
					emit catalog
				<
			}
	
			if {[S string 156 0 {} {} eq INDEX]} {
				>
					emit {data file index}
				<
			}
	
			if {[S string 156 0 {} {} eq VIEW]} {
				>
					emit {data view}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \$FL2]} {
		>
			emit {SPSS System File}
			if {[S string 24 0 {} {} x {}]} {
				>
					emit %s
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \$FL3]} {
		>
			emit {SPSS System File}
			if {[S string 24 0 {} {} x {}]} {
				>
					emit %s
				<
			}
	
		<
	}
	
	switch [Nv beshort 1024 0 {} {}] {
		-11561 {
			>
				emit {Macintosh MFS data}
				if {[N beshort 0 0 0 {} {} == 19531]} {
					>
						emit (bootable)
					<
				}
	
				if {[N beshort 1034 0 0 {} {} & -32768]} {
					>
						emit (locked)
					<
				}
	
				if {[N beldate 1026 0 0 - 2082844800 x {}]} {
					>
						emit {created: %s,}
					<
				}
	
				if {[N beldate 1030 0 0 - 2082844800 > 0]} {
					>
						emit {last backup: %s,}
					<
				}
	
				if {[N belong 1044 0 0 {} {} x {}]} {
					>
						emit {block size: %d,}
					<
				}
	
				if {[N beshort 1042 0 0 {} {} x {}]} {
					>
						emit {number of blocks: %d,}
					<
				}
	
				if {[S pstring 1060 0 {} {} x {}]} {
					>
						emit {volume name: %s}
					<
				}
	
			<
		}
		16964 {
			>
				if {[N ubeshort 1038 0 0 {} {} == 3]} {
					>
						if {[N ubyte 1060 0 0 {} {} < 28]} {
							>
								emit {Macintosh HFS data}
								if {[N beshort 0 0 0 {} {} == 19531]} {
									>
										emit (bootable)
									<
								}
	
								if {[N beshort 1034 0 0 {} {} & -32768]} {
									>
										emit (locked)
									<
								}
	
								if {[N beshort 1034 0 0 {} {} ^ 256]} {
									>
										emit (mounted)
									<
								}
	
								if {[N beshort 1034 0 0 {} {} & 512]} {
									>
										emit {(spared blocks)}
									<
								}
	
								if {[N beshort 1034 0 0 {} {} & 2048]} {
									>
										emit (unclean)
									<
								}
	
								if {[N beshort 1148 0 0 {} {} == 18475]} {
									>
										emit {(Embedded HFS+ Volume)}
									<
								}
	
								if {[N belong 1044 0 0 {} {} x {}]} {
									>
										emit {block size: %d,}
									<
								}
	
								if {[N beshort 1042 0 0 {} {} x {}]} {
									>
										emit {number of blocks: %d,}
									<
								}
	
								if {[S pstring 1060 0 {} {} x {}]} {
									>
										emit {volume name: %s}
									<
								}
	
								mime application/x-apple-diskimage
								ext hfs/dmg
							<
						}
	
					<
				}
	
			<
		}
		18475 {
			>
				emit {Macintosh HFS Extended}
				if {[N beshort [R 0] 0 0 {} {} x {}]} {
					>
						emit {version %d data}
					<
				}
	
				if {[N beshort 0 0 0 {} {} == 19531]} {
					>
						emit (bootable)
					<
				}
	
				if {[N belong 1028 0 0 {} {} ^ 256]} {
					>
						emit (mounted)
					<
				}
	
				if {[N belong [R 2] 0 0 {} {} & 512]} {
					>
						emit {(spared blocks)}
					<
				}
	
				if {[N belong [R 2] 0 0 {} {} & 2048]} {
					>
						emit (unclean)
					<
				}
	
				if {[N belong [R 2] 0 0 {} {} & 32768]} {
					>
						emit (locked)
					<
				}
	
				if {[S string [R 6] 0 {} {} x {}]} {
					>
						emit {last mounted by: '%.4s',}
					<
				}
	
				if {[N beldate [R 14] 0 0 - 2082844800 x {}]} {
					>
						emit {created: %s,}
					<
				}
	
				if {[N bedate [R 18] 0 0 - -20352 x {}]} {
					>
						emit {last modified: %s,}
					<
				}
	
				if {[N bedate [R 22] 0 0 - -20352 > 0]} {
					>
						emit {last backup: %s,}
					<
				}
	
				if {[N bedate [R 26] 0 0 - -20352 > 0]} {
					>
						emit {last checked: %s,}
					<
				}
	
				if {[N belong [R 38] 0 0 {} {} x {}]} {
					>
						emit {block size: %d,}
					<
				}
	
				if {[N belong [R 42] 0 0 {} {} x {}]} {
					>
						emit {number of blocks: %d,}
					<
				}
	
				if {[N belong [R 46] 0 0 {} {} x {}]} {
					>
						emit {free blocks: %d}
					<
				}
	
			<
		}
	}
	
	if {[S string 0 0 {} {} eq BOMStore]} {
		>
			emit {Mac OS X bill of materials (BOM) file}
		<
	}
	
	if {[S string 0 0 {} {} eq book\0\0\0\0mark\0\0\0\0]} {
		>
			emit {MacOS Alias file}
		<
	}
	
	if {[S string 0 0 t {} eq \#\ Magic]} {
		>
			emit {magic text file for file(1) cmd}
		<
	}
	
	if {[S string 0 0 t {} eq Relay-Version:]} {
		>
			emit {old news text}
			mime message/rfc822
		<
	}
	
	if {[S string 0 0 t {} eq \#!\ rnews]} {
		>
			emit {batched news text}
			mime message/rfc822
		<
	}
	
	if {[S string 0 0 t {} eq N\#!\ rnews]} {
		>
			emit {mailed, batched news text}
			mime message/rfc822
		<
	}
	
	if {[S string 0 0 t {} eq Forward\ to]} {
		>
			emit {mail forwarding text}
			mime message/rfc822
		<
	}
	
	if {[S string 0 0 t {} eq Pipe\ to]} {
		>
			emit {mail piping text}
			mime message/rfc822
		<
	}
	
	if {[S string 0 0 {t c} {} eq delivered-to:]} {
		>
			emit {SMTP mail text}
			mime message/rfc822
		<
	}
	
	if {[S string 0 0 {t c} {} eq return-path:]} {
		>
			emit {SMTP mail text}
			mime message/rfc822
		<
	}
	
	if {[S string 0 0 t {} eq Path:]} {
		>
			emit {news text}
			mime message/news
		<
	}
	
	if {[S string 0 0 t {} eq Xref:]} {
		>
			emit {news text}
			mime message/news
		<
	}
	
	if {[S string 0 0 t {} eq From:]} {
		>
			emit {news or mail text}
			mime message/rfc822
		<
	}
	
	if {[S string 0 0 t {} eq Article]} {
		>
			emit {saved news text}
			mime message/news
		<
	}
	
	if {[S string 0 0 t {} eq BABYL]} {
		>
			emit {Emacs RMAIL text}
		<
	}
	
	if {[S string 0 0 t {} eq Received:]} {
		>
			emit {RFC 822 mail text}
			mime message/rfc822
		<
	}
	
	if {[S string 0 0 t {} eq MIME-Version:]} {
		>
			emit {MIME entity text}
		<
	}
	
	if {[S string 0 0 {} {} eq *mbx*]} {
		>
			emit {MBX mail folder}
		<
	}
	
	if {[S string 0 0 {} {} eq \241\002\213\015skiplist\ file\0\0\0]} {
		>
			emit {Cyrus skiplist DB}
		<
	}
	
	if {[S string 0 0 {} {} eq \241\002\213\015twoskip\ file\0\0\0\0]} {
		>
			emit {Cyrus twoskip DB}
		<
	}
	
	if {[S string 0 0 {} {} eq JAM\0]} {
		>
			emit {JAM message area header file}
			if {[N leshort 12 0 0 {} {} > 0]} {
				>
					emit {(%d messages)}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq CyrSBytecode]} {
		>
			emit {Cyrus sieve bytecode data,}
			if {[N belong 12 0 0 {} {} == 1]} {
				>
					emit {version 1, big-endian}
				<
			}
	
			if {[N lelong 12 0 0 {} {} == 1]} {
				>
					emit {version 1, little-endian}
				<
			}
	
			if {[N belong 12 0 0 {} {} x {}]} {
				>
					emit {version %d, network-endian}
				<
			}
	
		<
	}
	
	if {[S regex 0 0 l 100 eq ^CFLAGS]} {
		>
			emit {makefile script text}
			mime text/x-makefile
		<
	}
	
	if {[S regex 0 0 l 100 eq ^VPATH]} {
		>
			emit {makefile script text}
			mime text/x-makefile
		<
	}
	
	if {[S regex 0 0 l 100 eq ^LDFLAGS]} {
		>
			emit {makefile script text}
			mime text/x-makefile
		<
	}
	
	if {[S regex 0 0 l 100 eq ^all:]} {
		>
			emit {makefile script text}
			mime text/x-makefile
		<
	}
	
	if {[S regex 0 0 l 100 eq ^\\.PRECIOUS]} {
		>
			emit {makefile script text}
			mime text/x-makefile
		<
	}
	
	if {[S regex 0 0 l 100 eq ^\\.BEGIN]} {
		>
			emit {BSD makefile script text}
			mime text/x-makefile
			ext /mk
			strength +10
		<
	}
	
	if {[S regex 0 0 l 100 eq ^\\.include]} {
		>
			emit {BSD makefile script text}
			mime text/x-makefile
			ext /mk
			strength +10
		<
	}
	
	if {[S regex 0 0 l 100 eq ^\\.endif]} {
		>
			emit {BSD makefile script text}
			mime text/x-makefile
			ext /mk
			strength +10
		<
	}
	
	if {[S regex 0 0 l 100 eq ^SUBDIRS]} {
		>
			emit {automake makefile script text}
			mime text/x-makefile
			strength +10
		<
	}
	
	if {[S string 8 0 {} {} eq .FIT]} {
		>
			emit {FIT Map data}
			if {[N byte 15 0 0 {} {} == 0]} {
				>
					if {[N belong 35 0 0 {} {} x {}]} {
						>
							emit {\b, unit id %d}
						<
					}
	
					if {[N lelong 39 0 0 {} {} x {}]} {
						>
							emit {\b, serial %u}
						<
					}
	
					if {[N leldate 43 0 0 + 631065600 x {}]} {
						>
							emit {\b, %s}
						<
					}
	
					if {[N leshort 47 0 0 {} {} x {}]} {
						>
							emit {\b, manufacturer %d}
						<
					}
	
					if {[N leshort 47 0 0 {} {} == 1]} {
						>
							emit {\b (garmin)}
						<
					}
	
					if {[N leshort 49 0 0 {} {} x {}]} {
						>
							emit {\b, product %d}
						<
					}
	
					if {[N byte 53 0 0 {} {} x {}]} {
						>
							emit {\b, type %d}
						<
					}
	
					switch [Nv byte 53 0 {} {}] {
						1 {
							>
								emit {\b (Device)}
							<
						}
						2 {
							>
								emit {\b (Settings)}
							<
						}
						3 {
							>
								emit {\b (Sports/Cycling)}
							<
						}
						4 {
							>
								emit {\b (Activity)}
							<
						}
						8 {
							>
								emit {\b (Elevations)}
							<
						}
						10 {
							>
								emit {\b (Totals)}
							<
						}
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \000MVR4\nI]} {
		>
			emit {MapleVr4 library}
		<
	}
	
	if {[S string 0 0 {} {} eq \000\004\000\000]} {
		>
			emit {Maple help database}
		<
	}
	
	if {[S string 0 0 {} {} eq <PACKAGE=]} {
		>
			emit {Maple help file}
		<
	}
	
	if {[S string 0 0 {} {} eq <HELP\ NAME=]} {
		>
			emit {Maple help file}
		<
	}
	
	if {[S string 0 0 {} {} eq \n<HELP\ NAME=]} {
		>
			emit {Maple help file with extra carriage return at start (yuck)}
		<
	}
	
	if {[S string 0 0 {} {} eq \#\ daub]} {
		>
			emit {Maple help file, old style}
		<
	}
	
	if {[S string 0 0 {} {} eq \000\000\001\044\000\221]} {
		>
			emit {Maple worksheet}
		<
	}
	
	if {[S string 0 0 {} {} eq WriteNow\000\002\000\001\000\000\000\000\100\000\000\000\000\000]} {
		>
			emit {Maple worksheet, but weird}
		<
	}
	
	if {[S string 0 0 {} {} eq \{VERSION\ ]} {
		>
			emit {Maple worksheet}
			if {[S string 9 0 {} {} > \0]} {
				>
					emit {version %.1s.}
					if {[S string 11 0 {} {} > \0]} {
						>
							emit %.1s
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \0\0\001\$]} {
		>
			emit {Maple something}
			if {[S string 4 0 {} {} eq \000\105]} {
				>
					emit {An old revision}
				<
			}
	
			if {[S string 4 0 {} {} eq \001\122]} {
				>
					emit {The latest save}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \#\n\#\#\ <SHAREFILE=]} {
		>
			emit {Maple something}
		<
	}
	
	if {[S string 0 0 {} {} eq \n\#\n\#\#\ <SHAREFILE=]} {
		>
			emit {Maple something}
		<
	}
	
	if {[S string 0 0 {} {} eq \#\#\ <SHAREFILE=]} {
		>
			emit {Maple something}
		<
	}
	
	if {[S string 0 0 {} {} eq \#\r\#\#\ <SHAREFILE=]} {
		>
			emit {Maple something}
		<
	}
	
	if {[S string 0 0 {} {} eq \r\#\r\#\#\ <SHAREFILE=]} {
		>
			emit {Maple something}
		<
	}
	
	if {[S string 0 0 {} {} eq \#\ \r\#\#\ <DESCRIBE>]} {
		>
			emit {Maple something anomalous.}
		<
	}
	
	if {[S string 20 0 {} {} eq 45]} {
		>
			if {[S search 0 0 {} 2048 eq \x1e]} {
				>
					if {[S regex 0 0 l 1 eq (^\[0-9\]\{5\})\[acdnp\]\[^bhlnqsu-z\]]} {
						>
							emit {MARC21 Bibliographic}
							mime application/marc
						<
					}
	
					if {[S regex 0 0 l 1 eq (^\[0-9\]\{5\})\[acdnosx\]\[z\]]} {
						>
							emit {MARC21 Authority}
							mime application/marc
						<
					}
	
					if {[S regex 0 0 l 1 eq (^\[0-9\]\{5\})\[cdn\]\[uvxy\]]} {
						>
							emit {MARC21 Holdings}
							mime application/marc
						<
					}
	
					if {[S regex 0 0 l 1 eq (^\[0-9\]\{5\})\[acdn\]\[w\]]} {
						>
							emit {MARC21 Classification}
							mime application/marc
						<
					}
	
					if {[S regex 0 0 l 1 eq (^\[0-9\]\{5\})\[cdn\]\[q\]]} {
						>
							emit {MARC21 Community}
							mime application/marc
						<
					}
	
					if {[S regex 0 0 l 1 eq (^.\{21\})(\[^0\]\{2\})]} {
						>
							emit (non-conforming)
							mime application/marc
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq .MCAD\t]} {
		>
			emit {Mathcad document}
		<
	}
	
	if {[S string 0 0 {} {} eq \064\024\012\000\035\000\000\000]} {
		>
			emit {Mathematica version 2 notebook}
			ext mb
		<
	}
	
	if {[S string 0 0 {} {} eq \064\024\011\000\035\000\000\000]} {
		>
			emit {Mathematica version 2 notebook}
			ext mb
		<
	}
	
	if {[S string 0 0 {} {} eq (*^\n\n::\[\011frontEndVersion\ =\ ]} {
		>
			emit {Mathematica notebook}
			ext mb
		<
	}
	
	if {[S string 0 0 {} {} eq (*^\r\r::\[\011]} {
		>
			emit {Mathematica notebook version 2.x}
			ext mb
		<
	}
	
	if {[S string 0 0 {} {} eq (*^\r\n\r\n::\[\011]} {
		>
			emit {Mathematica notebook version 2.x}
			ext mb
		<
	}
	
	if {[S string 0 0 {} {} eq (*^\015]} {
		>
			emit {Mathematica notebook version 2.x}
			ext mb
		<
	}
	
	if {[S string 0 0 {} {} eq (*^\n\r\n\r::\[\011]} {
		>
			emit {Mathematica notebook version 2.x}
			ext mb
		<
	}
	
	if {[S string 0 0 {} {} eq (*^\r::\[\011]} {
		>
			emit {Mathematica notebook version 2.x}
			ext mb
		<
	}
	
	if {[S string 0 0 {} {} eq (*^\r\n::\[\011]} {
		>
			emit {Mathematica notebook version 2.x}
			ext mb
		<
	}
	
	if {[S string 0 0 {} {} eq (*^\n\n::\[\011]} {
		>
			emit {Mathematica notebook version 2.x}
			ext mb
		<
	}
	
	if {[S string 0 0 {} {} eq (*^\n::\[\011]} {
		>
			emit {Mathematica notebook version 2.x}
			ext mb
		<
	}
	
	if {[S string 0 0 {} {} eq (*This\ is\ a\ Mathematica\ binary\ ]} {
		>
			emit {Mathematica binary file}
			if {[S string 88 0 {} {} > \0]} {
				>
					emit {from %s}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq MMAPBF\000\001\000\000\000\203\000\001\000]} {
		>
			emit {Mathematica PBF (fonts I think)}
		<
	}
	
	if {[S string 4 0 {} {} eq \ A~]} {
		>
			emit {MAthematica .ml file}
		<
	}
	
	if {[S string 0 0 {} {} eq (***********************]} {
		>
			emit {Mathematica 3.0 notebook}
		<
	}
	
	if {[S string 0 0 {} {} eq MATLAB]} {
		>
			emit {Matlab v5 mat-file}
			switch [Nv short 126 0 {} {}] {
				18765 {
					>
						emit {(big endian)}
						if {[N beshort 124 0 0 {} {} x {}]} {
							>
								emit {version 0x%04x}
							<
						}
	
					<
				}
				19785 {
					>
						emit {(little endian)}
						if {[N leshort 124 0 0 {} {} x {}]} {
							>
								emit {version 0x%04x}
							<
						}
	
					<
				}
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \0m\3]} {
		>
			emit {mcrypt 2.5 encrypted data,}
			if {[S string 4 0 {} {} > \0]} {
				>
					emit {algorithm: %s,}
					if {[N leshort [R 1] 0 0 {} {} > 0]} {
						>
							emit {keysize: %d bytes,}
							if {[S string [R 0] 0 {} {} > \0]} {
								>
									emit {mode: %s,}
								<
							}
	
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \0m\2]} {
		>
			emit {mcrypt 2.2 encrypted data,}
			switch [Nv byte 3 0 {} {}] {
				0 {
					>
						emit {algorithm: blowfish-448,}
					<
				}
				1 {
					>
						emit {algorithm: DES,}
					<
				}
				2 {
					>
						emit {algorithm: 3DES,}
					<
				}
				3 {
					>
						emit {algorithm: 3-WAY,}
					<
				}
				4 {
					>
						emit {algorithm: GOST,}
					<
				}
				6 {
					>
						emit {algorithm: SAFER-SK64,}
					<
				}
				7 {
					>
						emit {algorithm: SAFER-SK128,}
					<
				}
				8 {
					>
						emit {algorithm: CAST-128,}
					<
				}
				9 {
					>
						emit {algorithm: xTEA,}
					<
				}
				10 {
					>
						emit {algorithm: TWOFISH-128,}
					<
				}
				11 {
					>
						emit {algorithm: RC2,}
					<
				}
				12 {
					>
						emit {algorithm: TWOFISH-192,}
					<
				}
				13 {
					>
						emit {algorithm: TWOFISH-256,}
					<
				}
				14 {
					>
						emit {algorithm: blowfish-128,}
					<
				}
				15 {
					>
						emit {algorithm: blowfish-192,}
					<
				}
				16 {
					>
						emit {algorithm: blowfish-256,}
					<
				}
				100 {
					>
						emit {algorithm: RC6,}
					<
				}
				101 {
					>
						emit {algorithm: IDEA,}
					<
				}
			}
	
			switch [Nv byte 4 0 {} {}] {
				0 {
					>
						emit {mode: CBC,}
					<
				}
				1 {
					>
						emit {mode: ECB,}
					<
				}
				2 {
					>
						emit {mode: CFB,}
					<
				}
				3 {
					>
						emit {mode: OFB,}
					<
				}
				4 {
					>
						emit {mode: nOFB,}
					<
				}
			}
	
			switch [Nv byte 5 0 {} {}] {
				0 {
					>
						emit {keymode: 8bit}
					<
				}
				1 {
					>
						emit {keymode: 4bit}
					<
				}
				2 {
					>
						emit {keymode: SHA-1 hash}
					<
				}
				3 {
					>
						emit {keymode: MD5 hash}
					<
				}
			}
	
		<
	}
	
	if {[N ubyte 38408 0 0 {} {} < 19]} {
		>
			U 148 diy-thermocam-checker 38400
	
		<
	}
	
	if {[N ubyte 9608 0 0 {} {} < 19]} {
		>
			U 148 diy-thermocam-checker 9600
	
		<
	}
	
	if {[S string 0 0 {} {} eq HG10]} {
		>
			emit {Mercurial changeset bundle}
			if {[S string 4 0 {} {} eq UN]} {
				>
					emit (uncompressed)
				<
			}
	
			if {[S string 4 0 {} {} eq GZ]} {
				>
					emit {(gzip compressed)}
				<
			}
	
			if {[S string 4 0 {} {} eq BZ]} {
				>
					emit {(bzip2 compressed)}
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq MeTaSt00r3]} {
		>
			emit {Metastore data file,}
			if {[N bequad 10 0 0 {} {} x {}]} {
				>
					emit {version %0llx}
				<
			}
	
		<
	}
	
	if {[S string 60 0 {} {} eq RINEX]} {
		>
			if {[S search 80 0 {} 256 eq XXRINEXB]} {
				>
					emit {RINEX Data, GEO SBAS Broadcast}
					if {[S string [R 32] 0 {} {} x {}]} {
						>
							emit {\b, date %15.15s}
						<
					}
	
					if {[S string 5 0 {} {} x {}]} {
						>
							emit {\b, version %6.6s}
							mime rinex/broadcast
						<
					}
	
				<
			}
	
			if {[S search 80 0 {} 256 eq XXRINEXD]} {
				>
					emit {RINEX Data, Observation (Hatanaka comp)}
					if {[S string [R 32] 0 {} {} x {}]} {
						>
							emit {\b, date %15.15s}
						<
					}
	
					if {[S string 5 0 {} {} x {}]} {
						>
							emit {\b, version %6.6s}
							mime rinex/observation
						<
					}
	
				<
			}
	
			if {[S search 80 0 {} 256 eq XXRINEXC]} {
				>
					emit {RINEX Data, Clock}
					if {[S string [R 32] 0 {} {} x {}]} {
						>
							emit {\b, date %15.15s}
						<
					}
	
					if {[S string 5 0 {} {} x {}]} {
						>
							emit {\b, version %6.6s}
							mime rinex/clock
						<
					}
	
				<
			}
	
			if {[S search 80 0 {} 256 eq XXRINEXH]} {
				>
					emit {RINEX Data, GEO SBAS Navigation}
					if {[S string [R 32] 0 {} {} x {}]} {
						>
							emit {\b, date %15.15s}
						<
					}
	
					if {[S string 5 0 {} {} x {}]} {
						>
							emit {\b, version %6.6s}
							mime rinex/navigation
						<
					}
	
				<
			}
	
			if {[S search 80 0 {} 256 eq XXRINEXG]} {
				>
					emit {RINEX Data, GLONASS Navigation}
					if {[S string [R 32] 0 {} {} x {}]} {
						>
							emit {\b, date %15.15s}
						<
					}
	
					if {[S string 5 0 {} {} x {}]} {
						>
							emit {\b, version %6.6s}
							mime rinex/navigation
						<
					}
	
				<
			}
	
			if {[S search 80 0 {} 256 eq XXRINEXL]} {
				>
					emit {RINEX Data, Galileo Navigation}
					if {[S string [R 32] 0 {} {} x {}]} {
						>
							emit {\b, date %15.15s}
						<
					}
	
					if {[S string 5 0 {} {} x {}]} {
						>
							emit {\b, version %6.6s}
							mime rinex/navigation
						<
					}
	
				<
			}
	
			if {[S search 80 0 {} 256 eq XXRINEXM]} {
				>
					emit {RINEX Data, Meteorological}
					if {[S string [R 32] 0 {} {} x {}]} {
						>
							emit {\b, date %15.15s}
						<
					}
	
					if {[S string 5 0 {} {} x {}]} {
						>
							emit {\b, version %6.6s}
							mime rinex/meteorological
						<
					}
	
				<
			}
	
			if {[S search 80 0 {} 256 eq XXRINEXN]} {
				>
					emit {RINEX Data, Navigation}
					if {[S string [R 32] 0 {} {} x {}]} {
						>
							emit {\b, date %15.15s}
						<
					}
	
					if {[S string 5 0 {} {} x {}]} {
						>
							emit {\b, version %6.6s}
							mime rinex/navigation
						<
					}
	
				<
			}
	
			if {[S search 80 0 {} 256 eq XXRINEXO]} {
				>
					emit {RINEX Data, Observation}
					if {[S string [R 32] 0 {} {} x {}]} {
						>
							emit {\b, date %15.15s}
						<
					}
	
					if {[S string 5 0 {} {} x {}]} {
						>
							emit {\b, version %6.6s}
							mime rinex/observation
						<
					}
	
				<
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq GRIB]} {
		>
			switch [Nv byte 7 0 {} {}] {
				1 {
					>
						emit {Gridded binary (GRIB) version 1}
					<
				}
				2 {
					>
						emit {Gridded binary (GRIB) version 2}
					<
				}
			}
	
		<
	}
	
	if {[S string 0 0 {} {} eq \x30\x00\x00\x7C]} {
		>
			if {[S string 36 0 {} {} eq \x00\x3E]} {
				>
					emit {Micro Focus File with Header (DAT)}
					mime application/octet-stream
				<
			}
	
		<
	}
	
		>
				>
				<
			}
	
		<
	}
	
