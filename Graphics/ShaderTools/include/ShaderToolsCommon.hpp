/*
 *  Copyright 2019-2022 Diligent Graphics LLC
 *  Copyright 2015-2019 Egor Yusov
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *
 *  In no event and under no legal theory, whether in tort (including negligence),
 *  contract, or otherwise, unless required by applicable law (such as deliberate
 *  and grossly negligent acts) or agreed to in writing, shall any Contributor be
 *  liable for any damages, including any direct, indirect, special, incidental,
 *  or consequential damages of any character arising as a result of this License or
 *  out of the use or inability to use the software (including but not limited to damages
 *  for loss of goodwill, work stoppage, computer failure or malfunction, or any and
 *  all other commercial damages or losses), even if such Contributor has been advised
 *  of the possibility of such damages.
 */

#pragma once

#include "GraphicsTypes.h"
#include "Shader.h"
#include "RefCntAutoPtr.hpp"
#include "DataBlob.h"

namespace Diligent
{

/// Returns shader type definition macro(s), e.g., for a vertex shader:
///
///     {"VERTEX_SHADER", "1"}, {nullptr, nullptr}
///
/// or, for a fragment shader:
///
///     {"FRAGMENT_SHADER", "1"}, {"PIXEL_SHADER", "1"}, {nullptr, nullptr}
///
/// etc.
const ShaderMacro* GetShaderTypeMacros(SHADER_TYPE Type);


/// Appends shader macro definitions to the end of the source string:
///
///     #define Name[0] Definition[0]
///     #define Name[1] Definition[1]
///     ...
void AppendShaderMacros(std::string& Source, const ShaderMacro* Macros);


/// Appends the shader type definition macro(s), e.g., for a vertex shader:
///
///     #define VERTEX_SHADER 1
///
/// or, for a fragment shader:
///
///     #define FRAGMENT_SHADER 1
///     #define PIXEL_SHADER 1
///
/// etc.
void AppendShaderTypeDefinitions(std::string& Source, SHADER_TYPE Type);


/// Reads shader source code from a file or uses the one from the shader create info
const char* ReadShaderSourceFile(const char*                      SourceCode,
                                 IShaderSourceInputStreamFactory* pShaderSourceStreamFactory,
                                 const char*                      FilePath,
                                 RefCntAutoPtr<IDataBlob>&        pFileData,
                                 size_t&                          SourceCodeLen) noexcept(false);

/// Appends shader source code to the source string
void AppendShaderSourceCode(std::string& Source, const ShaderCreateInfo& ShaderCI) noexcept(false);


} // namespace Diligent
