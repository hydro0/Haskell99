{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_Haskell99 (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/orestsavchak/Library/Haskell/bin"
libdir     = "/Users/orestsavchak/Library/Haskell/ghc-8.0.2-x86_64/lib/Haskell99-0.1.0.0"
dynlibdir  = "/Users/orestsavchak/Library/Haskell/ghc-8.0.2-x86_64/lib/x86_64-osx-ghc-8.0.2"
datadir    = "/Users/orestsavchak/Library/Haskell/share/ghc-8.0.2-x86_64/Haskell99-0.1.0.0"
libexecdir = "/Users/orestsavchak/Library/Haskell/libexec"
sysconfdir = "/Users/orestsavchak/Library/Haskell/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "Haskell99_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "Haskell99_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "Haskell99_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "Haskell99_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "Haskell99_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "Haskell99_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
